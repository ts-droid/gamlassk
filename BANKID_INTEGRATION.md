# BankID Integration via OpenID Connect

## Översikt

Detta dokument beskriver hur man integrerar BankID-inloggning på Gamla SSK:s webbplats genom att använda en extern identitetsleverantör (OIDC provider). Detta är den **rekommenderade lösningen** enligt BankID:s bästa praxis.

## Varför OIDC-baserad lösning?

✅ **Fördelar:**
- Inga servercertifikat eller mutual TLS krävs
- Du slipper implementera BankID:s QR-protokoll
- Mycket mindre backend-logik
- Bättre användarupplevelse - fungerande BankID-flöde direkt
- Snabb implementering med färdiga SDK:er
- Automatiska uppdateringar när BankID ändrar sina krav

❌ **Vad du slipper:**
- Generera och uppdatera QR-koder enligt BankID-protokollet
- Installera och hantera BankID-servercertifikat
- Polla BankID /collect manuellt
- Hantera hintCodes, errorCodes och udda BankID-fel

## Rekommenderade leverantörer

Välj en av följande etablerade identitetsleverantörer:

### 1. Criipto (Rekommenderas)
- **Webbplats:** https://www.criipto.com/
- **Fördelar:** Specialiserad på nordiska e-legitimationer, bra dokumentation
- **Pris:** Från ~500 SEK/månad för små volymer
- **Dokumentation:** https://docs.criipto.com/

### 2. Signicat
- **Webbplats:** https://www.signicat.com/
- **Fördelar:** Stor aktör i Norden, omfattande funktioner
- **Pris:** Kontakta för offert

### 3. ZignSec
- **Webbplats:** https://www.zignsec.com/
- **Fördelar:** Svensk leverantör, fokus på identitetsverifiering
- **Pris:** Kontakta för offert

### 4. GrandID / Enidentitet
- **Webbplats:** https://www.grandid.com/
- **Fördelar:** Svensk leverantör, enkel integration
- **Pris:** Ca 1-3 SEK per autentisering

## Implementeringsflöde

### Steg 1: Registrera hos OIDC-leverantör

1. Skapa konto hos vald leverantör (t.ex. Criipto)
2. Registrera din applikation
3. Konfigurera callback URL: `https://din-sajt.se/auth/bankid/callback`
4. Få Client ID och Client Secret
5. Notera Issuer URL (t.ex. `https://your-domain.criipto.id`)

### Steg 2: Lägg till miljövariabler

Lägg till följande i Management UI → Settings → Secrets:

```
BANKID_ENABLED=true
BANKID_CLIENT_ID=din-client-id-från-leverantör
BANKID_CLIENT_SECRET=din-client-secret-från-leverantör
BANKID_ISSUER_URL=https://your-domain.criipto.id
BANKID_CALLBACK_URL=https://din-sajt.se/auth/bankid/callback
```

### Steg 3: Installera OIDC-bibliotek

```bash
cd /home/ubuntu/gamla-ssk-website
pnpm add openid-client
```

### Steg 4: Backend-implementation

Skapa en ny fil `server/bankid.ts`:

```typescript
import { Issuer, Client } from 'openid-client';

let bankidClient: Client | null = null;

export async function getBankIDClient(): Promise<Client | null> {
  if (!process.env.BANKID_ENABLED || process.env.BANKID_ENABLED !== 'true') {
    return null;
  }

  if (bankidClient) {
    return bankidClient;
  }

  try {
    const issuer = await Issuer.discover(process.env.BANKID_ISSUER_URL!);
    
    bankidClient = new issuer.Client({
      client_id: process.env.BANKID_CLIENT_ID!,
      client_secret: process.env.BANKID_CLIENT_SECRET!,
      redirect_uris: [process.env.BANKID_CALLBACK_URL!],
      response_types: ['code'],
    });

    return bankidClient;
  } catch (error) {
    console.error('[BankID] Failed to initialize client:', error);
    return null;
  }
}
```

Lägg till routes i `server/routers.ts`:

```typescript
bankid: router({
  // Check if BankID is enabled
  isEnabled: publicProcedure.query(() => {
    return { enabled: process.env.BANKID_ENABLED === 'true' };
  }),

  // Initiate BankID login
  login: publicProcedure.mutation(async ({ ctx }) => {
    const client = await getBankIDClient();
    if (!client) {
      throw new TRPCError({ code: 'NOT_FOUND', message: 'BankID not configured' });
    }

    const authUrl = client.authorizationUrl({
      scope: 'openid profile',
      state: crypto.randomBytes(16).toString('hex'),
    });

    return { url: authUrl };
  }),

  // Handle callback (this would be a separate Express route)
  // See server/_core/index.ts for implementation
}),
```

### Steg 5: Frontend-implementation

Uppdatera inloggningssidan för att visa BankID-knapp:

```typescript
// client/src/pages/Login.tsx
const { data: bankidConfig } = trpc.bankid.isEnabled.useQuery();
const loginWithBankID = trpc.bankid.login.useMutation();

// Visa BankID-knapp om aktiverad
{bankidConfig?.enabled && (
  <Button
    onClick={async () => {
      const result = await loginWithBankID.mutateAsync();
      window.location.href = result.url;
    }}
    className="w-full bg-[#0066CC] hover:bg-[#0052A3]"
  >
    <img src="/bankid-logo.svg" alt="BankID" className="h-5 mr-2" />
    Logga in med BankID
  </Button>
)}
```

## Användarflöde

1. Användaren klickar "Logga in med BankID"
2. Backend genererar authorization URL och redirectar användaren
3. Användaren redirectas till OIDC-leverantörens inloggningssida
4. Användaren legitimerar sig med BankID-appen
5. Efter godkänd legitimering redirectas användaren tillbaka till `callback_url`
6. Backend tar emot authorization code och byter det mot ID-token
7. Personnummer och namn extraheras från ID-token
8. Användare skapas/uppdateras i databasen med `loginMethod: 'bankid'`
9. Session sätts och användaren är inloggad

## Datahantering

ID-token från BankID via OIDC innehåller:
- `sub`: Personnummer (format: SE199001011234)
- `name`: För- och efternamn
- `given_name`: Förnamn
- `family_name`: Efternamn

Denna data mappas till användarens profil i databasen.

## Säkerhet

- ✅ All kommunikation sker över HTTPS
- ✅ ID-tokens valideras kryptografiskt
- ✅ Personnummer lagras säkert i databasen
- ✅ Sessions hanteras med säkra HTTP-only cookies
- ✅ CSRF-skydd via state-parameter

## Kostnader

Kostnaden varierar beroende på leverantör och antal inloggningar:

- **Criipto:** Från ~500 SEK/månad för små volymer
- **GrandID:** Ca 1-3 SEK per autentisering
- **Andra leverantörer:** Kontakta för offert

Många leverantörer erbjuder **gratis testmiljö** för utveckling.

## Testning

1. Använd leverantörens testmiljö
2. Testa med BankID Test-app (finns i App Store/Google Play)
3. Verifiera att användare skapas korrekt i databasen
4. Testa både mobil och desktop-flöden

## Support och dokumentation

- **BankID officiell dokumentation:** https://developers.bankid.com/
- **Criipto dokumentation:** https://docs.criipto.com/
- **OpenID Connect specifikation:** https://openid.net/connect/
- **openid-client library:** https://github.com/panva/node-openid-client

## Nuvarande status

Projektet använder för närvarande lokal inloggning med e-post/lösenord och kan även ha Google-inloggning aktiverad. BankID kan läggas till som ett **alternativt inloggningssätt** utan att påverka befintliga användare.

## Implementationsstatus

- ✅ Dokumentation skapad
- ⏳ OIDC-leverantör ej vald
- ⏳ Miljövariabler ej konfigurerade
- ⏳ Backend-kod ej implementerad
- ⏳ Frontend-knapp ej implementerad

## Nästa steg

1. ✅ Välj OIDC-leverantör (rekommendation: Criipto)
2. ✅ Registrera applikation hos leverantören
3. ✅ Lägg till miljövariabler i Management UI → Settings → Secrets
4. ✅ Installera `openid-client` bibliotek
5. ✅ Implementera backend-kod enligt ovan
6. ✅ Lägg till BankID-knapp i frontend
7. ✅ Testa i testmiljö
8. ✅ Gå live!

## Vanliga frågor

**Q: Kan vi använda BankID direkt utan leverantör?**
A: Ja, men det kräver mycket mer arbete: servercertifikat, QR-kod-generering, polling av BankID-API, felhantering, etc. OIDC-lösningen är starkt rekommenderad.

**Q: Vad händer med befintliga användare?**
A: Användare som redan har konto kan fortsätta använda sina befintliga inloggningssätt. BankID blir ett alternativt inloggningssätt.

**Q: Kan vi koppla BankID till befintliga konton?**
A: Ja, detta kan implementeras genom att matcha personnummer eller email när användaren loggar in första gången med BankID.

**Q: Fungerar det på mobil?**
A: Ja, BankID fungerar utmärkt på både mobil och desktop. På mobil öppnas BankID-appen automatiskt.

**Q: Behöver vi avtal med BankID?**
A: Nej, när du använder en OIDC-leverantör har de redan avtal med BankID. Du behöver bara avtal med leverantören.

## Kontakt för hjälp

För frågor om implementation, kontakta:
- Leverantörens support (t.ex. support@criipto.com)
- BankID:s utvecklarsupport: https://developers.bankid.com/

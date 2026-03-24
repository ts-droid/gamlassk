# Criipto Setup Guide - Steg för Steg

## Steg 1: Konfigurera din Criipto Application

### 1.1 Logga in på Criipto
1. Gå till https://dashboard.criipto.com/
2. Logga in med ditt konto

### 1.2 Skapa eller välj din Application
1. I dashboard, gå till **Applications** i sidomenyn
2. Om du inte har en application än:
   - Klicka på **"Create Application"**
   - Ge den ett namn, t.ex. "Gamla SSK Website"
   - Välj **"Regular Web Application"** som typ
   - Klicka **"Create"**

### 1.3 Konfigurera Application Settings

#### Callback URLs
Lägg till följande callback URL (viktigt att den är exakt rätt!):

**För testmiljö (Manus):**
```
https://3000-i53se25uwtmhoenn5jrnu-2424d9db.manusvm.computer/auth/bankid/callback
```

**För produktion (när du publicerar):**
```
https://ditt-domännamn.manus.space/auth/bankid/callback
```

> **Viktigt:** Du kan lägga till flera callback URLs separerade med komma eller radbrytning.

#### Logout URLs (valfritt)
```
https://3000-i53se25uwtmhoenn5jrnu-2424d9db.manusvm.computer
```

#### Allowed Origins (CORS)
```
https://3000-i53se25uwtmhoenn5jrnu-2424d9db.manusvm.computer
```

### 1.4 Aktivera BankID
1. Gå till fliken **"Identity Sources"** eller **"eID Methods"**
2. Leta efter **"Swedish BankID"**
3. Aktivera den genom att klicka på toggle-knappen
4. Välj **"BankID på samma enhet"** och/eller **"BankID på annan enhet"** (rekommenderas båda)

### 1.5 Hämta credentials
1. Gå tillbaka till **"Settings"** eller **"General"** fliken
2. Hitta och kopiera följande värden:

   - **Client ID** (kallas ibland "Application ID")
   - **Client Secret** (klicka "Show" för att se den)
   - **Domain** (t.ex. `gamla-ssk.criipto.id` eller liknande)

> **Viktigt:** Spara dessa värden säkert! Du kommer att behöva dem i nästa steg.

---

## Steg 2: Lägg till credentials i Manus

### 2.1 Öppna Management UI
1. I Manus chatbox, klicka på ikonen längst upp till höger för att öppna Management UI
2. Gå till **Settings** → **Secrets**

### 2.2 Lägg till följande miljövariabler

Klicka på **"Add Secret"** för varje variabel:

#### 1. BANKID_ENABLED
- **Key:** `BANKID_ENABLED`
- **Value:** `true`

#### 2. BANKID_CLIENT_ID
- **Key:** `BANKID_CLIENT_ID`
- **Value:** [Din Client ID från Criipto]

#### 3. BANKID_CLIENT_SECRET
- **Key:** `BANKID_CLIENT_SECRET`
- **Value:** [Din Client Secret från Criipto]

#### 4. BANKID_ISSUER_URL
- **Key:** `BANKID_ISSUER_URL`
- **Value:** `https://[din-domain].criipto.id`
  - Exempel: `https://gamla-ssk.criipto.id`

#### 5. BANKID_CALLBACK_URL
- **Key:** `BANKID_CALLBACK_URL`
- **Value:** `https://3000-i53se25uwtmhoenn5jrnu-2424d9db.manusvm.computer/auth/bankid/callback`

> **Tips:** Kopiera exakt URL från din dev server i Manus.

---

## Steg 3: Verifiera inställningarna

### Kontrollera att alla värden är korrekta:

| Variabel | Exempel värde |
|----------|---------------|
| BANKID_ENABLED | `true` |
| BANKID_CLIENT_ID | `urn:criipto:client:abc123...` |
| BANKID_CLIENT_SECRET | `secret_xyz789...` |
| BANKID_ISSUER_URL | `https://gamla-ssk.criipto.id` |
| BANKID_CALLBACK_URL | `https://3000-i53se25uwtmhoenn5jrnu-2424d9db.manusvm.computer/auth/bankid/callback` |

---

## Steg 4: Meddela mig när du är klar

När du har lagt till alla miljövariabler i Manus, skriv bara **"Klart!"** eller **"Credentials tillagda"** så implementerar jag BankID-funktionaliteten direkt.

---

## Felsökning

### Problem: "Invalid redirect_uri"
- **Lösning:** Kontrollera att callback URL i Criipto exakt matchar den du lagt till i miljövariablerna

### Problem: "Client authentication failed"
- **Lösning:** Dubbelkolla att Client ID och Client Secret är korrekt kopierade utan extra mellanslag

### Problem: "Issuer not found"
- **Lösning:** Kontrollera att BANKID_ISSUER_URL har rätt format: `https://[domain].criipto.id` (utan trailing slash)

### Problem: BankID-knappen visas inte
- **Lösning:** Kontrollera att `BANKID_ENABLED=true` är satt

---

## Testmiljö vs Produktion

### Testmiljö (nu)
Criipto erbjuder automatiskt en testmiljö där du kan:
- Testa BankID-flödet med BankID Test-app
- Ladda ner BankID Test-app från App Store/Google Play
- Använd test-personnummer som Criipto tillhandahåller

### Produktion (senare)
När du publicerar webbplatsen:
1. Uppdatera callback URL i Criipto till din produktions-URL
2. Uppdatera `BANKID_CALLBACK_URL` miljövariabel i Manus
3. BankID kommer då att fungera med riktiga BankID-appar

---

## Support

Om du stöter på problem:
- **Criipto Support:** https://docs.criipto.com/
- **Criipto Dashboard:** https://dashboard.criipto.com/
- **Meddela mig:** Beskriv problemet så hjälper jag dig!

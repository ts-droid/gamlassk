# E-postnotifikationer - Uppsättning

## Översikt

För att aktivera e-postnotifikationer för medlemsansökningar behöver du konfigurera en e-posttjänst. Det finns flera alternativ:

## Rekommenderade tjänster

### 1. **Resend** (Rekommenderas)
- Enkel integration med Node.js
- Gratis upp till 3,000 e-postmeddelanden/månad
- Bra för transaktionella e-postmeddelanden
- Webbplats: https://resend.com

**Installation:**
```bash
pnpm add resend
```

**Konfiguration:**
1. Skapa konto på resend.com
2. Verifiera din domän eller använd deras testdomän
3. Skapa API-nyckel
4. Lägg till i miljövariabler:
   - `RESEND_API_KEY=re_xxx`
   - `EMAIL_FROM=noreply@dindomän.se`

### 2. **SendGrid**
- Populär tjänst med bra dokumentation
- Gratis upp till 100 e-postmeddelanden/dag
- Webbplats: https://sendgrid.com

**Installation:**
```bash
pnpm add @sendgrid/mail
```

**Konfiguration:**
1. Skapa konto på sendgrid.com
2. Verifiera din domän
3. Skapa API-nyckel
4. Lägg till i miljövariabler:
   - `SENDGRID_API_KEY=SG.xxx`
   - `EMAIL_FROM=noreply@dindomän.se`

### 3. **Nodemailer** (med Gmail/SMTP)
- Gratis om du använder din egen Gmail
- Kräver SMTP-konfiguration
- Bra för enklare behov

**Installation:**
```bash
pnpm add nodemailer
```

**Konfiguration:**
1. Aktivera "App Passwords" i ditt Gmail-konto
2. Lägg till i miljövariabler:
   - `SMTP_HOST=smtp.gmail.com`
   - `SMTP_PORT=587`
   - `SMTP_USER=din@gmail.com`
   - `SMTP_PASS=ditt_app_lösenord`
   - `EMAIL_FROM=din@gmail.com`

## Implementation

När du har valt tjänst och konfigurerat API-nycklar:

1. Lägg till miljövariabler i Management UI → Settings → Secrets
2. Implementeringen finns redan i `server/routers.ts` under `membership.submit`
3. E-postmallar finns i kommentarer i koden

## E-postmallar

### Till sökande (bekräftelse)
```
Hej [Namn],

Tack för din ansökan om medlemskap i Föreningen Gamla SSK-are!

Vi har mottagit din ansökan och kommer att behandla den inom kort. 
Du kommer att få ett e-postmeddelande när din ansökan har behandlats.

Med vänliga hälsningar,
Föreningen Gamla SSK-are
```

### Till administratörer (notifikation)
```
Ny medlemsansökan mottagen!

Namn: [Namn]
E-post: [E-post]
Telefon: [Telefon]

Meddelande:
[Meddelande]

Logga in på admin-panelen för att behandla ansökan:
https://dindomän.se/admin
```

## Nästa steg

1. Välj e-posttjänst
2. Skapa konto och få API-nyckel
3. Lägg till miljövariabler
4. Testa genom att skicka en medlemsansökan
5. Verifiera att både sökande och admin får e-post

## Support

För hjälp med konfiguration, kontakta leverantörens support eller läs dokumentationen för vald tjänst.

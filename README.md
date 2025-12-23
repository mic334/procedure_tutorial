# Documentazione script `mscp.sh`

`mscp.sh` è uno script per copiare file o cartelle dal **cluster Leonardo di CINECA** alla macchina locale tramite SCP, gestendo anche eventuali cambi della chiave SSH del server.

---

## Cosa fa

- Copia file o cartelle dal percorso remoto del cluster alla tua macchina locale.
- Se il secondo argomento non viene fornito, mantiene lo stesso nome del file/cartella remota.
- Rimuove automaticamente la vecchia chiave SSH se il server ha cambiato chiave, e riprova la connessione.

---

## Come usarlo

```bash
./mscp.sh <percorso_remoto_dopo_doppi_punti> [nuovo_nome_locale]


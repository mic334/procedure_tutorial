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
./mscp.sh percorso_remoto_dopo_doppi_punti [nuovo_nome_locale]


---

## Documentation script: `super_bolo.py`

`super_bolo.py` è uno script Python per **sovrapporre due molecole** in Chimera, colorando la prima molecola di rosso e la seconda di blu.

- Il nome `super_bolo` deriva dalla combinazione di **“superposition”** (sovrapposizione molecolare) e **“Bolo”**, un riferimento ai colori **rosso e blu** (come quelli della città di Bologna).

### Cosa fa

- Sovrappone delle strutture molecolari per confronto visivo.
- Colora automaticamente le molecole: rosso per la prima, blu per la seconda.
- Ideale per visualizzare rapidamente le sovrapposizioni strutturali in Chimera.

### Come usarlo

1. Aprire le due molecole all'interno di Chimera, ad esempio:

```bash
chimera mol1.xyz mol2.xyz

2. Aprire la command line di Chiemere 

runscript /path/to/super_bolo.py

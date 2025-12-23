#!/bin/zsh
# #!/bin/bash  # uncomment for Linux
# ============================================================
#  Script: mscp.sh
#  Autore: Michele Orza
#  Data:   14 ottobre 2025
#
#  Descrizione:
#  Script per copiare file o cartelle dal cluster Leonardo di CINECA
#  alla macchina locale tramite SCP.
#
#  Attenzione in questo modo lo script è personale perchè inserisce
#  il mio utente cineca attuale morza000
#
#  Utilizzo:
#    ./mscp.sh <percorso_remoto_dopo_doppi_punti> [nuovo_nome_locale]
#
#  Se il secondo argomento non viene inserito, lo script utilizzerà
#  automaticamente lo stesso nome del file o della cartella remota.
#
#  Esempio:
#    ./mscp.sh /leonardo_work/.../4.possible_TS_22_M062X_defsvp 1.prova
#
#  In caso di cambio della chiave SSH del server remoto,
#  la chiave vecchia viene rimossa automaticamente e il comando viene ripetuto.
# ============================================================


# --- Controllo argomenti ---
if [ -z "$1" ]; then
  echo ""
  echo "❌ Errore: numero di argomenti non valido."
  echo ""
  echo "🔹 Utilizzo corretto:"
  echo "    $0 <percorso_remoto_dopo_doppi_punti> [nuovo_nome_locale]"
  echo ""
  echo "   Se non inserisci il secondo argomento, verrà usato lo stesso nome remoto."
  echo ""
  echo "🔹 Esempi:"
  echo "    $0 /leonardo_work/.../4.possible_TS_22_M062X_defsvp"
  echo "    $0 /leonardo_work/.../4.possible_TS_22_M062X_defsvp 1.prova"
  echo ""
  exit 1
fi

REMOTE_PATH="$1"
NEW_NAME="${2:-$(basename "$REMOTE_PATH")}"  # Se non specificato, mantiene il nome originale
REMOTE_USER="utente"
REMOTE_HOST="login.leonardo.cineca.it"


# --- Funzione per eseguire SCP ---
run_scp() {
  echo "🚀 Eseguo SCP da $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH a $NEW_NAME ..."
  scp -o StrictHostKeyChecking=accept-new -r "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}" "$NEW_NAME"
}

# --- Primo tentativo ---
run_scp
STATUS=$?

# --- Se fallisce per chiave host modificata ---
if [ $STATUS -ne 0 ]; then
  echo ""
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @"
  echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  echo "Rimuovo la vecchia chiave host e riprovo..."
  echo ""

  ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$REMOTE_HOST"

  echo "🔁 Riprovo lo SCP accettando automaticamente la nuova chiave..."
  scp -o StrictHostKeyChecking=accept-new -r "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}" "$NEW_NAME"
fi

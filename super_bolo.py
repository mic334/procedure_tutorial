import chimera
from chimera import runCommand

#match command
runCommand('match #0 #1')

#colora molecola
runCommand('color blue #0')
runCommand('color red #1')

#etichetta dati
runCommand('label #0')
runCommand('label #1')

#imposta schermo bianco
runCommand('background solid white')

# calcola RMSD
runCommand('rmsd #1 #0')

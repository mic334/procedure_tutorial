#!/usr/bin/python
# -*- coding: utf-8 -*-
# Nome del file: S02S1.py
# Autore: Michele Orza
# Data: 3 Ottobre 2024

import sys
import os

# Verifica se è stato passato almeno un argomento
if len(sys.argv) > 1:
    primo_argomento = sys.argv[1]
    print(f"L'argomento passato è: {primo_argomento}")
else:
    print("Nessun argomento passato.")

# head dei file
headgaussian='%nprocshared=12' + '\n'  '%mem=12GB' + '\n' '%chk=optdft.chk'   + '\n' '#p opt M062X def2SVP empiricaldispersion=GD3 SCRF(solvent=water) ' + '\n' '' +'\n' 'titolo' + '\n' '' + '\n' '1 2'  
headslurm= '#!/bin/bash' +  '\n' '#SBATCH -N1 -n1 -c12 ' +  '\n' '#SBATCH --time=12:00:00' + '\n' '#SBATCH --mem=12000MB ' + '\n' '#SBATCH --error  %J.err ' + '\n' '#SBATCH --output %J.out'  + '\n' '#SBATCH --account=CNHPC_1700031_0' + '\n' '#SBATCH --partition=dcgp_usr_prod' + '\n' '#SBATCH --job-name=DFT'  + '\n' ''  '+\n' 'module load autoload' + '\n' 'module load profile/chem-phys' + '\n' 'module load g16/c02' + '\n' '' + '\n' '. $g16root/g16/bsd/g16.profile' + '\n' '' + '\n' '' + '\n' 'export GAUSS_SCRDIR=$CINECA_SCRATCH/g16_$SLURM_JOBID' + '\n'  'mkdir  -p $GAUSS_SCRDIR'                  
'' + '\n'


def process_file(input_filename):
    # Apro il file di input in modalità lettura
    with open(input_filename, 'r') as file:
        lines = file.readlines()

    # Il numero di atomi è il primo numero del file
    n_atomi = int(lines[0].strip())  # Legge il primo numero come numero di atomi
    file_counter = 1  # Contatore per i file di output

    # Variabile per raccogliere i blocchi di atomi
    i = 1  # Partiamo dalla seconda riga
    while i < len(lines) and file_counter <=50 : # aggiunto un uscita ad unnumero di strutture nel caso ce ne siano davvere troppe
        line = lines[i].strip()

        # Se trovo la riga "converged=true", leggo i n_atomi successivi
        if 'converged=true' in line:
            # Prendo i n_atomi successivi (non includo la riga con "converged=true")
            atom_block = []
            for j in range(i + 1, i + 1 + n_atomi):
                if j < len(lines):
                    atom_block.append(lines[j].strip())

            # Crea la cartella con il nome del contatore (file_counter)
            folder_name = str(file_counter)
            if not os.path.exists(folder_name):
                os.makedirs(folder_name)  # Crea la cartella se non esiste già

            # Definisci il nome del file all'interno della cartella
            output_filename = os.path.join(folder_name, f'{file_counter}.com')

            # Scrivo i dati nel file
            with open(output_filename, 'w') as output_file:
                # Scrivo l'header fisso
                output_file.write(headgaussian + '\n') 
                # Scrivo i dati degli atomi
                output_file.write("\n".join(atom_block) + "\n")
                output_file.write('' + '\n')

            sh_file = os.path.join(folder_name, f"{file_counter}.sh")
            with open(sh_file, 'w') as sh_output:
                # Scrivo l'header fisso
                sh_output.write(headslurm + '\n')
                sh_output.write(f'g16 -p="8" < {file_counter}.com > {file_counter}.log\n')
                # Scrivo i dati degli atomi

            # Aumento il contatore del file
            file_counter += 1
            # Passo oltre la riga "converged=true" e le righe degli atomi
            i += n_atomi + 1  # Salto la riga "converged=true" e le righe degli atomi
        else:
            i += 1  # Passo alla riga successiva

# Esegui il programma passando il nome del file di input
input_filename = primo_argomento # Cambia con il nome del tuo file
process_file(input_filename)


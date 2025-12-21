# Python Environment – Tutorial

1. Check Python  
2. Install Python  
3. Why create an environment  
4. Conda / venv tutorial  
5. Commands examples  


## Check if Python is installed

Before creating a dedicated Python environment, let's make sure Python is installed on your system:

```bash
python3 --version
# or
python --version
```

## If python is installed, you will se the version number e.g:

```bash
Python 3.10.8
```
## if python is not installed, use one of the following command to install:

macOS

```bash
brew install python 
```

Linux(ubuntu)
```bash
sudo apt update 
sudo adp install python3 python3-pip -y
```

## Advantages of Python Environments in Chemistry

- **Isolation & reproducibility:** Avoid conflicts and lock library versions.  
- **Easy package management:** RDKit, OpenBabel, pymatgen, Matplotlib, etc.  
- **Safe HPC workflows:** Test scripts and run reliably on clusters.

## Creating a Python environment with `venv`

### 1. Create the environment
```bash
python3 -m venv myenv

activate the enviroiment

source myenv/bin/activate

# You should see the prompt change:
# (myenv) user@computer:~/Procedure_tutorial$

# Install packages
pip install numpy scipy matplotlib

# Verify installation
python -c "import numpy; print(numpy.__version__)"
# Output example:
# 1.24.2

# Deactivate when done
deactivate
# Prompt returns to normal

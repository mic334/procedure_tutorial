## A few opretaiton to install a open Blas Package

Copy it

```bash
apt-get update -y \
    && apt-get upgrade -y \
    && git clone https://github.com/OpenMathLib/OpenBLAS.git \
    && cd OpenBLAS \
    && make INTERFACE64=1 USE_OPENMP=1 \
    && make PREFIX=/usr/local/build_OPENBLAS install
```


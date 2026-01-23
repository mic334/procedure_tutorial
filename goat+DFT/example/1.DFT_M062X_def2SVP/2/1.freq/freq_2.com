%nprocshared=12
%mem=12GB
%oldchk=optdft.chk
%chk=freq_2.chk
#p freq M062X def2SVP empiricaldispersion=GD3 SCRF(solvent=water) guess=read geom=check

titolo

1 2


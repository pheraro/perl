#!/usr/bin/perl

open FASTA, "./sequence.fasta";
open SECUENCIA, ">secuencia.txt";
open CODONES, ">codones_inicio.txt";
open SHINE, ">shine_dalgarno.txt";
open TATA, ">tata.txt";
open INFORMACION, ">informacion_general.txt";

$id = <FASTA>;

chomp $id;

#eliminar saltos de línea
while (<FASTA>) {
	chomp $_;
	next if ($_ =~ />/); 
	$secuencia = $secuencia. $_ ;

}

print SECUENCIA "$id\n\$secuencia";
close SECUENCIA;
close FASTA;

#recuento de nucleotidos
$n=0;
while ($secuencia=~/A|C|T|G/g){
	$n++;
}

#buscar codones de inicio
$codon1= "ATG";$a=0;
$codon2= "CAT";
$codon3= "GTG";$b=0;
$codon4= "CAC";
$codon5= "TTG";$c=0;
$codon6= "CAA";
$z=0; #numero de codones

print CODONES "$id\n\n\ El codón de inicio ATG se encuentra en las siguientes posiciones:\n";

while ($secuencia=~/$codon1/g) {
	$a++;
	$z++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 2;
	print CODONES "   ID$a: $pos1 - $pos2 de la cadena +\n";
}
while ($secuencia=~/$codon2/g) {
	$a++;
	$z++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 2;
	print CODONES "   ID$a: $pos1 - $pos2 de la cadena -\n";
}
print CODONES "\n\ El codón de inicio GTG se encuentra en las siguientes posiciones:\n";
while ($secuencia=~/$codon3/g) {
	$b++;
	$z++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 2;
	print CODONES "   ID$b: $pos1 - $pos2 de la cadena +\n";
}
while ($secuencia=~/$codon4/g) {
	$b++;
	$z++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 2;
	print CODONES "   ID$b: $pos1 - $pos2 de la cadena -\n";
}
print CODONES "\n\ El codón de inicio TTG se encuentra en las siguientes posiciones:\n";
while ($secuencia=~/$codon5/g) {
	$c++;
	$z++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 2;
	print CODONES "   ID$c: $pos1 - $pos2 de la cadena +\n";
}
while ($secuencia=~/$codon6/g) {
	$c++;
	$z++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 2;
	print CODONES "   ID$c: $pos1 - $pos2 de la cadena -\n";
}
close CODONES;

#buscar contenido de G+C
$gc=0;
while ($secuencia=~/C|G/g) {
	$gc++;
}
$d=$gc/$n;
$p=$d*100;
#buscar secuencias shine-dalgarno
$shine1= "AGGAGG";
$shine2= "CCTCCT";
$sd=0;
print SHINE "$id\n\ La secuencia Shine-Dalgarno AGGAGG se encuentra en las posiciones:\n";
while ($secuencia=~/$shine1/g) {
	$sd++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 5;
	print SHINE "   ID$sd: $pos1 - $pos2 de la cadena +\n";
}
while ($secuencia=~/$shine2/g) {
	$sd++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 5;
	print SHINE "   ID$sd: $pos1 - $pos2 de la cadena -\n";
}
close SHINE;

#buscar cajas TATA
$tata1= "TATAAT";
$tata2= "ATTATA";
$t=0;
print TATA "$id\n\ La secuencia TATA se encuentra en las siguientes posiciones:\n";
while ($secuencia=~/$tata1/g){
	$t++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 5;
	print TATA "   ID$t: $pos1 - $pos2 de la cadena +\n";
}
while ($secuencia=~/$tata2/g){
	$t++;
	$pos1=length ($') + 1;
	$pos2=$pos1 + 5;
	print TATA "   ID$t: $pos1 - $pos2 de la cadena -\n";
}

print INFORMACION "$id\n\n\ Tras el estudio obtenemos la siguiente información de la bacteria:\n\  -El contenido en G+C es de $gc ácidos nucleicos.\n\   Lo que corresponde con un $p % del total.\n\n\  -Posee $z codones de inicio, de los cuales:\n\     ATG: $a\n\     GTG: $b\n\     TTG: $c\n\   Para más información acerca de los codones de inicio consultar el archivo codones_inicio.txt\n\n\  -Posee $sd Shine Dalgarno AGGAGG, para conocer la posición de estas consular el archivo shine_dalgarno.txt\n\n\  -Posee $t cajas TATA, para conocer la posición de estas consultar el archivo tata.txt\n";
close INFORMACION;






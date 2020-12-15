#!/bin/bash

#Si no afegeix parametre es para el procés

if [ -z $1 ]; then
	echo "S'ha d'afegir un paràmetre"
	exit 1
fi

#Agafar ips fallant ssh

contingut=`cat $1 | grep Failed | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort`

declare -A listaip

#Funcio guarda nombre vegades ip en la array

guardarIp(){
	for i in $contingut;do
		if [ -z "${listaip[$i]}" ];then
			listaip[$i]=1
		else
			listaip[$i]+=1
		fi

	done
}
#imprimir els continguts dels valors

mostrarContinguts(){
	echo "Veces 	Ip	       Pais"
	for i in "${!listaip[@]}";do
		att=`echo "${listaip[$i]}" | wc -m`
		geo=`geoiplookup $i | awk '{print $NF}'`
		echo "$att	$i	$geo"
	done
}
guardarIp
mostrarContinguts

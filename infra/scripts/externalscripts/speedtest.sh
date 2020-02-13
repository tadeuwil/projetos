#!/bin/bash
# speedtest.sh
#
# Versão 1.0: Script para coleta de valores de download, upload e latência do link de internet,
# pelo aplicativo speedtest-cli. Script para ferramenta Zabbix para coleta dessas informações.
#
# Requisitos: SO deve ter instalado o aplicativo speedtest-cli
# Instalação no Ubuntu: apt install speedtest-cli
#
# Evandro José Zipf, maio 2019

download=0 # coleta do download
upload=0 # coleta do upload
ping=0 # coleta do ping
medir=0 # realiza a teste de conexão na hora


# Mostra mensagem de uso para usuário, caso, não passe nenhuma opção.
MENSAGEM_USO="
   Uso: $(basename "$0")[-d|-u|-p|-m|-h|-V]
     -d coleta download
     -u coleta Upload
     -p coleta Ping
     -h menu ajuda
     -m faz o teste de medição da internet
     -V mostra versão do sistema
     "


	dir=/home/nocadmin/tmp/speedtest_temp.txt

	# verifica que arquivo existe senão cria.
	if [ -f "$dir" ]; 
	then
		touch "$dir"
	else
		touch "$dir"
		chmod zabbix.zabbix "$dir"
	fi


	#Tratamento das opções de linha de comando
    case "$1" in
    	
    	# Opções de ligam e desligam chaves

    	-d|--download) download=1 ;;

		-u|--upload) upload=1 ;;

		-p|--ping) ping=1 ;;
		
		-m|--medir) medir=1 ;;

		
     	-h|--help)
          	echo $MENSAGEM_USO
        	exit 0
        ;;
        
        -V|--version)
            echo -n $(basename "$0")
            # Extrai a versão diretamente dos cabeçalhos do programa
            grep '^# Versão' "$0"| tail -1| cut -d: -f1 |tr -d \#
            exit 0

        ;;        
           
         *)  # opção inválida
			if test -n "$1"
			then
				echo Opção invalida: $1
				exit 1
			fi
		;;
	esac

		# Realiza o teste e mostra para o usuário	    
	    test "$medir" = 1 && speedtest-cli --simple >"$dir" && cat "$dir"
	    
  		# Coleta o valor do download fornecido pelo speedtest
	    test "$download" = 1 && grep Download "$dir" | cut -d" " -f2
		
		# Coloca a listagem em letras maiúsculas
	    test "$upload" = 1 && grep Upload "$dir" | cut -d" " -f2

	    # Coloca a listagem em letras maiúsculas
	    test "$ping" = 1 && grep Ping "$dir" | cut -d" " -f2

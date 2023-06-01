#!/bin/bash
#Nome: Heberton Ayrton Cabral

clear
echo

#Condição para verificar se existe a pasta: projetos.
if [ -d "./projetos" ]
then
	echo "A pasta ''projetos'' já existe! Continuando processo de backup..."
	echo

	#Condicional para verificar se existe a pasta: backup.
	if [ -d "./backup" ]
	then
		echo "A pasta ''backup'' já existe!. Continuando processo de backup..."
	else
		echo "A pasta ''backup'' não existe! Criando pasta..."
		mkdir "backup"
		chmod u+rw "backup"
		echo "A pasta foi criada com sucesso!"
	fi
	echo
	mes=$(date +%B) #Variável para guardar o mês atual por escrito.

	#Condicional para verificar se existe uma subpasta com nome do mês atual.
	if [ -d "./backup/$mes" ]
	then
		echo "Já existe uma subpasta com o nome ''$mes''! Continuando processo de backup..."
	else
		echo "A subpasta com o nome ''$mes'' não existe! Criando subpasta..."
		mkdir "./backup/$mes"
		chmod u+rw "./backup/$mes"
		echo "A subpasta foi criada com sucesso!"
	fi
	echo
	data=$(date +%Y-%m-%d)	#Variável para guardar a data atual completa. 

	#Condicional para verificar se já foi feito o backup do arquivo zip. 
	if [ -e "./backup/$mes/$data.zip" ]
	then
		echo "Já existe o arquivo ''$data.zip'' criado!"
		echo "Você deseja substituir o arquivo(s/n)?"
		read resposta
		echo

		#Estrutura de escolha para substituir arquivo ou não.
		case "$resposta" in
		s|S|"")
			rm ./backup/"$mes"/"$data.zip"
			zip -r "$data.zip" ./projetos
			chmod u+rw "$data.zip"
			mv "$data.zip" ./backup/"$mes"
			echo
			echo "O arquivo foi substituido com sucesso!"
		;;
		n|N|"")
			exit
		;;
		*)
			echo "Resposta inválida!"
			echo
			exit
	esac
	else
		echo "O arquivo ''$data.zip'' não existe! Compactando e movendo arquivo... "
		echo
		zip -r "$data.zip" ./projetos
		chmod u+rw "$data.zip"
		mv "$data.zip" ./backup/"$mes"
		echo 
		echo "O arquivo foi compactado com sucesso!"
	fi
	echo
else
	echo "A pasta ''projetos'' não existe! Crie uma pasta chamada ''projetos'', coloque seus arquivos dentro da mesma, para que o backup seja realizado com sucesso."
fi 

#Condicional para verificar se realmente o backup foi realizado.
if [ -e "./backup/$mes/$data.zip" ]
then
	echo "$USER, o backup foi realizado com sucesso!"
else
	echo "Erro! Não foi possível realizar o backup."
fi
echo
exit


#!/bin/bash

###################################################
#                                                 #
	AUTOR='LEONARDO PINEDA'
	DEBUT=0 #  0-Desarrollo; 1-Distribucion
#                                                 #
###################################################

KEY_LICENSE_SUBLIMETEXT='----- BEGIN LICENSE -----
eldon
Single User License
EA7E-1122628
C0360740 20724B8A 30420C09 6D7E046F
3F5D5FBB 17EF95DA 2BA7BB27 CCB14947
27A316BE 8BCF4BC0 252FB8FF FD97DF71
B11A1DA9 F7119CA0 31984BB9 7D71700C
2C728BF8 B952E5F5 B941FF64 6D7979DA
B8EB32F8 8D415F8E F16FE657 A35381CC
290E2905 96E81236 63D2B06D E5F01A69
84174B79 7C467714 641A9013 94CA7162
------ END LICENSE ------'

DIR_LIB=$PWD/lib

#Colores
blanco="\033[1;37m"
gris="\033[0;37m"
magenta="\033[0;35m"
rojo="\033[1;31m"
verde="\033[1;32m"
amarillo="\033[1;33m"
azul="\033[1;34m"
rescolor="\e[0m"

# Si se cierra el script inesperadamente, ejecutar la funcion
trap exitmode SIGINT SIGHUP
function exitmode(){
	echo -e "Exit"
}

function main(){
config
clear
while true; do
		case "$@" in
			"update-system" )
		 		upgradeSystem
		 	break;;
			"install" ) 
				installgedit
	    		installNodeJs
	    		installPostgreSQL
	    		installpgAdmin3
	    		installWebStorm
		    	installSublimeText
			break;;
			"install gedit" ) installgedit
			break;;
			"install node" ) installNodeJs
			break;;
			"install postgresql" ) installPostgreSQL
			break;;
			"install pgadmin3" ) installpgAdmin3
			break;;
			"install webstorm" ) installWebStorm
			break;;
			"install sublime-text-3" ) installSublimeText
			break;;
			"--help" ) help
			break;;
			* ) help 
			 break;;
		esac
	done				
		
}

function help(){
	echo "ejecutar el script con argumento"
	echo "[ --help ]"
	echo "[ install ]"
	echo "install [ gedit | node | postgresql | pgadmin3 | webstorm | sublime-text-3 ]"

}

function config(){
	if ! [ -d /tmp/toodev ] ; then
		mkdir /tmp/toodev
	fi

	if ! [ -d /tmp/toodev/lib ] ; then
		mkdir /tmp/toodev/lib
	fi

	if [ $DEBUT = 1 ] ; then
		echo "Modo 1-Distribucion"
	fi

	if [ $DEBUT = 0 ] ; then
		if [ -f $PWD/toodev ] ; then
			echo -e $amarillo"Ubicate en el directorio del script:toodev"$rescolor
			exit 1;
		else
			echo -e $amarillo"Iniciando script toodev"$rescolor
		fi
	fi
}

function updateSystem(){
	echo -e $azul"Tool"$gris"-"$amarillo"dev"$rescolor": "$PKG
	sudo apt-get update
	echo -e $verde"HECHO..."$rescolor
}

function upgradeSystem(){

	echo -e $verde"ESTAS A PUNTO DE APLICAR LA ACTUALIZACION DEL SISTEMA"$rescolor""
		while true; do
			echo -e $gris"Este proceso se demorara ( "$rojo"NO APAGAR EL EQUIPO"$rojo" )"
			echo -e $amarillo"Desea aplicar la actualizacion en el sistema"
			echo "                                    "
		echo -e "      "$verde"1)"$rescolor" SI       "
		echo -e "      "$verde"2)"$rescolor" NO       "
		echo -e "      "$verde"3)"$rescolor" CONTINUAR SIN APLICAR ACTUALIZACION"
		echo "                                        "
		echo -n "      #> "
		read yn
		echo ""
		case $yn in
			1 ) 
				echo -e $verde"Descargando PKG"$gris
				sudo apt-get update
				sudo apt-get upgrade
				echo -e $verde"HECHO..."$rescolor
				break ;;
			2 ) exit 1 ; break ;;  
			3 ) echo -e $verde"........>>>"; break ;;  
			* ) clear;
		  esac
	done
	sleep 0.1
}

function installNodeJs(){
	PKG='nodejs'
	VERSION='v8.9.4'
	if ! [ -d $HOME/.nvm ]; then
	    	bash -ic "bash $PWD/lib/install_nvm.sh"
		source $HOME/.profile
		installNodeJs
	else
	    echo -e $verde"Instalando nueva Version node-"$VERSION"-linux-x64"$rescolor
	    bash -ic "nvm install $VERSION && nvm ls"
	    echo -e $verde"HECHO..."$rescolor
	fi
	sleep 0.1
}

function installSublimeText(){
PKG='sublime-text-installer'
echo -e $azul"Tool"$gris"-"$amarillo"dev"$rescolor": "$PKG

if ! dpkg -l $PKG  &> /dev/null ;then
		echo -e "\e[1;31m$PKG No Esta Instalado"$rescolor""
		echo -e $verde"Instalando $PKG"$rescolor
		sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y && updateSystem
		sudo apt-get install $PKG -y 
		echo -e $amarillo"<-- AVISO -->"$rescolor
		echo -e $azul"INGRESAR KEY LICENSE"$rescolor
		echo -e $gris$KEY_LICENSE_SUBLIMETEXT$rescolor
		echo -e $verde"HECHO..."$rescolor	
	else
		echo -e $PKG$verde" Esta Instalado?................SI"$rescolor""
	fi
	sleep 0.1

	echo ""	
}

function installPostgreSQL(){
	PKG='postgresql'
	echo -e $azul"Tool"$gris"-"$amarillo"dev"$rescolor": "$PKG

	if ! dpkg -l $PKG  &> /dev/null ;then
		echo -e "\e[1;31m$PKG No Esta Instalado"$rescolor""
		echo -e $verde"Instalando $PKG"$rescolor
		sudo apt-get install $PKG -y 
		echo -e $verde"HECHO..."$rescolor	
	else
		echo -e $PKG$verde" Esta Instalado?................SI"$rescolor""
	fi
	sleep 0.1

}

function installpgAdmin3(){
	PKG='pgadmin3'
	echo -e $azul"Tool"$gris"-"$amarillo"dev"$rescolor": "$PKG

	if ! dpkg -l $PKG  &> /dev/null ;then
		echo -e "\e[1;31m$PKG No Esta Instalado"$rescolor""
		echo -e $verde"Instalando $PKG"$rescolor
		sudo apt-get install $PKG -y 
		echo -e $verde"HECHO..."$rescolor	
	else
		echo -e $PKG$verde" Esta Instalado?................SI"$rescolor""
	fi
	sleep 0.1
}

function installgedit(){
	PKG='gedit'
	echo -e $azul"Tool"$gris"-"$amarillo"dev"$rescolor": "$PKG

	if ! dpkg -l $PKG  &> /dev/null ;then
		echo -e "\e[1;31m$PKG No Esta Instalado"$rescolor""
		echo -e $verde"Instalando $PKG"$rescolor
		sudo apt-get install $PKG -y 
		echo -e $verde"HECHO..."$rescolor	
	else
		echo -e $PKG$verde" Esta Instalado?................SI"$rescolor""
	fi
	sleep 0.1
}

function installWebStorm(){
	PKG='WebStorm'
	RES='WebStorm-173.4548.30'
	LIB='WebStorm-2017.3.4.tar.gz'
	DIR_LIB=$PWD'/lib'
	echo -e $azul"Tool"$gris"-"$amarillo"dev"$rescolor": "$PKG
		
	if ! [ -d /opt/$RES ]; then
		if ! [ -f $DIR_LIB/$LIB ]; then
			echo $DIR_LIB$LIB
			echo -e $rojo$LIB" no encontrado en: "$verde""$DIR_LIB""$rescolor
			echo -e $amarillo"Se Descargara: "$LIB$gris" Y se ubicara en: "$DIR_LIB$rescolor
			
			AUX_PWD=$PWD 
			cd DIR_LIB &&  curl -sL https://download.jetbrains.com/webstorm/$LIB -o /bin/$LIB && cd AUX_PWD && descomprimirWebStorm
			echo -e $verde"HECHO..."$rescolor	
			sleep 1;
		else
			descomprimirWebStorm
		fi
	else
		echo -e $PKG$verde" Esta Instalado?................SI"$rescolor""
	fi
	sleep 0.1
}

function descomprimirWebStorm(){
	DIR_LIB=$PWD'/lib'
	LIB='WebStorm-2017.3.4.tar.gz'
	PKG='WebStorm'
	RES='WebStorm-173.4548.30'
	sudo cp $DIR_LIB/$LIB /opt
	AUX=$PWD 	
	cd /opt && sudo tar -xvf $LIB && cd $AUX
	WEBSTORM="/opt/"$RES
	sudo chmod +x $WEBSTORM/bin/webstorm.sh
	sudo bash -ic " echo '[Desktop Entry]
Version=1.0
Type=Application
Name=WebStorm
Icon=/opt/WebStorm-173.4548.30/bin/webstorm.svg
Exec="/opt/WebStorm-173.4548.30/bin/webstorm.sh" %f
Comment=The Drive to Develop
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-webstorm'>'/usr/share/applications/jetbrains-webstorm.desktop'
"
}

main "$@"

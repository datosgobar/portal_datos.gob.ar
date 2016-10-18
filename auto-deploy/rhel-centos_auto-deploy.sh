#!/bin/bash
source docker_friendly_functions

clear  
printf "\n$W╔═════════════════════════════════════════════════════════╗\n"
printf "$W║                                                       $B▓███▓▒░\n"
printf "$W║     ${W}BIENVENIDO A LA INSTALACION AUTOMATICA DE ${BOLD}CKAN${NORMAL}    $W▓███▓▒░\n"
printf "$W║                 ${W}EN DOCKER ${BOLD}RHEL|CentOS${NORMAL}${W}.                $B▓███▓▒░\n"
printf "$W╚═════════════════════════════════════════════════════════╝\n"

# Esta docker insalado?	
if [ $(dpkg-query -W -f='${Status}' docker-engine 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	# No? no importa, lo instalamos! :D
	install_docker
fi
deploy_portal
printf "CKAN esta iniciando... "
sleep 1
if [[ $? -eq 0 ]]; then
	# OK! veamos como quedo tu portal! :D
	printf "[OK]\nTodo listo! el portal esta funcionando! :D\n"
	print_ckan_status
else
	printf  "[FALLO]\nOops... Algo se rompio..."
fi
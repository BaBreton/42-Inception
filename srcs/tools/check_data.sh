login=$(sed -n 's/USERLOGIN=//p' $1)

if [ ! -d "/home/$login/data" ]; then
	echo "Error in config, please type 'make config' to reconfigure."
	exit 1
fi
if [ ! -d /home/$login/data/mariadb ]; then
	echo "Error in config, please type 'make config' to reconfigure."
	exit 1
fi
if [ ! -d /home/$login/data/wordpress ]; then
	echo "Error in config, please type 'make config' to reconfigure."
	exit 1
fi
exit 0
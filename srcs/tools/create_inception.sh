#!/bin/sh

# Functions

check_ret() {
	if [ $? -eq 1 ]; then
		echo "$1"
		echo "Aborting..."
		exit 1
	fi
}

grep_state() {
	if grep -q "COMPLETE" ./srcs/.tmp/state; then
		return 3
	elif grep -q "2=OK" ./srcs/.tmp/state; then
		return 2
	elif grep -q "1=OK" ./srcs/.tmp/state; then
		return 1
	else
		return 0
	fi
}

# Variables
login=$USER
clear

# Intro
grep_state > /dev/null 2>&1
if [ $? -eq 0 ]; then
echo "Welcome to Inception, a 42school project by BaBreton."
echo "This script will install a full web server on your machine."
echo ""
printf "Your current login is: $USER\n"
printf "The server will be installed in /home/$USER/data/\n"
printf "The server will be accessible at: $USER.42.fr\n"
printf "Press a key to continue... "; read 
clear

# Create state file
echo "Creating state file..."
mkdir -p ./srcs/.tmp > /dev/null 2>&1
check_ret "Failed to create tmp folder, please check your permissions and consult the logs."
touch ./srcs/.tmp/state > /dev/null 2>&1
sleep 1
check_ret "Failed to create state file, please check your permissions and consult the logs."
echo "1=OK" > ./srcs/.tmp/state
fi

# Check docker and docker-compose installation
grep_state > /dev/null 2>&1
if [ $? -eq 1 ]; then
echo "Checking docker installation..."
bash srcs/tools/docker.sh
check_ret "Docker is not installed, you need it to use Inception by BaBreton."

if ! grep -q "$login.42.fr" /etc/hosts; then
	echo -n "Adding $login.42.fr to /etc/hosts..."
	cp /etc/hosts ./srcs/.tmp/hosts > /dev/null 2>&1
	check_ret "Failed to copy /etc/hosts to tmp folder, please check your permissions and consult the logs."
    echo "127.0.0.1 $login.42.fr" | sudo tee -a /etc/hosts > /dev/null 2>&1
	check_ret "Failed to add $login.42.fr to /etc/hosts, please check your permissions and consult the logs."
	echo -e "\rAdding $login.42.fr to /etc/hosts $OK"
fi

# Create docker-compose.yml file
echo "Creating docker-compose.yml file..."
cp $2 $3 > /dev/null 2>&1
check_ret "Failed to create docker-compose.yml file, please check your permissions and consult the logs."
sed -i "s/\$login/$login/g" $3 > /dev/null 2>&1
check_ret "Failed to create docker-compose.yml file, please check your permissions and consult the logs."
sleep 1
check_ret "Failed to create docker-compose.yml file, please check your permissions and consult the logs."

echo "Done."
echo "2=OK" > ./srcs/.tmp/state
fi


# Check is data folder exists
grep_state > /dev/null 2>&1
if [ $? -eq 2 ]; then
echo "Checking if data folder exists..."
if [ ! -d "/home/$login/data" ]; then
	echo "Creating data folder..."
	mkdir /home/$login/data > /dev/null 2>&1
	check_ret "Failed to create data folder, please check your permissions and consult the logs."
	echo "Done."
fi
if [ ! -d /home/$login/data/mariadb ]; then
	echo "Creating mariadb folder..."
	mkdir /home/$login/data/mariadb > /dev/null 2>&1
	check_ret "Failed to create mariadb folder, please check your permissions and consult the logs."
	echo "Done."
fi
if [ ! -d /home/$login/data/wordpress ]; then
	echo "Creating wordpress folder..."
	mkdir /home/$login/data/wordpress > /dev/null 2>&1
	check_ret "Failed to create wordpress folder, please check your permissions and consult the logs."
	echo "Done."
fi
sleep 2
echo "Successfully checked data folder."
sleep 0.5
clear
echo "COMPLETE" > ./srcs/.tmp/state
fi

# Create .env file
if [ ! -f $1 ]; then
	echo "Creating .env file..."
	touch $1 > /dev/null 2>&1
	echo "Done."
	check_ret "Failed to create .env file, please check your permissions and consult the logs."
	env="y"
else
	echo ".env file already exists, would you like to overwrite it? [y/n] "; read env
	if [ "$env" = "y" ]; then
		echo "Creating .env file..."
		rm -f $1 > /dev/null 2>&1
		check_ret "Failed to create .env file, please check your permissions and consult the logs."
		touch $1 > /dev/null 2>&1
		check_ret "Failed to create .env file, please check your permissions and consult the logs."
		echo "Done."
	else
		echo "Skipping env config..."
	fi
fi
clear
if [ "$env" = "y" ]; then
	echo "Please enter your env variables: "
	echo "USERLOGIN=$login" >> $1
	check_ret "Failed to write variables on .env, please check your permissions and consult the logs."
	echo "DOMAIN_NAME=$login.42.fr" >> $1
	sleep 0.15
	echo -n "DATABASE_NAME="; read db_name; echo "SQL_DATABASE=$db_name" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "DATABASE_USER="; read db_user; echo "SQL_USER=$db_user" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "DATABASE_PASSWORD="; read db_password; echo "SQL_PASSWORD=$db_password" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "DATABASE_ROOT_PASSWORD="; read db_root_password; echo "SQL_ROOT_PASSWORD=$db_root_password" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "SITE_TITLE="; read site_title; echo "SITE_TITLE=$site_title" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "SITE_ADMIN_USER="; read site_admin_user; echo "SITE_ADMIN_USER=$site_admin_user" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "SITE_ADMIN_PASSWORD="; read site_admin_password; echo "SITE_ADMIN_PASSWORD=$site_admin_password" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "SITE_ADMIN_EMAIL="; read site_admin_email; echo "SITE_ADMIN_EMAIL=$site_admin_email" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "SITE_USER1_LOGIN="; read site_user1_login; echo "SITE_USER1_LOGIN=$site_user1_login" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "SITE_USER1_PASSWORD="; read site_user1_password; echo "SITE_USER1_PASSWORD=$site_user1_password" >> $1
	clear
	echo "Please enter your env variables: "
	sleep 0.15
	echo -n "SITE_USER1_EMAIL="; read site_user1_email; echo "SITE_USER1_EMAIL=$site_user1_email" >> $1
	clear
	sleep 0.15
fi
echo "Everything is set up, thank you for using Inception by BaBreton, please press enter to continue..."; read
exit 0

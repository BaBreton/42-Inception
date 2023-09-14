check_ret() {
	if [ $? -eq 1 ]; then
		echo "$1"
		echo "Aborting..."
		exit 1
	fi
}

OK="\\e[0;32m✔ OK\\e[0m"
docker-compose -v > /dev/null 2>&1
dc=$?
docker -v > /dev/null 2>&1
d=$?

if [ $dc -eq 0 ] && [ $d -eq 0 ]; then
	echo "Docker is correctly installed."
	docker -v
	docker-compose -v

else
	echo "Docker is not installed, would you like to install it? [y/n] (need sudo)"; read docker;
	if [ "$docker" = "y" ]; then
		echo -n "Update & upgrade..."
		sleep 1
		sudo apt-get update -y && sudo apt-get upgrade -y
		check_ret "Failed to update & upgrade, please check your permissions and consult the logs."
		clear
		echo -e "\rUpdate & upgrade $OK"
		echo -n "Install dependencies..."
		sleep 1
		sudo apt-get install ca-certificates curl gnupg lsb-release -y
		check_ret "Failed to install dependencies, please check your permissions and consult the logs."
		clear
		echo -e "\rInstall dependencies $OK"
		echo -n "Add Docker GPG key..."
		sleep 1
		sudo install -m 0755 -d /etc/apt/keyrings
		check_ret "Failed to add Docker GPG key, please check your permissions and consult the logs."
		curl -fsSL https://download.docker.com/linux/debian/gpg  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		check_ret "Failed to add Docker GPG key, please check your permissions and consult the logs."
		sudo chmod a+r /etc/apt/keyrings/docker.gpg
		check_ret "Failed to add Docker GPG key, please check your permissions and consult the logs."
		clear
		echo -e "\rAdd Docker GPG key $OK"
		echo -n "Add Docker repository..."
		sleep 1
		echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list
		check_ret "Failed to add Docker repository, please check your permissions and consult the logs."
		clear
		echo -e "\rAdd Docker repository $OK"
		echo -n "Update & upgrade..."
		sleep 1
		sudo apt-get update  && sudo apt-get upgrade -y
		check_ret "Failed to update & upgrade, please check your permissions and consult the logs."
		clear
		echo -e "\rUpdate & upgrade $OK"
		echo -n "Install Docker..."
		sleep 1
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
		check_ret "Failed to install Docker, please check your permissions and consult the logs."
		clear
		echo -e "\rInstall Docker $OK"
		echo -n "Install Docker Compose..."
		sleep 1
		sudo apt-get install docker-compose -y
		check_ret "Failed to install Docker Compose, please check your permissions and consult the logs."
		clear
		echo -e "\rInstall Docker Compose $OK"
		echo "Docker is correctly installed"
		docker -v
		docker-compose -v
	else
		exit 1
	fi
fi

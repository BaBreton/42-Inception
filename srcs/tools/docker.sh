check_ret() {
	if [ $? -eq 1 ]; then
		echo "$1"
		echo "Aborting..."
		exit 1
	fi
}

OK="\\e[0;32m✔ OK\\e[0m"

if dpkg -l | grep "docker" > /dev/null 2>&1; then
	echo "Docker is correctly installed."
else
	echo "Docker is not installed, would you like to install it? [y/n] (need sudo)"; read docker;
	if [ "$docker" = "y" ]; then
		echo -n "Update & upgrade..."
		sudo apt-get update -y > /dev/null 2>&1 && sudo apt-get upgrade -y > /dev/null 2>&1
		check_ret "Failed to update & upgrade, please check your permissions and consult the logs."
		echo -e "\rUpdate & upgrade $OK"
		echo -n "Install dependencies..."
		check_ret "Failed to install dependencies, please check your permissions and consult the logs."
		echo -e "\rInstall dependencies $OK"
		echo -n "Add Docker GPG key..."
		sudo install -m 0755 -d /etc/apt/keyrings > /dev/null 2>&1
		check_ret "Failed to add Docker GPG key, please check your permissions and consult the logs."
		curl -fsSL https://download.docker.com/linux/debian/gpg  > /dev/null 2>&1 | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg > /dev/null 2>&1
		check_ret "Failed to add Docker GPG key, please check your permissions and consult the logs."
		sudo chmod a+r /etc/apt/keyrings/docker.gpg > /dev/null 2>&1
		check_ret "Failed to add Docker GPG key, please check your permissions and consult the logs."
		echo -e "\rAdd Docker GPG key $OK"
		echo -n "Add Docker repository..."
		echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" > /dev/null 2>&1 | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 2>&1
		check_ret "Failed to add Docker repository, please check your permissions and consult the logs."
		echo -e "\rAdd Docker repository $OK"
		echo -n "Update & upgrade..."
		sudo apt-get update  > /dev/null 2>&1 && sudo apt-get upgrade -y > /dev/null 2>&1
		check_ret "Failed to update & upgrade, please check your permissions and consult the logs."
		echo -e "\rUpdate & upgrade $OK"
		echo -n "Install Docker..."
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y > /dev/null 2>&1
		check_ret "Failed to install Docker, please check your permissions and consult the logs."
		echo -e "\rInstall Docker $OK"
		echo -n "Install Docker Compose..."
		sudo apt-get install docker-compose -y > /dev/null 2>&1
		check_ret "Failed to install Docker Compose, please check your permissions and consult the logs."
		echo -e "\rInstall Docker Compose $OK"
		echo "Docker is correctly installed"
		docker -v
		docker-compose -v
	else
		exit 1
	fi
fi

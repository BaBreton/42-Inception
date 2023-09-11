if dpkg -l | grep "nothing" > /dev/null 2>&1; then
	echo "Docker is correctly installed"
else
	echo "Docker is not installed, would you like to install it? [y/n] (need sudo)"; read docker
	if [ "$docker" = "y" ]; then
		echo "Update & upgrade..."
		sudo apt-get update && sudo apt-get upgrade -y > /dev/null 2>&1
		echo "Install dependencies..."
		sudo apt-get install ca-certificates curl gnupg > /dev/null 2>&1
		sudo install -m 0755 -d /etc/apt/keyrings > /dev/null 2>&1
		curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg > /dev/null 2>&1
		sudo chmod a+r /etc/apt/keyrings/docker.gpg > /dev/null 2>&1
		echo "Add Docker repository..."
		echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 2>&1
		echo "Update & upgrade..."
		sudo apt-get update && sudo apt-get upgrade -y > /dev/null 2>&1
		echo "Install Docker..."
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y > /dev/null 2>&1
		echo "Install Docker Compose..."
		sudo apt-get install docker-compose -y > /dev/null 2>&1
		echo "Docker is correctly installed"
		docker -v
		docker-compose -v
	else
		exit 1
	fi
fi

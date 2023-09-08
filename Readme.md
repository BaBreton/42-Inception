<p align="center">
  <img src="https://github.com/BaBreton/42-Get_next_line/assets/124448529/43a36b92-4c44-4c58-b03c-b18903712b45" alt="BaBreton" />
</p>
<p align="center">
  <img src="https://img.shields.io/badge/Language-Docker-cyan" alt="language" />
  <img src="https://img.shields.io/badge/Mark-125/100-green" alt="language" />
</p>

# 42-Inception

Inception is a project developed as part of the 42 school curriculum. Its primary objective is to design and implement a virtual machine capable of hosting Docker containers and a small WordPress website complete with a database.

## My Inception
### Install virtual machine

Firstly, you can download virtualization software such as VirtualBox or VMWare, for instance. Considering that you're on an ARM64 architecture, I would personally using Parallels Desktop on Mac.
Next, you can download the iso of Debian here : https://www.debian.org/distrib/netinst.

<p align="center">
  <b>Let's now create a VM.</b>
</p>

<p align="center">
  <img src="https://github.com/BaBreton/42-Inception/blob/main/.assets/VM1.png" width="400px" alt="Image 0"/>
  <img src="https://github.com/BaBreton/42-Inception/blob/main/.assets/VM2.png" width="400px" alt="Image 1">
  <img src="https://github.com/BaBreton/42-Inception/blob/main/.assets/VM3.png" width="330px" alt="Image 2">
</p>

I then install Debian 12 on the VM, I won't go into detail about the installation, and directly advanced to configuration.

After typing these commands :
```bash
 sudo apt-get update
 sudo apt-get upgrade -y
```

We can know start the configurations.
Following the official [docker documentation](https://docs.docker.com/engine/install/debian/), you can now type these commands :
```bash
 sudo apt-get update
 sudo apt-get install ca-certificates curl gnupg
 sudo install -m 0755 -d /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 sudo chmod a+r /etc/apt/keyrings/docker.gpg

 echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 sudo apt-get update
```

It will add Docker's offical GPG key to the keyrings file and add the repository to Apt sources. We can know install Docker, and try if the installation was succesful with : 

```bash
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo docker run hello-world
```

<p align="center">
  <b>Docker is now installed.</b>
</p>

<p align="center">
  <img src="https://github.com/BaBreton/42-Inception/blob/main/.assets/DOCKERSUCCES.png" width="500px" alt="Image 3"/>
</p>

---

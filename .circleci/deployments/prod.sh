wget -O packer.zip https://releases.hashicorp.com/packer/1.2.2/packer_1.2.2_linux_amd64.zip
unzip packer.zip
./packer validate packer-template.json
./packer build packer-template.json

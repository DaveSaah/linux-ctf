#!/bin/bash

level_users=()

# Loop through each level
for ((i = 1; i <= LEVEL_COUNT; i++)); do
	level="level$i"
	level_dir="/home/davesaah/codes/linux-ctf/scripts/levels/$level"

	# create level
	sudo useradd --home=$level_dir -s /bin/bash $level

	# Add the user to the docker group for Docker access
	sudo usermod -aG docker $level

	# Add readme
	echo "# $level" | sudo tee $level_dir/README.md >/dev/null
	sudo chmod a+rx $level_dir/README.md
	sudo chown $level:$level $level_dir/README.md

	# Set level directory permissions
	sudo chmod a+rx $level_dir
	sudo chown $level:$level $level_dir

	echo "$level created."
	level_users+=("$level")
done

# update ssh config to point to docker wrapper script
IFS=',' # set Internal Field Separator
levels_string="${level_users[*]}"
unset IFS

sudo sed -i '/^Match User level.*/, $d' /etc/ssh/sshd_config
echo -e "Match User ${levels_string}
\tForceCommand /home/davesaah/codes/linux-ctf/scripts/ssh_docker_wrapper.sh
\tPermitTunnel no
\tAllowTcpForwarding no
\tX11Forwarding no" | sudo tee -a /etc/ssh/sshd_config >/dev/null

sudo systemctl restart sshd
echo "Levels created successfully."

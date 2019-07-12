# Configure Docker CE repo
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                    $(lsb_release -cs) stable"

# Accept Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Update Apt index
apt-get update

# Install mysql-client
apt install -y mysql-client

# Install latest version of Docker CE
apt install -y docker-ce

# Install Docker Compose and make binary executable
curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" \
     -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create SSH config & keys
cat > ~ubuntu/.ssh/config << EOF
Host *
 ForwardAgent yes
 ServerAliveInterval 180
 ServerAliveCountMax 9999
 TCPKeepAlive yes
 ConnectTimeout 2
 UserKnownHostsFile /dev/null
 StrictHostKeyChecking no

Host 172.*
 IdentityFile ~/.ssh/tfe-hostworks-ec2.key
EOF
cat > ~ubuntu/.ssh/ec2.key << EOF
-----BEGIN RSA PRIVATE KEY-----
DEMO
-----END RSA PRIVATE KEY-----
EOF
cp /home/ubuntu/.ssh/*.key /root/.ssh/
cp /home/ubuntu/.ssh/config /root/.ssh/
chown ubuntu:ubuntu /home/ubuntu/.ssh/*
chmod 600 /home/ubuntu/.ssh/* /root/.ssh/*

# Add ubuntu to the docker group (for Docker mgmt)
usermod -a -G docker ubuntu

# Install kubectl
apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

# Install RKE https://bit.ly/2THkr4B
wget -q https://github.com/rancher/rke/releases/download/v0.2.0/rke_linux-amd64 -O /usr/local/bin/rke
chmod 755 /usr/local/bin/rke

# Install helm client https://bit.ly/2uEgBiO
snap install helm --classic

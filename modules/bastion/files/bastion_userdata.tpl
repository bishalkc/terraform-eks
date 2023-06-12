#cloud-config
hostname: ${hostname}
fqdn:  ${fqdn}
manage_etc_hosts: true
repo_update: true
repo_upgrade: all
packages:
 - curl
 - wget
 - nc
runcmd:
 - sudo yum remove awscli
 - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
 - unzip awscliv2.zip
 - sudo ./aws/install
 - mkdir ~/.kube
 - sudo yum install amazon-linux-extras -y
 - sudo wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/v${version}/bin/linux/amd64/kubectl && sudo chmod 0755 /usr/local/bin/kubectl

power_state:
 delay: "+2"
 mode: reboot
 message: Bye Bye
 timeout: 30

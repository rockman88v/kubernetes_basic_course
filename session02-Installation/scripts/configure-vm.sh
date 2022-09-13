#Disable SELinux
sudo setenforce 0
sudo sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

#Disable firewall
sudo systemctl stop firewalld
sudo systemctl disable firewalld

#Enable IP Forwarding
sudo sysctl -w net.ipv4.ip_forward=1


#update hostfile for installation server
echo "192.168.10.11 master1" |sudo tee -a /etc/hosts
echo "192.168.10.12 worker1" |sudo tee -a /etc/hosts
echo "192.168.10.13 worker2" |sudo tee -a /etc/hosts

cd ~
mkdir kubernetes_installation/

#install & configure docker on installation server
sudo yum update
curl -fsSL https://get.docker.com/ | sh
sudo usermod -aG docker sysadmin

#download kubespray
git clone https://github.com/kubernetes-sigs/kubespray.git --branch release-2.16
cd /home/sysadmin/kubernetes_installation/kubespray
cp -rf inventory/sample inventory/viettq-cluster

#configure your cluster before installation
cd /home/sysadmin/kubernetes_installation/kubespray/
cd inventory/viettq-cluster

#This must be done manually
vi host.yaml

#Change network CNI plugin to flannel
cd /home/sysadmin/kubernetes_installation/kubespray/
sed -i "/kube_network_plugin:/c\kube_network_plugin: flannel" inventory/viettq-cluster/group_vars/k8s_cluster/k8s-cluster.yml

docker run --rm -it --mount type=bind,source=/home/sysadmin/kubernetes_installation/kubespray/inventory/viettq-cluster,dst=/inventory \
quay.io/kubespray/kubespray:v2.16.0 bash 

#run this command inside to newly created container above
ansible-playbook -i /inventory/hosts.yaml cluster.yml --user=sysadmin --ask-pass --become --ask-become-pass

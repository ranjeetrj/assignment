Install Docker By using following commands.

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common


For adding Docker offical GPG key:

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

To add repository:

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

Install Docker Engine

apt-get install docker-ce docker-ce-cli containerd.io
apt-get install docker-ce=5:19.03.3~3-0~ubuntu-xenial docker-ce-cli=5:19.03.3~3-0~ubuntu-xenial containerd.io

Creating Kubernetes cluster:

Add k8s GPG key for installation

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add

Add K8s Repo

echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

Update package list and install required packages to run k8s

apt-get update
apt-get install -y kubelet kubeadm kubectl kubernetes-cni


Now initialize the node

kubeadm init 

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

To install POD network:

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

By Default your cluster will not schedule any pod on master node.
To schedule pod on master node use below command:

kubectl taint nodes --all node-role.kubernetes.io/master-

kubectl create -f nginx.yaml(File attached to this project)

The webserver will be available at (IP:30010)


Now the kubernetes cluster is ready.

Installation of Jenkins:

To install jenkins you need java for that use below commands:

apt-get update
apt-get install openjdk-8-jdk

Now start installing Jenkins:

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins

Unlock jenkins

http://your_ip_address:8080

Enter password from here:

cat /var/lib/jenkins/secrets/initialAdminPassword

Installed suggested plugin

create the user

Done with the Jenkins Installation.

Create the one jenkins project.

Giving jenkins user docker and kubectl command access:

Copy .kube directory to jenkins $HOME directory so jenkins user will get kubectl command access.

Add jenkins user in docker group so jenkins user can use docker command.
usermod -aG docker jenkins


For creating docker repo login to docker hub https://hub.docker.com/ and create you repo.

docker tag nginx:latest rjsrisri/ranjeet:latest
docker push rjsrisri/ranjeet:latest


For creating github repo login to https://github.com/
In your created repo, go to setting and add webhook--> use below url as Payload URL mentioned below
http://jenkins_ip:port/github-webhook/

Now if u add anything in index.html it will reflect in http://IP:30010 url

Note: Jenkins project script and Dockerfile attached to this repo.












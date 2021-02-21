# CrossForest-simulations
simulations performed at hpc - scripts and notes

Centos 7


# Install
## 1st update system
[sudo] yum update -y

## ssh server
https://phoenixnap.com/kb/how-to-enable-ssh-centos-7
    1  sudo yum –y install openssh-server openssh-clients
    2  sudo systemctl start sshd
    3  sudo systemctl status sshd
    4  sudo systemctl enable sshd
    5  sudo nano /etc/ssh/sshd_config
    6  sudo service sshd restart
### FIREWALL -- quizá no sea tan necesario
sudo nano /etc/sysconfig/iptables

## python 3
https://www.liquidweb.com/kb/how-to-install-python-3-on-centos-7/
yum install -y python3
https://www.cyberithub.com/how-to-install-pip3-utility-on-linux-rhel-centos-7-8-easy-steps/


## install simanfor --- 
### copy with scp (desde el terminal en el ordenador en el que este ya descargado)
scp -r -p ./simulator/ simanfor@192.168.1.2:/home/simanfor/simanfor
### instalacion de paquetes de python3 (como root) tiene que estar instalado pip3
sh /home/simanfor/simanfor/simulator/install.sh 

## install R (as root...)
https://linuxize.com/post/how-to-install-r-on-centos-7/
yum install epel-release
yum install R

## install csvtk, downloadable at: https://bioinf.shenwei.me/csvtk/
https://www.linux.com/training-tutorials/writing-simple-bash-script/
http://tldp.org/LDP/Bash-Beginners-Guide/html/
https://bash.cyberciti.biz/guide/For_loop
### download in outside computer https://github.com/shenwei356/csvtk/releases
wget https://github.com/shenwei356/csvtk/releases/download/v0.22.0/csvtk_linux_amd64.tar.gz
#### unzip and copy to system with scp and sudo 
scp ./csvtk root@192.168.1.2:/usr/local/bin/

## install emacs and ess (as root)
yum install epel-release
yum install emacs
### ess https://ess.r-project.org/index.php?Section=download
tar zxvf ess-18.10.2.tgz
gpg --keyserver hkp://pgp.mit.edu --recv-key 68E0DB0F
gpg --verify ess-18.10.zip.sig  ess-18.10.zip

## install git repo
https://github.com/simanfor-dask/CrossForest-simulations.git

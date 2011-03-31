#! /bin/sh

apt-get install r-cran-rserve python python-rpy2 python-biopython \
    python-rpy r-base r-cran-rserve r-cran-rjava default-jdk \
    perl bioperl ruby1.9.1 libbio-ruby python-setuptools

easy_install pyRserve
easy_install SOAPpy
easy_install session
gem1.9.1 install bio

# build

mkdir /var/packages
cd /var/packages
wget http://bio4.dnsalias.net/download/BioNode/contrib/RSOAP-1.1.3.tar.gz
tar xvzf RSOAP-1.1.3.tar.gz 
cd RSOAP-1.1.3
python setup.py install 

cd /var/packages
wget http://cran.r-project.org/src/contrib/session_1.0.2.tar.gz
R CMD INSTALL session_1.0.2.tar.gz 


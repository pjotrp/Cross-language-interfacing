#! /bin/sh
#
# This script installs packages for running the tests (on BioNode)
# Some of this should find its way into Debian proper.

apt-get install r-cran-rserve python-dev python-rpy2 python-biopython \
    python-rpy r-base r-cran-rserve r-cran-rjava default-jdk \
    perl bioperl ruby1.9.1 libbio-ruby python-setuptools scala \
    jython cmake swig

# Python packages
easy_install pyRserve
easy_install SOAPpy
easy_install session

# bioruby for Ruby 1.9
gem1.9.1 install --no-rdoc --no-ri bio  

# build RSOAP
mkdir /var/packages
cd /var/packages
wget http://bio4.dnsalias.net/download/BioNode/contrib/RSOAP-1.1.3.tar.gz
tar xvzf RSOAP-1.1.3.tar.gz 
cd RSOAP-1.1.3
python setup.py install 

# Build the R session package
cd /var/packages
wget http://cran.r-project.org/src/contrib/session_1.0.2.tar.gz
R CMD INSTALL session_1.0.2.tar.gz 

# BioLib

cd /var/packages
if [ ! -d biolib ]; then
  git clone git://github.com/pjotrp/biolib.git
  cd biolib
  ./configure --with-python --with-emboss 
  make
  make install
fi


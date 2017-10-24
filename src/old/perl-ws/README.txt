Both programs except you to run the Java server for each type of service. SOAP is run on port 9090 with REST on port 9091.

* N.B. You only need to compile the jar with ant & chmod the perl files to executable once *

SOAP
====

Running Java SOAP:

cd src/biojava/java
ant clean jar
. setup.env
java javaa.soap.Server

Using the Perl client:

cd src/perl-ws
chmod +x *.pl
./soap.pl ATGATGATG

REST
====

Running Java REST:

cd src/biojava/java
ant clean jar
. setup.env
java javaa.rest.Server

Using the Perl Client:

cd src/perl-ws
chmod +x *.pl
./rest.pl ATGATGATG

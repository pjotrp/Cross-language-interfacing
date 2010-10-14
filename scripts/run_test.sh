#! /bin/bash
#

testname=$1
if [ $testname == "--short" ]; then
  quick=true
  testname=$2
fi

echo $testname
echo $quick

function runtest {
  if [ -z $testname ] || [ "$testname" == "$short" ]; then
    echo "# Running $descr"
    for pkg in $pkgs ; do
      echo -n "# "
      dpkg-query -W $pkg
    done
    # fill OS buffers
    for testsize in $testsizes ; do
      testfn=/tmp/test-dna-${testsize}.fa
      fullcmd="$cmd"
      # Dummy run
      $fullcmd $testfn > /dev/null
      for x in $repeat ; do 
        echo -en "=\t$short\t$testsize\t"
        # var=$(time (echo 1 > /dev/null ) 2>&1 )
        $timer $fullcmd 2>&1 $testfn > /dev/null 
      done
    done
  fi
}

function runRtest {
  if [ -z $testname ] || [ "$testname" == "$short" ]; then
    echo "# Running $descr"
    for pkg in $pkgs ; do
      echo -n "# "
      dpkg-query -W $pkg
    done
    # fill OS buffers
    for testsize in $testsizes ; do
      testfn=/tmp/test-dna-${testsize}.fa
      echo "/usr/bin/time -f %e env BATCH_VARS="$testfn" R -q --no-save --no-restore --no-readline --slave < $cmd > /dev/null"
    done
  fi

}

timer="/usr/bin/time -f %e"
if [ ! -z $quick ] ; then
  testsizes="50 100 200 500"
  repeat="1"
else
  testsizes="50 100 200 500 1000 5000 15000 24652"
  repeat="1 2 3"
fi

cat /proc/version
pkgs="python python-rpy2 python-biopython"
short="RPy2"
descr="RPy2+GeneR"
cmd="python src/RS/RPy2/DNAtranslate_RPy2.py"
runtest
pkgs="python python-rpy r-base r-cran-rserve r-cran-rjava default-jdk"
short="Python+Rserve"
descr=$short
cmd="python src/RServe/python/DNAtranslate.py"
runtest
pkgs="perl bioperl"
short="Bioperl"
descr="Bioperl"
cmd="perl src/bioperl/DNAtranslate.pl"
runtest
pkgs="python python-biopython"
short="Biopython"
descr="Biopython"
cmd="python src/biopython/DNAtranslate.py"
runtest
pkgs="ruby1.9.1 libbio-ruby"
short="BioRuby"
descr="BioRuby"
cmd="ruby1.9.1 -I ~/opt/ruby/bioruby/lib/ src/bioruby/DNAtranslate.rb"
runtest
pkgs="r-base"
short="R+Biostrings"
descr=$short
cmd="./src/R/DNAtranslate_Biostrings.R"
runRtest
pkgs="r-base"
short="R+GeneR"
descr=$short
cmd="./src/R/DNAtranslate_GeneR.R"
runRtest
pkgs=""
short="BioJava"
descr="BioJava+BioScala"
cmd="./src/biojava/scala/DNAtranslate"
runtest
pkgs=""
short="biolib+ruby"
descr="Ruby+BigBio+Biolib/EMBOSS"
cd src/biolib/ruby
cmd="./DNAtranslate.rb"
runtest
cd ../../..
pkgs=""
short="biolib+python"
descr="Python+BioPython+Biolib/EMBOSS"
cd src/biolib/python
cmd="./DNAtranslate_EMBOSS.py"
runtest
cd ../../..

echo "Done."

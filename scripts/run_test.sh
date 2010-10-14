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
    # fill OS buffers
    echo Running $descr
    for testsize in $testsizes ; do
      testfn=/tmp/test-dna-${testsize}.fa
      # Dummy run
      $cmd $testfn > /dev/null
      for x in $repeat ; do 
        echo -en "=\t$short\t$testsize\t"
        # var=$(time (echo 1 > /dev/null ) 2>&1 )
        $timer $cmd 2>&1 $testfn > /dev/null 
      done
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

short="RPy2"
descr="RPy2+GeneR"
cmd="python src/RS/RPy2/DNAtranslate_RPy2.py"
runtest
short="Biopython"
descr="Biopython"
cmd="python src/biopython/DNAtranslate.py"
runtest
short="BioRuby"
descr="BioRuby (ruby1.9.2)"
cmd="ruby1.9.1 -I ~/opt/ruby/bioruby/lib/ src/bioruby/DNAtranslate.rb"
runtest

echo "Done."

#! /bin/bash
#

quick=$1

function runtest {
  # fill OS buffers
  echo Running $descr
  for testsize in $testsizes ; do
    testfn=/tmp/test-dna-${testsize}.fa
    # Dummy run
    $cmd $testfn > /dev/null
    for x in 1 2 3 ; do 
      echo -en "=\t$short\t$testsize\t"
      # var=$(time (echo 1 > /dev/null ) 2>&1 )
      $timer $cmd 2>&1 $testfn > /dev/null 
    done
  done
}

timer="/usr/bin/time -f %e"
if [ ! -z $quick ] ; then
  testsizes="50 100 200 500"
else
  testsizes="50 100 200 500 1000 5000 15000 24652"
fi

short="RPy2"
descr="RPy2"
cmd="python src/RS/RPy2/DNAtranslate_RPy2.py"
runtest
short="bioruby"
descr="BioRuby (ruby1.9.2)"
cmd="ruby1.9.1 -I ~/opt/ruby/bioruby/lib/ src/bioruby/DNAtranslate.rb"
runtest

echo "Done."

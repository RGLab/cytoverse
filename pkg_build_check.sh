curDir=~/rglab/workspace
repoNames=(flowCore ncdfFlow flowWorkspace openCyto CytoML flowStats COMPASS ggcyto)

test_dir=`mktemp -d -p "/home/wjiang2/Downloads"`
for repoName in ${repoNames[@]:5:1}
do

        cd ${curDir}/${repoName}
        echo $repoName
        #rm $(TEST) -rf
        test_pkg=${test_dir}/$repoName
        git checkout-index --prefix=${test_pkg}/ -af
        #devtools::check doesn't use local R lib dir
        Rscript --verbose -e 'rcmdcheck::rcmdcheck("'${test_pkg}'", quiet = F)'
       #  Rscript --verbose -e 'devtools::build_vignettes("'${test_pkg}'")'
  #      R CMD build ${test_pkg}
  #      R CMD check ${test_pkg}#can't run check directly on src due to meta symbol in DESC sometime
done

#run some internal tests
        #Rscript --verbose -e 'library(testthat);library(openCyto);test_file("~/rglab/workspace/openCyto/tests/testthat/gating-testSuite.R")'
        #Rscript --verbose -e 'library(testthat);library(CytoML);test_file("~/rglab/workspace/CytoML/tests/testthat/Cytobank2GatingSet-InternalTestSuite.R");
	#													        test_file("~/rglab/workspace/CytoML/tests/testthat/GatingSet2flowJo-InternalTestSuite.R");test_file("~/rglab/workspace/CytoML/tests/testthat/diva2gs-InternalTestSuite.R");test_file("~/rglab/workspace/CytoML/tests/testthat/flowjo2gs_internalTestSuite.R")'


# https://support.rstudio.com/hc/en-us/articles/200496518-Customizing-Package-Build-Options
/home/lei/bin/R-3.4.0/bin/R CMD BATCH document.R
/home/lei/bin/R-3.4.0/bin/R CMD build ../../ #--no-examples  --no-build-vignettes 
/home/lei/bin/R-3.4.0/bin/R CMD check microbiome_0.99.49.tar.gz #--no-build-vignettes --no-examples
/home/lei/bin/R-3.4.0/bin/R CMD BiocCheck microbiome_0.99.49.tar.gz
/home/lei/bin/R-3.4.0/bin/R CMD INSTALL microbiome_0.99.49.tar.gz 

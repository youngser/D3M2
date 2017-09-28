RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN set -ex \
	&& Rscript -e 'install.packages(c("rjson", "tidyverse", "Matrix", "fpc", "devtools","mclust","clue", "igraph"i, "irlba"), dependencies = c("Depends", "Imports"))' \
        && Rscript -e 'devtools::install_github(c("youngser/gmmase", "youngser/VN"))' 

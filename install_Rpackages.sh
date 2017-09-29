apt-get install -y gdebi-core
wget https://download1.rstudio.org/rstudio-1.0.153-amd64.deb
gdebi --option=APT::Get::force-yes=1,APT::Get::Assume-Yes=1 -n rstudio-1.0.153-amd64.deb

su - -c "Rscript -e \"install.packages(c('knitr','rmarkdown','rjson','devtools','Matrix','fpc','mclust','clue','igraph','irlba'), dependencies = c('Depends', 'Imports'), repos='http://cran.us.r-project.org')\""

su - -c "Rscript -e \"devtools::install_github(c('hadley/tidyverse', 'youngser/gmmase', 'youngser/VN'))\""

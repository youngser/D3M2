su - -c "Rscript -e \"install.packages(c('knitr','rmarkdown','rjson','devtools','Matrix','fpc','mclust','clue','igraph','irlba'), dependencies = c('Depends', 'Imports'), repos='http://cran.us.r-project.org')\""

su - -c "Rscript -e \"devtools::install_github(c('hadley/tidyverse', 'youngser/gmmase', 'youngser/VN'))\""

Rscript -e \"install.packages(c('rjson', 'tidyverse','devtools','Matrix','fpc','mclust','clue','igraph','irlba'), dependencies = c('Depends', 'Imports'), repos='http://cran.us.r-project.org')\"

Rscript -e \"devtools::install_github(c('youngser/gmmase', 'youngser/VN'))\"

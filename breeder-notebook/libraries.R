install.packages("devtools", dependencies = TRUE, repos = "http://cran.us.r-project.org")

# CRAN
devtools::install_version("sommer",      version = "4.3.1",   dependencies = TRUE, repos = "http://cran.us.r-project.org")
devtools::install_version("visNetwork",  version = "2.1.2",   dependencies = TRUE, repos = "http://cran.us.r-project.org")
devtools::install_version("plotly",      version = "4.10.0",  dependencies = TRUE, repos = "http://cran.us.r-project.org")
devtools::install_version("BiocManager", version = "1.30.21", dependencies = TRUE, repos = "http://cran.us.r-project.org")

# Bioconductor
BiocManager::install(version = "3.17")
BiocManager::install("SummarizedExperiment")
BiocManager::install("ggtree")

# GitHub, etc
remotes::install_github("maize-genetics/rtassel", dependencies = TRUE)
remotes::install_github("maize-genetics/rphg",    dependencies = TRUE)

# Link R kernel with Jupyter
IRkernel::installspec()
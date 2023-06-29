require(devtools)

# CRAN
install_version("sommer",      version = "4.3.1",   repos = "http://cran.us.r-project.org")
install_version("visNetwork",  version = "2.1.2",   repos = "http://cran.us.r-project.org")
install_version("plotly",      version = "4.10.0",   repos = "http://cran.us.r-project.org")
install_version("BiocManager", version = "1.30.21", repos = "http://cran.us.r-project.org")

# Bioconductor
BiocManager::install(version = "3.16") # We're using R 4.2, so can't use most recent version
BiocManager::install("SummarizedExperiment")
BiocManager::install("ggtree")

# GitHub, etc
remotes::install_github("maize-genetics/rtassel")
remotes::install_github("maize-genetics/rphg")
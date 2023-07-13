# CRAN
devtools::install_version("sommer",      version = "4.3.1",   dependencies = TRUE, repos = "http://cran.us.r-project.org")
devtools::install_version("visNetwork",  version = "2.1.2",   dependencies = TRUE, repos = "http://cran.us.r-project.org")
devtools::install_version("plotly",      version = "4.10.0",  dependencies = TRUE, repos = "http://cran.us.r-project.org")
devtools::install_version("BiocManager", version = "1.30.21", dependencies = TRUE, repos = "http://cran.us.r-project.org")
devtools::install_version("QBMS",        version = "0.9.1",   dependencies = TRUE, repos = "http://cran.us.r-project.org")

# Bioconductor
BiocManager::install("SummarizedExperiment")
BiocManager::install("ggtree")

# GitHub, etc
remotes::install_github("maize-genetics/rtassel",    dependencies = TRUE)
remotes::install_github("maize-genetics/rphg",       dependencies = TRUE)
remotes::install_github("btmonier/r_flapjack_bytes", dependencies = TRUE)
remotes::install_github("r-lib/async",               dependencies = TRUE)
remotes::install_github("icarda-git/QBMS",           dependencies = TRUE)

# Link R kernel with Jupyter
IRkernel::installspec()
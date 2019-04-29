
<!-- README.md is generated from README.Rmd. Please edit that file -->
cytoverse <a href='https:/cytoverse.org'><img src='man/figures/logo.png' align="right" height="138.5" /></a>
============================================================================================================

Overview
--------

The cytoverse is a set of packages that are commonly used for cytometry data analysis. The **cytoverse** package is designed to make it easy to install and load core packages from the cytoverse in a single command.

Installation
------------

``` r
# Install from Bioconductor
BiocManager::install("cytoverse")

# Or the development version from GitHub
# install.packages("devtools")
devtools::install_github("RGLab/cytoverse")
```

Usage
-----

`library(cytoverse)` will load the core cytoverse packages:

-   <img src = "https://github.com/RGLab/sticker/raw/master/flowworkspace/logo.png">[flowWorkspace](http:/github.com/RGLab/flowWorkspace), for gated data interaction.
-   <img src = "https://github.com/RGLab/sticker/raw/master/opencyto/logo.png">[openCyto](http:/github.com/RGLab/openCyto), for auto gating.
-   <img src = "https://github.com/RGLab/sticker/raw/master/ggcyto/logo.png">[ggcyto](http:/github.com/RGLab/ggcyto), for data visualisation.
-   <img src = "https://github.com/RGLab/sticker/raw/master/cytoml/logo.png">[CytoML](http:/github.com/RGLab/CytoML), for data analysis import/export through gatingML/xml.

``` r
library(cytoverse)
#> ── Attaching packages ─────────────────────────────────────────────────────────── cytoverse 0.0.0.9000 ──
#> ✔ flowCore      1.49.10     ✔ ggcyto        1.11.5 
#> ✔ flowWorkspace 3.31.16     ✔ CytoML        1.9.6  
#> ✔ openCyto      1.21.4
```


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

-   [ggcyto](http:/ggcyto.cytoverse.org), for data visualisation.
-   [openCyto](http://openCyto.cytoverse.org), for auto gating.
-   [flowWorkspace](http://flowWorkspace.cytoverse.org), for gated data interaction.
-   [CytoML](http://CytoML.cytoverse.org), for data import/export through gatingML/xml.

``` r
library(cytoverse)
#> ── Attaching packages ───────────────────────────────────────────────────────────────── cytoverse 0.99 ──
#> ✔ flowCore      1.49.10     ✔ ggcyto        1.11.5 
#> ✔ flowWorkspace 3.31.16     ✔ CytoML        1.9.6  
#> ✔ openCyto      1.21.4
#> ── Conflicts ─────────────────────────────────────────────────────────────────── cytoverse_conflicts() ──
#> ✖ ggcyto::%+%()               masks ggplot2::%+%()
#> ✖ flowCore::%in%()            masks base::%in%()
#> ✖ flowCore::alias()           masks stats::alias()
#> ✖ flowCore::assign()          masks base::assign()
#> ✖ CytoML::colnames()          masks flowWorkspace::colnames(), ncdfFlow::colnames(), flowCore::colnames(), base::colnames()
#> ✖ flowWorkspace::colnames<-() masks ncdfFlow::colnames<-(), flowCore::colnames<-(), base::colnames<-()
#> ✖ flowCore::eval()            masks base::eval()
#> ✖ ncdfFlow::filter()          masks flowCore::filter(), stats::filter()
#> ✖ flowCore::head()            masks utils::head()
#> ✖ flowWorkspace::lapply()     masks ncdfFlow::lapply(), base::lapply()
#> ✖ flowCore::ls()              masks base::ls()
#> ✖ flowCore::ncol()            masks base::ncol()
#> ✖ flowCore::nrow()            masks base::nrow()
#> ✖ openCyto::plot()            masks flowWorkspace::plot(), flowCore::plot(), graphics::plot()
#> ✖ ggcyto::print()             masks flowCore::print(), base::print()
#> ✖ ncdfFlow::split()           masks flowCore::split(), base::split()
#> ✖ flowCore::summary()         masks base::summary()
#> ✖ flowCore::tail()            masks utils::tail()
#> ✖ ggcyto::transform()         masks flowWorkspace::transform(), ncdfFlow::transform(), flowCore::transform(), base::transform()
#> ✖ ncdfFlow::unlink()          masks base::unlink()
```


<!-- README.md is generated from README.Rmd. Please edit that file -->

# cytoverse <a href='https:/cytoverse.org'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

## Overview

The cytoverse is a set of packages that are commonly used for cytometry
data analysis. The **cytoverse** package is designed to make it easy to
install and load core packages from the cytoverse in a single command.
It also provides helper commands to check the versions of installed
cytoverse packages.

## Installation

``` r
# Install the cytoverse package
devtools::install_github("RGLab/cytoverse")
# Load the package
library(cytoverse)
# Install all cytoverse packages and their dependencies
cytoverse_update()
```

## Usage

`library(cytoverse)` will load the core cytoverse packages (once they
are installed):

  - [flowWorkspace](http:/github.com/RGLab/flowWorkspace), for gated
    data interaction.
  - [ggcyto](http:/github.com/RGLab/ggcyto), for data visualisation.
  - [openCyto](http:/github.com/RGLab/openCyto), for auto gating.
  - [CytoML](http:/github.com/RGLab/CytoML), for data analysis
    import/export through gatingML/xml.

<!-- end list -->

``` r
library(cytoverse)
#> ── Attaching packages ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── cytoverse 0.0.0.9000 ──
#> ✓ flowCore      2.1.0      ✓ openCyto      2.1.0 
#> ✓ flowWorkspace 4.1.4      ✓ CytoML        2.1.6 
#> ✓ ggcyto        1.17.0
```

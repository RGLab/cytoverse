#' Update cytoverse packages
#'
#' This will check to see if all cytoverse packages (and optionally, their
#' dependencies) are up-to-date and installl those that are behind. The \code{repo} argument
#' will determine whether to update from Bioconductor or GitHub and the \code{pkgs} argument
#' allows for specification of a subset of packages to update.
#' 
#' This utilizes either \code{\link[BiocManager:install]{BiocManager::install}} for Bioconductor or \code{\link[remotes:install_github]{remotes::install_github}}
#' to check for package updates to install. As such, additional arguments can be passed to either of those methods.
#' Please see the examples for the most typical use cases. \code{If repo="bioconductor"} is used and \code{BiocManager} is unavailable, it will be installed.
#' 
#' @param repo Either "bioconductor" or "github" specifying whether to use Bioconductor or the
#' RGLab GitHub package repositories
#' @param pkgs A character vector containing a specific subset of cytoverse packages to check for updates. 
#' If NULL, all cytoverse packages will be checked. For the full list of packages, see \code{\link{cytoverse_packages}}.
#' @param ... Other arguments passed to either \code{\link[BiocManager:install]{BiocManager::install}} or \code{\link[remotes:install_github]{remotes::install_github}}
#' @export
#' @examples
#' \dontrun{
#' # Default behavior. Update all cytoverse packages from
#' # appropriate Bioconductor release.
#' cytoverse_update() 
#' 
#' # Still using appropriate Bioconductor release, but limiting to just checking
#' # a few packages for updates.
#' cytoverse_update(pkgs = c("flowWorkspace", "CytoML"))
#' 
#' # Specify that you would like to use the current development branches from Bioconductor
#' cytoverse_update(version = "devel")
#' 
#' # Override default repository (Bioconductor) to instead install from GitHub
#' cytoverse_update(repo = "github")
#' 
#' # An example showing extra arguments being passed down to install_github.
#' # Only update cytoqc and all of its dependencies (including from "Suggests" and "Enhances" sections)
#' cytoverse_update(repo = "github", pkgs = "cytoqc", dependencies = TRUE)
#' 
#' }
cytoverse_update <- function(repo = "bioconductor", pkgs = NULL, ...) {
  if(is.null(pkgs))
    pkgs <- all_pkgs
  repo = match.arg(tolower(repo), c("bioconductor", "github"))
  if(repo == "bioconductor"){
    if (!requireNamespace("BiocManager", quietly = TRUE))
      install.packages("BiocManager")
    args <- list(...)
    if(!is.null(args$version))
      BiocManager::install(version=args$version)
    BiocManager::install(pkgs, ...)
  }else{
    if("cytoqc" %in% pkgs)
      remotes::install_github(paste("thebioengineer/colortable"), ...)
    remotes::install_github(paste("RGLab", pkgs, sep = "/"), ...)
  }
  invisible()
}
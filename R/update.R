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
#' @inheritParams cytoverse_update_check
#' @param check_versions a logical indicating whether the package versions should be checked to determine which packages to update. This defaults to TRUE, but if switched
#' to FALSE, installation will default to checking commit SHA. This can be used to force updates for commits between version increments.
#' @param upgrades_approved a logical indicating whether the user should be asked to approve/disapprove the proposed package updates. Defaults to FALSE, but If set to TRUE, 
#' the interactive prompt will be skipped and the updates will proceed automatically.
#' @param ... Other arguments passed to either \code{\link[BiocManager:install]{BiocManager::install}} or \code{\link[remotes:install_github]{remotes::install_github}}
#' @export
#' @examples
#' \dontrun{
#' # Default behavior. Update all cytoverse packages from
#' # appropriate Bioconductor release. Asks for approval of proposed updates.
#' cytoverse_update()
#' 
#' # Same as above, but do not ask for approval before proceeding with installation
#' cytoverse_update(upgrades_approved = TRUE)
#' 
#' # Still using appropriate Bioconductor release, but limiting to just checking
#' # a few packages for updates. check_versions = FALSE makes the method attempt to
#' # update all packages, relying on commit SHA to determine if packages are up-to-date
#' cytoverse_update(pkgs = c("flowWorkspace", "CytoML"), check_versions = FALSE)
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
cytoverse_update <- function(repo = "bioconductor", pkgs = NULL, branch = NULL, check_versions = TRUE, upgrades_approved = FALSE, ...) {
  if(is.null(pkgs))
    pkgs <- all_pkgs
  repo = match.arg(tolower(repo), c("bioconductor", "github"))
  args <- list(...)
  
  if(repo == "bioconductor"){
    if("cytoqc" %in% pkgs){
      warning("Skipping installation of cytoqc, which is not yet available from Bioconductor.")
      pkgs <- pkgs[-which(pkgs == "cytoqc")]
    }
    if(check_versions){
      check_results <- cytoverse_update_check(rep = "bioconductor", pkgs = pkgs, branch = branch)
      print(check_results$summary)
      if(length(check_results$to_update) > 0)
        to_install <- check_results$to_update
      else{
        message("All packages are up to date!")
        return(invisible())
      }
    }else{
      to_install <- pkgs
    }
    
    message("The following packages will be updated: ", paste(to_install, collapse = ", "))
    if(!upgrades_approved)
      upgrades_approved <- switch(menu(c("Yes", "No"), title="Update packages?:"), TRUE, FALSE)
    if(upgrades_approved){
      if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")
      if(!is.null(branch)){
        BiocManager::install(version=branch)
        message("Updating following packages from Bioconductor version '", branch, "': ", paste(to_install, collapse = ", "))
      }
      BiocManager::install(to_install, ...)
    }
  }else{
    if(check_versions){
      check_results <- cytoverse_update_check(repo = "github", pkgs = pkgs, branch = branch)
      print(check_results$summary)
      if(length(check_results$to_update) > 0)
        to_install <- check_results$to_update
      else{
        message("All packages are  up to date!")
        return(invisible())
      }
    }else{
      to_install <- pkgs
    }
    message("The following packages will be updated: ", paste(to_install, collapse = ", "))
    if(!upgrades_approved)
      upgrades_approved <- switch(menu(c("Yes", "No"), title="Update packages?:"), TRUE, FALSE)
    if(upgrades_approved){
      if("cytoqc" %in% pkgs)
        remotes::install_github(paste("thebioengineer/colortable"), ...)
      remotes::install_github(paste("RGLab", to_install, sep = "/"), ...) 
    }
  }
  invisible()
}

#' Check available updates for all cytoverse packages
#' 
#' @param pkgs A character vector containing a specific subset of cytoverse packages to check for updates. 
#' If NULL, all cytoverse packages will be checked. For the full list of packages, see \code{\link{cytoverse_packages}}.
#' @inheritParams cytoverse_remote_version
#' @return a length-2 list containing a dataframe summarizing the installed and available package versions and 
#' a vector of package names to be updated
#' @examples
#' \dontrun{
#' # Defaults to Bioconductor
#' check_results <- cytoverse_update_check()
#' check_results$summary
#' check_results$lto_update
#' }
#' @export
cytoverse_update_check <- function(repo = "bioconductor", pkgs = NULL, branch = NULL){
  if(is.null(pkgs))
    pkgs <- all_pkgs
  if((repo == "bioconductor") && ("cytoqc" %in% pkgs)){
    warning("Skipping checking of cytoqc, which is not yet available from Bioconductor.")
    pkgs <- pkgs[-which(pkgs == "cytoqc")]
  }
  installed_versions <- sapply(pkgs, package_version, colorize = FALSE)
  remote_versions <- sapply(pkgs, cytoverse_remote_version, repo = repo, branch=branch)
  update <- mapply(compareVersion, installed_versions, remote_versions)
  update_idx <- update == -1
  to_update <- up_to_date <- rep("", length(update))
  to_update[update_idx] <- cli::symbol$tick
  summary <- data.frame(Installed = installed_versions, 
                        Available = remote_versions,
                        Update = to_update,
                        row.names = pkgs)
  list(summary = summary, to_update = pkgs[update_idx])
}

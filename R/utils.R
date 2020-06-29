msg <- function(..., startup = FALSE) {
  if (startup) {
    if (!isTRUE(getOption("cytoverse.quiet"))) {
      packageStartupMessage(text_col(...))
    }
  } else {
    message(text_col(...))
  }
}

text_col <- function(x) {
  # If RStudio not available, messages already printed in black
  if (!rstudioapi::isAvailable()) {
    return(x)
  }

  if (!rstudioapi::hasFun("getThemeInfo")) {
    return(x)
  }

  theme <- rstudioapi::getThemeInfo()

  if (isTRUE(theme$dark)) crayon::white(x) else crayon::black(x)

}

#' List all packages in the cytoverse
#'
#' @param pkgs A character specifying which packages to list. "all" will include all cytoverse packages while "core" will include only those core packages
#' that will be loaded by library(cytoverse)
#' @param include_self Include cytoverse in the list?
#' @export
#' @return a character vector of package names
#' @examples
#' cytoverse_packages()
cytoverse_packages <- function(pkgs = "all", include_self = TRUE) {
  pkgs <- match.arg(tolower(pkgs), c("all", "core"))
  names <- switch(pkgs,
                  all=all_pkgs,
                  core=core_pkgs)
  if (include_self) {
    names <- c(names, "cytoverse")
  }
  names
}

#' List package versions for all packages in the cytoverse
#' 
#' @param pkgs A character specifying which packages to list. "all" will include all cytoverse packages while "core" will include only those core packages
#' that will be loaded by library(cytoverse)
#' @param include_self Include cytoverse in the list?
#' @param print Whether to display the formatted versions or simply return them
#' @return a named character vector of package versions
#' @export
#' @examples
#' cytoverse_versions()
cytoverse_versions <- function(pkgs = "all", include_self = TRUE, print = TRUE) {
  pkgs <- cytoverse_packages(pkgs=pkgs, include_self=include_self)
  versions <- sapply(pkgs, package_version, colorize = FALSE)
  versions[is.na(versions)] <- "NA"
  if(print){
    msg(
      cli::rule(
        left = crayon::bold("Cytoverse Package Versions"),
        right = paste0("cytoverse ", package_version("cytoverse"))
      ),
      startup = TRUE
    )
    packages <- paste0(
      crayon::green(cli::symbol$tick), " ", crayon::blue(format(pkgs)), " ",
      crayon::col_align(versions, max(crayon::col_nchar(versions)))
    )
    
    if (length(packages) %% 2 == 1) {
      packages <- append(packages, "")
    }
    col1 <- seq_len(length(packages) / 2)
    info <- paste0(packages[col1], "     ", packages[-col1])
    
    msg(paste(info, collapse = "\n"), startup = TRUE)
  }
  names(versions) <- pkgs
  invisible(versions)
}

invert <- function(x) {
  if (length(x) == 0) return()
  stacked <- utils::stack(x)
  tapply(as.character(stacked$ind), stacked$values, list)
}


style_grey <- function(level, ...) {
  crayon::style(
    paste0(...),
    crayon::make_style(grDevices::grey(level), grey = TRUE)
  )
}

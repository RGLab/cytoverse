all_pkgs <- c("RProtoBufLib", "cytolib", "flowCore", "flowViz", "ncdfFlow", "flowWorkspace", "flowWorkspaceData", "flowClust", "flowStats", "ggcyto", "openCyto", "CytoML", "cytoqc")
core_pkgs <- c("flowCore", "flowWorkspace", "ggcyto", "openCyto", "CytoML")

core_loaded <- function() {
  search <- paste0("package:", core_pkgs)
  core_pkgs[search %in% search()]
}
core_unloaded <- function() {
  search <- paste0("package:", core_pkgs)
  core_pkgs[!search %in% search()]
}


cytoverse_attach <- function() {
  to_load <- core_unloaded()
  if (length(to_load) == 0)
    return(invisible())

  msg(
    cli::rule(
      left = crayon::bold("Attaching packages"),
      right = paste0("cytoverse ", package_version("cytoverse"))
    ),
    startup = TRUE
  )
  versions <- sapply(to_load, package_version)
  versions[is.na(versions)] <- "NA"
  packages <- paste0(
    crayon::green(cli::symbol$tick), " ", crayon::blue(format(to_load)), " ",
    crayon::col_align(versions, max(crayon::col_nchar(versions)))
  )

  if (length(packages) %% 2 == 1) {
    packages <- append(packages, "")
  }
  col1 <- seq_len(length(packages) / 2)
  info <- paste0(packages[col1], "     ", packages[-col1])

  msg(paste(info, collapse = "\n"), startup = TRUE)

  suppressPackageStartupMessages(
    successfully_loaded <- suppressWarnings(sapply(to_load, require, character.only = TRUE, warn.conflicts = FALSE))
  )
  if(any(!successfully_loaded))
    message(paste("Some cytoverse packages missing: ", paste(to_load[!successfully_loaded], collapse = ", "), "\n",
            "Please call cytoverse_update to add missing packages"))

  invisible()
}

package_version <- function(x, colorize = TRUE) {
  version <- tryCatch(as.character(unclass(utils::packageVersion(x))[[1]]), error = function(e) NA)

  if(colorize && length(version) > 3){
    version[4:length(version)] <- crayon::red(as.character(version[4:length(version)]))
  }
  
  if(!any(is.na(version)))
    version <- paste0(version, collapse = ".")
  version
}

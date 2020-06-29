.onAttach <- function(...) {
  needed <- core_pkgs[!is_attached(core_pkgs)]
  if (length(needed) == 0)
    return()

  crayon::num_colors(TRUE)
  cytoverse_attach()

  
}

is_attached <- function(x) {
  paste0("package:", x) %in% search()
}

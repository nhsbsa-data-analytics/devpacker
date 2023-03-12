#' Create a package, with optional software development best practices
#'
#' @description Creates a new package at given path; the package is named as the
#'   last folder in the path.
#'
#' @param path A path. If it exists, it is used. If it does not exist, it is
#'   created, provided that the parent path exists.
#' @param use_git Boolean. Initialise and make initial commits to a local git
#'   repository. By default is `TRUE`.
#' @param use_github Boolean. Create and push to a GitHub repository. By default
#'   takes value of `use_git`. If set to `TRUE`, `use_git` must also be `TRUE`.
#' @param use_ci Boolean. Set up a GitHub Action job to run R CMD CHECK. By
#'   default takes value of `use_github`. If set to `TRUE`, `use_github` must
#'   also be `TRUE`.
#' @param use_precommit Boolean. Set up `precommit` to run checks before any
#'   commit. By default takes value of `use_ci`. If set to `TRUE`, `use_git` must
#'   also be `TRUE`.
#' @param use_coverage Boolean. Set up `{covr}` and, if using GitHub, a GitHub
#'   Action to run code coverage and use the Codecov service. By default takes
#'   value of `use_ci`.
#' @param use_lintr Boolean. Set up lintr. Default `TRUE`.
#' @param use_tests Boolean. Set up testthat. Default `TRUE`.
#' @param open Boolean. Default `FALSE`.If `TRUE`, [activates][proj_activate()]
#'   the new project:
#'
#'   * If RStudio desktop, the package is opened in a new session.
#'   * If on RStudio server, the current RStudio project is activated.
#'   * Otherwise, the working directory and active project is changed.
#' @inheritDotParams usethis::create_package
#'
#' @return Path to the newly created package, invisibly.
#'
#' @export
create_package <- function(path, use_git = TRUE, use_github = use_git,
                           use_ci = use_github, use_precommit = use_ci,
                           use_coverage = use_ci, use_lintr = TRUE,
                           use_tests = TRUE, open = FALSE, ...) {
  if (!check_create_package_args(as.list(environment())[2:5])) {
    return(invisible(FALSE))
  }

  create_package_(path, open, ...)

  post_creation_steps(
    path, use_git, use_github, use_ci, use_precommit, use_coverage, use_lintr, use_tests
  )

  invisible(path)
}

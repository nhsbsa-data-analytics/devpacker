#' Create a `{shiny}` dashboard, with optional software development best practices
#'
#' @description Creates a new `{shiny}` dashboard as a  package at given path; the
#'   package is named as the last folder in the path.
#'
#' @param path A path. If it exists, it is used. If it does not exist, it is
#'   created, provided that the parent path exists.
#' @param only_git Boolean. When `TRUE`, sets all flags except `use_git` to `FALSE`.
#'   Default `FALSE`.
#' @param use_git Boolean. Initialise and make initial commits to a local git
#'   repository. Default `TRUE`.
#' @param use_github Boolean. Create and push to a GitHub repository. By default
#'   takes value of `use_git`. If set to `TRUE`, `use_git` must also be `TRUE`.
#' @param use_ci Boolean. Set up a GitHub Action job to run R CMD CHECK. By
#'   default takes value of `!only_git`. If set to `TRUE`, `use_github` must
#'   also be `TRUE`.
#' @param use_precommit Boolean. Set up `precommit` to run checks before any
#'   commit. By default takes value of `use_ci`. If set to `TRUE`, `use_git` must
#'   also be `TRUE`.
#' @param use_coverage Boolean. Set up `{covr}` and, if using GitHub, a GitHub
#'   Action to run code coverage and use the Codecov service. By default takes
#'   value of `use_ci`.
#' @param use_lintr Boolean. Set up lintr. Default `!only_git`.
#' @param use_tests Boolean. Set up testthat. Default `!only_git`.
#' @param open Boolean. Open the created project? Default `FALSE`.
#' @inheritParams golem::create_golem
#' @param ... Arguments passed to project_hook.
#'
#' @return Path to the newly created `{shiny}` package, invisibly.
#'
#' @export
create_shiny <- function(path, only_git = FALSE, use_git = TRUE,
                         use_github = !only_git, use_ci = use_github,
                         use_precommit = use_ci, use_coverage = use_ci,
                         use_lintr = !only_git, use_tests = !only_git,
                         open = FALSE, project_hook = NULL, ...) {
  if (!only_git && !check_create_package_args(as.list(environment())[3:6])) {
    return(invisible(FALSE))
  }
  create_shiny_(path, open, project_hook, ...)

  if (only_git) {
    usethis::local_project(path)
    init_git()
  } else {
    post_creation_steps(
      path, use_git, use_github, use_ci, use_precommit,
      use_coverage, use_lintr, use_tests
    )
  }

  invisible(path)
}

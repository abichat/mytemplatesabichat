#' My template for packages
#'
#' @param mail character
#' @param readme logical
#' @param news logical
#' @param test logical
#' @param spellcheck logical
#'
#' @return NULL
#' @export
#' @importFrom glue glue
#' @importFrom usethis use_description use_gpl3_license use_readme_rmd
#' use_build_ignore use_testthat use_spell_check use_news_md
#' @importFrom rstudioapi navigateToFile
#'
#' @examples
#'\dontrun{
#'init_package(news = FALSE)
#'}
init_package <- function(mail = "antoine.bichat@mines-nancy.org",
                         readme = TRUE, news = TRUE,
                         test = TRUE, spellcheck = TRUE){

  use_description(fields = list(
    `Authors@R` = glue('person("Antoine", "Bichat", email = "{mail}", \\
                          role = c("aut", "cre"), \\
                          comment = c(ORCID = "0000-0001-6599-7081"))'),
    Language =  "en-US"
    ))

  use_gpl3_license(name = "Antoine Bichat")

  if(readme) use_readme_rmd(open = FALSE)

  if(news) use_news_md(open = FALSE)

  if (test) {
    use_testthat()
    txt_test1 <- "# use_test() \n\n"
    txt_test2 <- "\ntest()\n"
  } else {
    txt_test1 <- ""
    txt_test2 <- ""
  }

  if (spellcheck) {
    use_spell_check()
    txt_spch <- glue("\n\n\nspell_check()\n# spelling",
                     "::update_wordlist()\n")
  } else {
    txt_spch <- ""
  }

  writeLines(text = glue('library(\\
                         devtools)
                         library(\\
                         usethis)\n
                         #### Initialization\n
                         mytemplatesabichat::init_package\\
                         (mail = "{mail}",
                                                          \\
                         readme = {readme}, news = {news}
                                                          \\
                         test = {test}, spellcheck = {spellcheck})\n
                         # use_r() \n
                         {txt_test1}
                         #### Repeated\n
                         load_all()\n
                         document()
                         attachment\\
                         ::att_to_description()
                         use_tidy_description()\\
                         {txt_spch}
                         {txt_test2}
                         goodpractice\\
                         ::gp()
                         check()
                         build()
                         '),
             con = "dev_history.R")

  use_build_ignore("dev_history.R")

  navigateToFile("dev_history.R")

}

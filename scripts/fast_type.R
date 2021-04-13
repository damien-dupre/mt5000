delayedAssign('go', {
  Sys.sleep(1)
  xfun::rstudio_type(
    readLines(here::here("scripts/titanic_report.md")),
    pause = function() rbeta(1, 1, 9)/5, mistake = 0, save = 0
  )
})

delayedAssign('ref', {
  Sys.sleep(1)
  xfun::rstudio_type(
    readLines(here::here("scripts/ref_report.md")),
    pause = function() rbeta(1, 1, 9)/5, mistake = 0, save = 0
  )
})

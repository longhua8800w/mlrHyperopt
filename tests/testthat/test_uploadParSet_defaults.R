context("uploadParConfig")

test_that("All the defaults are in sync with the package defaults", {
  skip_on_travis()
  skip_on_appveyor()
  skip_on_cran()
  def.par.sets = getDefaultParSetValues()
  names.split = stringi::stri_split_fixed(names(def.par.sets), pattern = ".")
  learner.type = extractSubList(names.split, 1)
  learner.name = extractSubList(names.split, 2)
  for (i in seq_along(def.par.sets)) {
    psv = def.par.sets[[i]]
    par.set = eval(psv$par.set.call)
    par.vals = eval(psv$par.vals.call)
    if (nchar(learner.type[i])>0) {
      pc = makeParConfig(par.set = par.set, par.vals = par.vals, learner = names(def.par.sets)[i])
    } else {
      pc = makeParConfig(par.set = par.set, par.vals = par.vals, learner.name = learner.name[i])
    }
    upload.try = try({uploadParConfig(pc, user.email = "code@jakob-r.de", as.default = TRUE)}, silent = TRUE)
    i = i + 1
  }
})
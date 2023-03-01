remove.packages("cabat")

devtools::install_local("/Users/adrian/Projects/cabat")

library(htmltools)

library(cabat)

standalone_cabat(num_items = 2, take_training = TRUE)
# without training
# standalone_cabat(num_items = 20, take_training = FALSE)

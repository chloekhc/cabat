practice <- function(practice_items) {
  unlist(lapply(
    list(list(id = "training3",
              answer = "1",
              no = 1L),
         list(id = "training4",
              answer = "2",
              no = 2L)
    ),
    function(x) {
      list(
        psychTestR::audio_NAFC_page(
          label = "practice_question",
          prompt = img(src = "https://github.com/chloekhc/cabat/blob/master/fig/14.jpg?raw=true", width="100%"),
          url = file.path(practice_items, paste0(x$id, ".mp3")),
          choices = as.character(c(1, 2)),
          labels = lapply(c("ABAT_0010_I_0001_1", "ABAT_0015_I_0001_1"), psychTestR::i18n),
          save_answer = FALSE,
          autoplay = FALSE
        ),
        psychTestR::reactive_page(function(answer, ...) {
          psychTestR::one_button_page(
            if (answer == x$answer) {img(src = "https://github.com/chloekhc/cabat/blob/master/fig/15.jpg?raw=true, width="100%")}
            else {img(src = "https://github.com/chloekhc/cabat/blob/master/fig/16.jpg?raw=true", width="100%")},

            button_text = psychTestR::i18n("ABAT_0021_I_0001_1")
          )}))}))
}

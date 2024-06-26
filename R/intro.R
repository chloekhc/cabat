info_page <- function(id) {
  psychTestR::one_button_page(psychTestR::i18n(id),
                              button_text = psychTestR::i18n("ABAT_0021_I_0001_1"))
}

info_image_page <- function(url) {
  psychTestR::one_button_page(div(p(img(src = url, width="100%")), p("")))
}

video_page <- function(url) {
  psychTestR::video_NAFC_page(
    label = "ex",
    prompt = "",
    choices = "Next",
    url)
}

audio_ex_page <- function(prompt_id, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = shiny::HTML(psychTestR::i18n(prompt_id)),
    choices = psychTestR::i18n("ABAT_0021_I_0001_1"),
    url = url,
    save_answer = FALSE
  )
}

audio_ex_image_page <- function(image_url, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = div(p(img(src = image_url, width="100%")), p("")),
    choices = psychTestR::i18n("ABAT_0021_I_0001_1"),
    show_controls = TRUE,
    url = url,
    save_answer = FALSE
  )
}

audio_ex_image_page1 <- function(image_url, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = div(p(img(src = image_url, width="100%")), p("")),
    choices = psychTestR::i18n("ABAT_0021_I_0001_1"),
    url = url,
    show_controls = FALSE,
    save_answer = FALSE,
    autoplay = FALSE
  )
}

intro <- function(practice_items, dict) {
  psychTestR::new_timeline(
    c(
      psychTestR::code_block(function(state, ...) {
        psychTestR::set_local("do_intro", TRUE, state)
      }),
      info_image_page("https://github.com/chloekhc/cabat/blob/master/fig/1.jpg?raw=true"),
      info_image_page("https://github.com/chloekhc/cabat/blob/master/fig/2.jpg?raw=true"),
      info_image_page("https://github.com/chloekhc/cabat/blob/master/fig/3.jpg?raw=true"),
      audio_ex_image_page("https://github.com/chloekhc/cabat/blob/master/fig/4.jpg?raw=true", file.path(practice_items, "training1.mp3")),
      info_image_page("https://github.com/chloekhc/cabat/blob/master/fig/8.jpg?raw=true"),
      audio_ex_image_page1("https://github.com/chloekhc/cabat/blob/master/fig/9.jpg?raw=true", file.path(practice_items, "training1.mp3")),
      audio_ex_image_page1("https://github.com/chloekhc/cabat/blob/master/fig/10.jpg?raw=true", file.path(practice_items, "training2.mp3")),
      info_image_page("https://github.com/chloekhc/cabat/blob/master/fig/12.jpg?raw=true"),
      info_image_page("https://github.com/chloekhc/cabat/blob/master/fig/13.jpg?raw=true"),
      psychTestR::while_loop(
        test = function(state, ...) psychTestR::get_local("do_intro", state),
        logic = c(

          practice(practice_items),
          ask_repeat()
        )),
      info_image_page("https://github.com/chloekhc/cabat/blob/master/fig/21.jpg?raw=true")
    ), dict = dict)
}

ask_repeat <-function() {
  psychTestR::NAFC_page(
    label = "ask_repeat",
    prompt = div(p(img(src = "https://github.com/chloekhc/cabat/blob/master/fig/20.jpg?raw=true", width="100%")), p("")),

    choices = c("go_back", "continue"),
    labels = lapply(c("ABAT_0022_I_0001_1", "ABAT_0021_I_0001_1"), psychTestR::i18n),
    save_answer = FALSE,
    arrange_vertically = FALSE,
    on_complete = function(state, answer, ...) {
      psychTestR::set_local("do_intro", identical(answer, "go_back"), state)
    }
  )
}

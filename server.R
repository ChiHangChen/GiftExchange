library(shiny)
library(shinyWidgets)
file.remove("waiting.lck")

vars <- reactiveValues(rest_straws=c())

server <- function(input, output, session) {
  observeEvent(input$check_reset, {
    confirmSweetAlert(
      session = session,
      title = "重設籤筒",
      inputId = "reset",
      text = paste0("確定要重設籤筒為",input$reset_num,"支籤嗎"),
      type = "warning"
    )
  })
  observeEvent(input$reset, {
    if(input$reset){
      all_straws = c(1:input$reset_num)
      saveRDS(all_straws, "current_straws.rds")
      vars$rest_straws <<- all_straws
    }
  })
  observeEvent(input$withdraw, {
    if(file.exists("waiting.lck")){
      sendSweetAlert(
        session = session,
        title = "Busy",
        text = "有人正在抽抽 請稍等一下",
        type = "error"
      )
      return()
    }
    file.create("waiting.lck")
    all_straws = readRDS("current_straws.rds")
    if(length(all_straws)==0){
      sendSweetAlert(
        session = session,
        title = "QQ",
        text = "沒有籤了",
        type = "error"
      )
      file.remove("waiting.lck")
      return()
    }
    straws_id = sample(length(all_straws),1)
    your_straw = all_straws[straws_id]
    rest_straws = all_straws[-straws_id]
    vars$rest_straws <<- rest_straws
    saveRDS(rest_straws, "current_straws.rds")
    file.remove("waiting.lck")
    sendSweetAlert(
      session = session,
      title = "成功!!",
      text = paste0("恭喜你抽到 ",your_straw," 號！！"),
      type = "success"
    )
  })
  output$n_straws_left = renderUI({
    HTML(
      paste0("籤統還剩下 ",length(vars$rest_straws)," 支籤<br/>剩下的籤號 : ",paste(vars$rest_straws,collapse = " "))
    )
  })
}

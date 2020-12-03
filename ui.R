library(shiny)

ui <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  numericInput("reset_num", "要幾支籤", 5, min = 1, max = 100),
  actionButton("check_reset", "重設籤筒"),
  br(),
  br(),
  htmlOutput("n_straws_left"),
  br(),
  actionButton("withdraw", "抽起來！！"),
)
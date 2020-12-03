library(shiny)

ui <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  column(
    12, align="center",
    br(),
    br(),
    br(),
    br(),
    numericInput(
      "reset_num", "要幾支籤", 5, min = 1, max = 100,
      width = "20%"
    ),
    actionButton(
      "check_reset", "重設籤筒",
      icon("trash-alt"),
      style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
    ),
    br(),
    br(),
    htmlOutput("n_straws_left"),
    br(),
    actionButton(
      "withdraw", "抽起來！！",
      icon("hand-lizard"),
      class = "btn-warning"
    )
  )
)
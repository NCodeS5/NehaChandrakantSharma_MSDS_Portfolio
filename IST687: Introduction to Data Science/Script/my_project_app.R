library(shiny)
library(shinydashboard)
library(RCurl)
library(jsonlite)
library(tidyverse)
library(ggmap)
library(dplyr)
library(DT)

any_data <- read.csv('data2inc.csv')

hour_data<- read.csv('hour_df.csv')
#data<-read.csv('merged_df.csv')

ui = dashboardPage(
  dashboardHeader(title = paste( "SC Energy Analysis")),
  dashboardSidebar(HTML('The primary objective of this App is to address the anticipated increase in electricity demand during the summer months, particularly in July, for an energy company (eSC) operating in South Carolina'),
                   selectInput("cityFilter", "Select a City",
                               choices = c("All Cities", "SC, Hilton Head Island", "SC, Charleston","SC, Summerville","SC, Goose Creek","SC, North Charleston","SC, Mount Pleasant","SC, Florence","SC, Greenville","SC, Myrtle Beach","SC, North Myrtle Beach","SC, Columbia","SC, Spartanburg","SC, Sumter","SC, Rock Hill" ),
                               selected = "All Cities")),
  dashboardBody(
    fluidRow(box(
      title = "Total Energy Consumption",
      status = "primary",
      solidHeader = TRUE,
      textOutput('totalconsumption')
    ),
    box(
      title = "Total Future Energy Consumption",
      status = "primary",
      solidHeader = TRUE,
      textOutput('totalfutureconsumption')
    )),
    fluidRow(
      box(plotOutput('plot2', width = '100%')),
      box(plotOutput('plot3', width = '100%')),
      box(plotOutput('plot4', width = '100%'))
      #box(plotOutput('plot1', width = '100%'))
      )
  ) # end dashboard body
  
) # end dashboard page,

server = function(input, output) {
  
  any_data <- any_data
  
  hour_data<- hour_data
  #data<-data
  
    
    # use station information and station status that were retrieved at start of app
    # to build a data set used for the map and table
    
  
  filtered_city_data <- reactive({
    if (input$cityFilter == "All Cities") {
      any_data
    } else {
      any_data %>% filter(in.city == input$cityFilter)
    }
  })
  
  
  output$totalconsumption <- renderText({
    # Calculate the total consumption for the selected city
    total_consumption <- sum(filtered_city_data()$totalconsumption, na.rm = TRUE)
    return(total_consumption)
  })
  
  output$totalfutureconsumption <- renderText({
    # Calculate the total future consumption for the selected city
    total_future_consumption <- sum(filtered_city_data()$predict, na.rm = TRUE)
    return(total_future_consumption)
  })
  
  #output$plot1 <- renderPlot({
  #  plot_object <- data %>% ggplot(aes(x = in.city, fill = in.usage_level)) +
   #   geom_bar(position = "fill") +
   #   facet_wrap(~in.building_america_climate_zone) +
   #   labs(title = "Percentage Distribution of Usage Levels by Climate Zone and City",
    #       x = "City",
     #      y = "Percentage",
    #       fill = "Usage Level") +
     # scale_y_continuous(labels = scales::percent_format()) +
     #$ theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    # Return the ggplot object to be rendered
   # print(plot_object)
  #})
  
  output$plot2 <- renderPlot({
    plot_object <- filtered_city_data() %>% filter(in.state %in% c("SC", "NC")) %>% ggplot(aes(x = norm_temp, y = totalconsumption)) +
      geom_point(size = 3, aes(color = filtered_city_data()$in.city)) +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      labs(title = "Temperature vs. Energy Consumption",
           x = "Temperature (Celsius)",
           y = "Energy Consumption") + theme_minimal()
    print(plot_object)
  })
  
  output$plot3 <- renderPlot({
    plot_object <- filtered_city_data() %>% filter(in.state %in% c("SC", "NC")) %>% ggplot(aes(x = avg_temp, y = predict)) +
      geom_point(size = 3, aes(color = filtered_city_data()$in.city)) +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      labs(title = "Temperature vs. Energy Consumption",
           x = "Temperature (Celsius)",
           y = "Energy Consumption") + theme_minimal()
    print(plot_object)
  })
  
  output$plot4 <- renderPlot({
    plot_object <-   ggplot() +
      geom_col(data = hour_df, aes(x = hour, y = totalconsumption_per_hour, fill = " total consumption per hour"), position = "identity", alpha = 0.7) +
      geom_col(data = hour_df, aes(x = hour, y = totalconsumption_prediction_per_hour, fill = "total prediction per hour"), position = "identity", alpha = 0.7)+ theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
      labs(title = "Energy Consumption vs Predictive Consumption per Hour",
           x= "Hour",
           y = "Energy Consumed (kWh)")
    print(plot_object)
  })

}
shinyApp(ui = ui, server = server)

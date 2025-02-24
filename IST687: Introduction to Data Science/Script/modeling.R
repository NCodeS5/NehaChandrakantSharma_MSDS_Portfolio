library(tidyverse)
library(car)
#data <- read.csv("merged_df.csv")
data<-merged_df
str(data)

#### PART C ###################

sqft <- data$in.sqft
bedrooms <- data$in.bedrooms
stories <- data$in.geometry_stories
occupants <- data$in.occupants
ceiling_fan <- data$out.electricity.ceiling_fan.energy_consumption
cooling <- data$out.electricity.cooling.energy_consumption
freezer <- data$out.electricity.freezer.energy_consumption
hot_water <- data$out.electricity.hot_water.energy_consumption
lighting_exterior <- data$out.electricity.lighting_exterior.energy_consumption
lighting_interior <- data$out.electricity.lighting_interior.energy_consumption
plug <- data$out.electricity.plug_loads.energy_consumption
refrigerator <- data$out.electricity.refrigerator.energy_consumption

model <- lm(totalconsumption ~ in.sqft + in.bedrooms + in.geometry_stories + 
              in.occupants + out.electricity.ceiling_fan.energy_consumption + 
              out.electricity.clothes_dryer.energy_consumption + 
              out.electricity.clothes_washer.energy_consumption + 
              out.electricity.cooling_fans_pumps.energy_consumption + 
              out.electricity.cooling.energy_consumption + 
              out.electricity.dishwasher.energy_consumption +
              out.electricity.freezer.energy_consumption + 
              out.electricity.heating_fans_pumps.energy_consumption +
              out.electricity.heating.energy_consumption +
              out.electricity.hot_tub_heater.energy_consumption + 
              out.electricity.hot_tub_pump.energy_consumption +
              out.electricity.hot_water.energy_consumption +
              out.electricity.lighting_exterior.energy_consumption +
              out.electricity.lighting_garage.energy_consumption +
              out.electricity.lighting_interior.energy_consumption +
              out.electricity.mech_vent.energy_consumption +
              out.electricity.plug_loads.energy_consumption +
              out.electricity.pool_heater.energy_consumption +
              out.electricity.pool_pump.energy_consumption +
              out.electricity.pv.energy_consumption +
              out.electricity.range_oven.energy_consumption +
              out.electricity.refrigerator.energy_consumption +
              out.electricity.well_pump.energy_consumption +
              out.natural_gas.fireplace.energy_consumption +
              out.natural_gas.grill.energy_consumption +
              out.natural_gas.hot_tub_heater.energy_consumption + 
              out.natural_gas.lighting.energy_consumption +
              out.natural_gas.pool_heater.energy_consumption,
            data=data)
summary(model)
#this model includes all variables


summary(data)
#use summary data to find which variables have 0 energy consumption in 1st to 3rd Quartile
model3 <- lm(totalconsumption ~ in.sqft + in.bedrooms + in.geometry_stories + 
              in.occupants + out.electricity.ceiling_fan.energy_consumption + 
              out.electricity.cooling_fans_pumps.energy_consumption + 
              out.electricity.cooling.energy_consumption +
              out.electricity.freezer.energy_consumption +
              out.electricity.hot_water.energy_consumption +
              out.electricity.lighting_exterior.energy_consumption +
              out.electricity.lighting_interior.energy_consumption +
              out.electricity.plug_loads.energy_consumption +
              out.electricity.refrigerator.energy_consumption,
            data=data)
summary(model3)
#took out insignificant variable
model4 <- lm(totalconsumption ~ sqft + bedrooms + stories + occupants + 
               ceiling_fan + cooling + freezer + hot_water + lighting_exterior +
               lighting_interior + plug + refrigerator,
             data=data)

data$predict<-predict(model4, data)

data$predict
summary(model4)
#use these variables in new model in dataframe including temperature data below
#data2inc <- read.csv("merged_geo_avgwd_inc_df.csv")
#data2 <- read.csv("merged_geo_avgwd_df.csv")
data2inc<-merged_geo_avgwd_inc_df
data2<-merged_geo_avgwd_df
summary(data2)
hour_df<-data%>%group_by(in.city,hour)%>%summarise(totalconsumption_per_hour = sum(totalconsumption), totalconsumption_prediction_per_hour = sum(predict))

model5 <- lm(totalconsumption ~ avg_temp + sum_ceiling_fan + 
               sum_cooling + sum_freezer + sum_hot_water + sum_lighting_exterior +
               sum_lighting_interior + sum_plug_loads + sum_refrigerator, data=data2)
summary(model5)
#final model

##### PART F ##############
library(ggplot2)
data2inc$predict <- predict(model5, newdata = data2inc)
ggplot(data2inc, aes(x = date, y = predict)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(title = "Predicted Daily Energy Consumption", x = "Date", y = "Energy Consumption")

##### PART G ########
### A ######
ggplot(data2inc, aes(x = in.city, y = predict)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
  labs(title = "Predicted Energy Consumption by City", x = "City", y = "Energy Consumption")

#### B ######
ggplot(data2inc, aes(x = avg_temp, y = totalconsumption)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Temperature vs Energy Consumption", x = "Temperature", y = "Energy Consumption")

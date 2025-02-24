#Data Cleaning and Merging
#-Sai Subrahmanya Akhil Badampudi 

library(arrow)
library(tidyverse)

#Loading the data into the data frame

#Static Housing data
shd<- arrow::read_parquet("https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/static_house_info.parquet")

#Building electricity data
#ed <- arrow::read_parquet("energyData.parquet") 

#Weater data per county
#wd <- read_csv("https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/G4500010.csv")

#Understanding the data
summary(shd)
summary(ed)
summary(wd)
sum(is.na(shd))
sum(is.na(wd))
sum(is.na(ed))
unique(shd$in.state)
unique(shd$in.city)

#Removing the columns which has the same values and which we feel don't required for the modeling

shd<-select(shd,-'in.ahs_region',
            -'in.ashrae_iecc_climate_zone_2004',
            -'in.ashrae_iecc_climate_zone_2004_2_a_split',
            -'in.bathroom_spot_vent_hour',
            -'in.cec_climate_zone',
            -'in.census_division',
            -'in.census_division_recs',
            -'in.census_region',
            -'in.cooling_setpoint_has_offset',
            -'in.cooling_setpoint_offset_magnitude',
            -'in.cooling_setpoint_offset_period',
            -'in.county_and_puma',
            -'in.dehumidifier',
            -'in.door_area',
            -'in.doors',
            -'in.ducts',
            -'in.eaves',
            -'in.electric_vehicle',
            -'in.emissions_electricity_folders',
            -'in.emissions_electricity_units',
            -'in.emissions_electricity_values_or_filepaths',
            -'in.emissions_fossil_fuel_units',
            -'in.emissions_fuel_oil_values',
            -'in.emissions_natural_gas_values',
            -'in.emissions_propane_values',
            -'in.emissions_scenario_names',
            -'in.emissions_types',
            -'in.emissions_wood_values',
            -'in.generation_and_emissions_assessment_region',
            -'in.geometry_attic_type',
            -'in.geometry_building_horizontal_location_mf',
            -'in.geometry_building_horizontal_location_sfa',
            -'in.geometry_building_level_mf',
            -'in.geometry_building_number_units_mf',
            -'in.geometry_building_number_units_sfa',
            -'in.geometry_building_type_acs',
            -'in.geometry_building_type_height',
            -'in.geometry_building_type_recs',
            -'in.geometry_floor_area',
            -'in.geometry_story_bin',
            -'in.geometry_wall_exterior_finish',
            -'in.geometry_wall_type',
            -'in.has_pv',
            -'in.heating_setpoint_offset_period',
            -'in.holiday_lighting',
            -'in.hot_water_distribution',
            -'in.hvac_has_shared_system',
            -'in.hvac_secondary_heating_efficiency',
            -'in.hvac_secondary_heating_type_and_fuel',
            -'in.hvac_shared_efficiencies',
            -'in.hvac_system_is_faulted',
            -'in.hvac_system_single_speed_ac_airflow',
            -'in.hvac_system_single_speed_ac_charge',
            -'in.hvac_system_single_speed_ashp_airflow',
            -'in.hvac_system_single_speed_ashp_charge',
            -'in.interior_shading',
            -'in.iso_rto_region',
            -'in.lighting_interior_use',
            -'in.lighting_other_use',
            -'in.location_region',
            -'in.mechanical_ventilation',
            -'in.natural_ventilation',
            -'in.neighbors',
            -'in.overhangs',
            -'in.plug_loads',
            -'in.radiant_barrier',
            -'in.schedules',
            -'in.simulation_control_run_period_begin_day_of_month',
            -'in.simulation_control_run_period_begin_month',
            -'in.simulation_control_run_period_calendar_year',
            -'in.simulation_control_run_period_end_day_of_month',
            -'in.simulation_control_run_period_end_month',
            -'in.simulation_control_timestep',
            -'in.solar_hot_water',
            -'in.units_represented',
            -'in.water_heater_in_unit',
            -'in.window_areas')

#After looking at the in.city unique values we found 2 names to be different than normal, 
#like, 'Not in a census Place' and 'In another census Place'. Here we are taking cities of South Carolina which data consists of.

shd<-shd%>%filter(in.city != "Not in a census Place")%>%filter(in.city!= "In another census Place")

#Create datasets with all unique building ids and unique counties into 2 different variables.

build100<-shd$bldg_id
#build100
county<-unique(shd$in.county)

##Creating Functions

#Function for Filtering July dates from the energy dataset
library(tidyverse)
julyfilter<-function(data){
  filter<- data%>%filter(substr(as_datetime(time),6,7)=="07")
  return(filter)
}

#Function for Filtering July dates from the weather dataset
library(tidyverse)
julyfilter_wd<-function(data){
  filter<- data%>%filter(substr(as_datetime(date_time),6,7)=="07")
  return(filter)
}


# Loop through each building ID and load the files into the data frames ed_'buildingID' 
#and add new column to each datafarme with building ID
library(tidyverse)
mylist<- list()
for (i in build100) {
  url <- paste0("https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/2023-houseData/", i, ".parquet")
  
  # Read the Parquet file into a data frame
  df_name <- paste0("ed_", i)  # Create a dynamic variable name
  mylist<- append(mylist,df_name)
  assign(df_name, arrow::read_parquet(url))  # Assign the data frame to the dynamic variable
  df<-get(df_name)
  df$bldg_id<- i
  assign(df_name,df)
}

# Loop through each county and load the files into the data frames wd_'county' 
#and add new column to each datafarme with county
library(tidyverse)
mycountylist<-list()
for(i in county){
  wdurl<- paste0("https://intro-datascience.s3.us-east-2.amazonaws.com/SC-data/weather/2023-weather-data/",i,".csv")
  wd_name<-paste0("wd_",i)
  mycountylist<-append(mycountylist,wd_name)
  assign(wd_name,read_csv(wdurl))
  wd<-get(wd_name)
  wd$county<-i
  assign(wd_name,wd)
}

df<-data.frame(as.character(mylist))
wd_df<-data.frame(as.character(mycountylist))

##Filtering the july data by send the ed dataframes into the filter function
for (i in df$as.character.mylist.) {
  filtered_name <- i
  assign(filtered_name, julyfilter(get(i)))
}

##Filtering the july data by send the wd dataframes into the filter function
for (i in wd_df$as.character.mycountylist.) {
  wd_filtered_name <- i
  assign(wd_filtered_name, julyfilter_wd(get(i)))
}

#Creating a dataframe to put together all the building's energy data
fullEDf<- data.frame()

for (i in df$as.character.mylist.){
  fullEDf <- rbind.data.frame(fullEDf,get(i)) 
}

#Creating a data frame to put together all the counties' weather data by rbind(union)
fullwd_df<-data.frame()
for(i in wd_df$as.character.mycountylist.){
  fullwd_df <- rbind.data.frame(fullwd_df,get(i))  
}

#created a new dataset and added 5 degress to the weather data by rbind(union)
fullwd_inc_df<-fullwd_df
fullwd_inc_df$`Dry Bulb Temperature [°C]`<-fullwd_inc_df$`Dry Bulb Temperature [°C]`+5.0

#All the following columns are having total sum as zero, so removing these columns from the union dataset
fullEDf<-select(fullEDf,-'out.electricity.heating_hp_bkup.energy_consumption',
                -'out.fuel_oil.heating_hp_bkup.energy_consumption',
                -'out.fuel_oil.heating.energy_consumption',
                -'out.fuel_oil.hot_water.energy_consumption',
                -'out.natural_gas.clothes_dryer.energy_consumption',
                -'out.natural_gas.heating_hp_bkup.energy_consumption',
                -'out.natural_gas.heating.energy_consumption',
                -'out.natural_gas.hot_water.energy_consumption',
                -'out.natural_gas.range_oven.energy_consumption',
                -'out.propane.clothes_dryer.energy_consumption',
                -'out.propane.heating_hp_bkup.energy_consumption',
                -'out.propane.heating.energy_consumption',
                -'out.propane.hot_water.energy_consumption',
                -'out.propane.range_oven.energy_consumption')

#merged the static house data and energy data with the help of building id from the two datasets.
merged_df<-merge.data.frame(shd,fullEDf,by = 'bldg_id', sort = TRUE, all = FALSE)

#getting the names of all the columns that is starting with out, as these columns contains consumptions into a dataset.
out_column_names<-colnames(merged_df[grep("^out",colnames(merged_df))])

#Creating a new column date in merged_df,fullwd_df,fullwd_inc_df data frames with existind datatime column.
merged_df$date<- as_date(merged_df$time)
fullwd_df$date<-as_date(fullwd_df$date_time)
fullwd_inc_df$date<-as_date(fullwd_inc_df$date_time)


#Getting the total consumption for each row, which represensts total consumption per building and per hour
merged_df$totalconsumption<-rowSums(merged_df[,c(colnames(merged_df[grep("^out",colnames(merged_df))]))])

#Creating a separate dataframe geo_merged_df for columns like state, city, county,latitude, logintude, date and 
#calculating sum of different consumptions by grouping with above columns. 
geo_merged_df<-merged_df%>%group_by(in.state,in.city,in.county,in.weather_file_latitude,in.weather_file_longitude,date)%>%summarise(
  sum_ceiling_fan = sum(out.electricity.ceiling_fan.energy_consumption, na.rm = TRUE),
  sum_clothes_dryer = sum(out.electricity.clothes_dryer.energy_consumption, na.rm = TRUE),
  sum_clothes_washer = sum(out.electricity.clothes_washer.energy_consumption, na.rm = TRUE),
  sum_cooling_fans_pumps = sum(out.electricity.cooling_fans_pumps.energy_consumption, na.rm = TRUE),
  sum_cooling = sum(out.electricity.cooling.energy_consumption, na.rm = TRUE),
  sum_dishwasher = sum(out.electricity.dishwasher.energy_consumption, na.rm = TRUE),
  sum_freezer = sum(out.electricity.freezer.energy_consumption, na.rm = TRUE),
  sum_heating_fans_pumps = sum(out.electricity.heating_fans_pumps.energy_consumption, na.rm = TRUE),
  sum_heating = sum(out.electricity.heating.energy_consumption, na.rm = TRUE),
  sum_hot_tub_heater = sum(out.electricity.hot_tub_heater.energy_consumption, na.rm = TRUE),
  sum_hot_tub_pump = sum(out.electricity.hot_tub_pump.energy_consumption, na.rm = TRUE),
  sum_hot_water = sum(out.electricity.hot_water.energy_consumption, na.rm = TRUE),
  sum_lighting_exterior = sum(out.electricity.lighting_exterior.energy_consumption, na.rm = TRUE),
  sum_lighting_garage = sum(out.electricity.lighting_garage.energy_consumption, na.rm = TRUE),
  sum_lighting_interior = sum(out.electricity.lighting_interior.energy_consumption, na.rm = TRUE),
  sum_mech_vent = sum(out.electricity.mech_vent.energy_consumption, na.rm = TRUE),
  sum_plug_loads = sum(out.electricity.plug_loads.energy_consumption, na.rm = TRUE),
  sum_pool_heater = sum(out.electricity.pool_heater.energy_consumption, na.rm = TRUE),
  sum_pool_pump = sum(out.electricity.pool_pump.energy_consumption, na.rm = TRUE),
  sum_pv = sum(out.electricity.pv.energy_consumption, na.rm = TRUE),
  sum_range_oven = sum(out.electricity.range_oven.energy_consumption, na.rm = TRUE),
  sum_refrigerator = sum(out.electricity.refrigerator.energy_consumption, na.rm = TRUE),
  sum_well_pump = sum(out.electricity.well_pump.energy_consumption, na.rm = TRUE),
  sum_fireplace = sum(out.natural_gas.fireplace.energy_consumption, na.rm = TRUE),
  sum_grill = sum(out.natural_gas.grill.energy_consumption, na.rm = TRUE),
  sum_hot_tub_heater_gas = sum(out.natural_gas.hot_tub_heater.energy_consumption, na.rm = TRUE),
  sum_lighting_gas = sum(out.natural_gas.lighting.energy_consumption, na.rm = TRUE),
  sum_pool_heater_gas = sum(out.natural_gas.pool_heater.energy_consumption, na.rm = TRUE),
  .groups = "keep"
)

#Getting the total consumption of electricity per city, per county, per day by the summation of all the consumptions
geo_merged_df$totalconsumption<-rowSums(geo_merged_df[,c(colnames(geo_merged_df[grep("^sum",colnames(geo_merged_df))]))])


#Creating two different dataframes of normal weather data and increased weather data from unioned weather data,
#getting the average weather and humidity per date in a county 
avg_wd_df<-fullwd_df%>%group_by(county,date)%>%summarise(avg_temp = mean(`Dry Bulb Temperature [°C]`), avgHumidity = mean(`Relative Humidity [%]`), .groups = "keep")
avg_wd_inc_df<-fullwd_inc_df%>%group_by(county,date)%>%summarise(avg_temp = mean(`Dry Bulb Temperature [°C]`), avgHumidity = mean(`Relative Humidity [%]`),.groups = "keep")


# Merging the above two data frames with the geo_merged_df dataframe, which shows the city, county, date 
#and consumption along with weather and humidity of that county on that date 
merged_geo_avgwd_df<-merge(geo_merged_df, avg_wd_df, by.x = c("in.county", "date"), by.y = c("county", "date"))
merged_geo_avgwd_inc_df<-merge(geo_merged_df, avg_wd_inc_df, by.x = c("in.county", "date"), by.y = c("county", "date"))

#Downloading the files using write.csv
write.csv(merged_df,'merged_df.csv')
write.csv(merged_geo_avgwd_df,'merged_geo_avgwd_df.csv')
write.csv(merged_geo_avgwd_inc_df,'merged_geo_avgwd_inc_df.csv')


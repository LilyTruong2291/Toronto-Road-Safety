# EDA Toronto Safety Road: Project Overview

*This project aims to explore which age-group is more likely to be involved in traffic accidents in Toronto.*

The City of Toronto is Canada’s most populous city and a focal point of development and growth. As one of the most populous municipalities in North America, significant efforts are being made across all levels of government to manage the challenges posed by Toronto’s increased urbanization. The 2020 Safety Roads competition organzied by SAS Institute along with Geotab and Toronto Police Service aims to provide insights and recommendations to address some of the challenges posed to the City of Toronto.
Utimately, this analysis won 3rd place out of 20 participating teams coming from all colleges in GTA.

## Code and Resources Used

**Server:** SAS Studio

**Code for Analysis:** proc freq, proc sort, proc contents, proc sql, proc means, proc univariate, proc hpbin

**Code for Visualization:** proc sglot, proc sgmap, proc gmap 

**Datasets:**

* Killed or Seriously Injured (KSI).http://data.torontopolice.on.ca/.

* Hazardous Driving Areas. Geotab. https://data.geotab.com/urban-infrastructure/hazardous-driving.

* Road Impediments. Geotab. https://data.geotab.com/urban-infrastructure/road-impediments.

## Data Cleaning

Data cleaning is done using Excel.

## EDA
The map below indicates the **top 10% hazardous areas** for driving according to harsh braking and accident level events.
![Hazard Driving Hotspot in Toronto](https://github.com/LilyTruong2291/Toronto-Road-Safety/blob/master/hazard_driving_hotspot.PNG)

Impediment map in Toronto shows the top 1% locations that have severe impediments.
![Impediment in Toronto](https://github.com/LilyTruong2291/Toronto-Road-Safety/blob/master/impediments.PNG)

The choropleth map illustrates number of fatality from 2008 to 2018 across Toronto's wards. 
![Map of Fatalities by Ward](https://github.com/LilyTruong2291/Toronto-Road-Safety/blob/master/Map.png)

![Pedestrian Related Accidents by Age](https://github.com/LilyTruong2291/Toronto-Road-Safety/blob/master/pedestrian_by_age.PNG)

![Fatal Pedestrian by Age](https://github.com/LilyTruong2291/Toronto-Road-Safety/blob/master/fatal_pedestrian_by_age.PNG)

![Fatal Seniors by Ward](https://github.com/LilyTruong2291/Toronto-Road-Safety/blob/master/fatal_seniors_by_ward.PNG)

## Findings

It turns out that pedestrians who are over 55+ are more likely to be involved in accidents compared to other age groups. This is a particularly pernicious finding since members of this age group are also less likely to fully recover from physical trauma. The wards that had the highest number of fatalites are Scarborogh Centre, Etobicoke North and Scarborough-Agincourt.  The wards that had the most senior fatalities are 22 (Scarborough-Agincourt), 18 (Willowdale), 21 (Scarborough Centre). Scarborough Centre is chosen to be our focus due to its high number of fatalities - 20% of accidents are fatal. Our analysis shows that most of the accident occured at midblock section. Thus, we suggested to expand the speed reduction program into Scarborough Centre especially some notable roads are Eglinton Ave E & Midland Ave, Eglinton Ave E & Brimley Rd, Lawrence Ave E& Brimley Rd. Moreover, warning signs are recommended to put at 8.5 meters before the crossing to alert the upcoming traffic.

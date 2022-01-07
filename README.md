

## Introduction

This project was to create a dashboard using R-Shiny to consider the impact that winter may have on the health care in Scotland using Public Health Scotland data.

The team created a R-Shiny app which allows the user to explore the data we have gathered.

The main points the team were exploring:
* To what extent is the ‘winter crisis’ the media predicts real?
* How has winter impacted NHS Scotland’s hospital system in the past?

Data was sourced from Public Health Scotland.

## Team Members

Malcom Cheyne, Pui Siu, Jonny Nelson, Ricardo Pulido, Louise Shambrook, all from CodeClan DE11 Data Analysis cohort.

## Roles & responsibilities of each member

* Main areas of work

Malcolm worked on:
Cleaning, wrangling, and preparing data for the bed occupancy tab
Implementing plot from DATA to dashboard
Adding region and specialty drop down to hospital admissions tab
Linking the date, region, specialty and action buttons with server

Pui worked on:
Cleaning, wrangling, and preparing data for ICU beds
Developing the leaflet plots
Exploring demographics data (cleaning, wrangling and preparing this data)
Implementing this plot in the demographics tab
Linking the date, region, age group and action buttons with server

Jonny worked on:
Cleaning, wrangling, and preparing data for the A&E attendance
Implementing plot A and plot B from data to dashboard
Linking the date, radio buttons and action buttons with server

Ricardo worked on:
Developing and maintaining the file and folder structure
Exploring and developing the statistics
Developing and implementing the leaflet plots
Developing the UI and server for the bed occupancy tab
Managing implementation of functionalities and merge conflicts

Louise worked on:
Developing the UI for bed occupancy tab, hospital admissions tab, A&E attendance tab
Developing the initial server side for bed occupancy tab, hospital admissions tab, A&E attendance tab
Managing oversight of UI, implementation of functionalities and merge conflicts
Overall project management

The team worked on the:
Planning
Bug fixing
Presentation
Understanding KPI and finding insights in the datasets
Developing the style and theme

## Stages of the project

* Looking and choosing the datasets
* Picking areas to focus on and brainstorming ideas
* Trello planning layout
* Cleaning and wrangling the datasets  
* Set-up of dashboard
* Git branching & version control
* Adding plots and functionality to the dashboard

## Trello board
![Trello] (images/trello.png)

## Which tools and packages were used in the project

The team had daily stand-ups and meetings using Zoom, collaborating together using Git/GitHub for version control. The team planned and set tasks using Trello.

Slack - used for communication outside Zoom meetings

The packages used in this project are:

shiny
shinyWidgets
janitor
tidyverse
leaflet
infer
shinydashboard
sf
rgdal
lubridate
rmapshaper

## Screenshots
### Bed Occupancy
![Bed Occupancy Tab] (images/bed_occupancy.png)

### Hospital Admissions
![Hospital Admissions Tab] (images/hospital_admissions.png)

### A & E Admissions
![A & E Admissions Tab] (images/ae_admissions.png)

### Demographics
![Demographics] (images/demograhics.png)

## References

The data used were all sourced from https://www.opendata.nhs.scot/. The links below are all the specific links to each dataset used:

https://www.opendata.nhs.scot/dataset/hospital-beds-information - Beds by Specialty
https://www.opendata.nhs.scot/dataset/inpatient-and-daycase-activity/resource/00c00ecc-b533-426e-a433-42d79bdea5d4 - Length of stays
https://www.opendata.nhs.scot/dataset/inpatient-and-daycase-activity/resource/c3b4be64-5fb4-4a2f-af41-b0012f0a276a - Hospital admissions by Specialty
https://www.spatialdata.gov.scot/geonetwork/srv/api/records/f12c3826-4b4b-40e6-bf4f-77b9ed01dc14 - Shape file used to plot health board regions

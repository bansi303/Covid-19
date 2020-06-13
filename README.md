![](/Covid-19/Covid-19/Resource/Animation/logo.gif)

#  Covid-19
An application that simplifies accessing and show some of Covid-19 information

## Overview
This application fetch and shows the current information such as  total case, death rate, recover rate about the Covid-19 for the whole world and the nearest country of the user. It also include self assesment test and how to avoid infection of Covid-19. 

## Archietecture
MVVM ( Model View Viewmodel) for easily testing and debugging 

## Features
- Comptible with any iOS device in portrait mode
- Read data from json file if there will be any issue of data fetching.
- Implemeted horizontal bar chart depicts information about total case, death rate and recover rate.

## Frameworks Used
* CoreLocation - To fetch user location and find nearest coutry from the user location.
* Mapkit - To show country wise data
* Charts - To show data on horizontal bar chart
* Alamofire - To fetch current data of Covid-19
* SVProgressHUD - To show progress bar and preloader
* SwiftGifOrigin - To load and render gif file.

//
//  DataHandler.swift
//  SwiftUI-Weather
//
//  Created by Lee on 2/1/21.
//

import Foundation

struct DataHandler { 
    
    func makeSenseOfData(from data: WeatherObject) -> [FormedWeatherObjectForDisplay]{
        
        var itemsToBeDisplayed: [FormedWeatherObjectForDisplay] = []
        
        for entry in data.list {
            var dateString = entry.dt_txt
            
            // remove the timestamp from the entry
            dateString.removeLast(9)
            
            //print(entry)
            
            if let index = itemsToBeDisplayed.firstIndex(where: { ($0.dayString == dateString) }) {
                itemsToBeDisplayed[index].arrayOfTemps.append(entry.main.temp)
                itemsToBeDisplayed[index].arrayOfWeatherDescriptors.append(entry.weather[0].main)
            } else {
                var newDayObject = FormedWeatherObjectForDisplay(dayString: dateString)
                newDayObject.arrayOfTemps.append(entry.main.temp)
                newDayObject.arrayOfWeatherDescriptors.append(entry.weather[0].main)
                itemsToBeDisplayed.append(newDayObject)
            }
        }
        
        
        // rounds the double temp to the nearest integer
        for i in 0..<itemsToBeDisplayed.count {
            itemsToBeDisplayed[i].roundTempValue()
            itemsToBeDisplayed[i].allocateWeatherDescriptor()
        }
        
//        for object in itemsToBeDisplayed {
//            print(object.dayString)
//        }
        
        return itemsToBeDisplayed
    }
}

//
//  WeatherDayView.swift
//  SwiftUI-Weather
//
//  Created by Lee on 15/12/20.
//

import SwiftUI

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium, design: .default))
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

/// Gets current day, returns an array of short strings for the day of the week.

func getArrayOfDays() -> [String] {
    /// day is an integer based on the day of week it is, starting from sunday. Sunday = 1, monday = 2, ..., saturday = 7
    let day = Calendar.current.component(.weekday, from: Date())

    var daysOfWeek = ["SUN","MON","TUE","WED","THU","FRI","SAT"]

    /// Moves the first element to the back. If it's sunday, SUN goes to the end, and MON is the first
    for _ in 1..<day {
        daysOfWeek.append(daysOfWeek.remove(at: 0))
    }
    
    return daysOfWeek
}

func getWeatherData() -> [FormedWeatherObjectForDisplay] {
    let jsonData = DataManager().getOtherStuff()
    return DataHandler().makeSenseOfData(from: jsonData!)
    
}


struct WeatherWeekView: View {
    
    let daysOfWeek = getArrayOfDays()
    var weatherData = getWeatherData()
    
    var body: some View {
        HStack(spacing: 20) {
            
            /// pulls the second to the last elements out of the array to put in the week view
            ForEach((1..<6), id: \.self) {
                WeatherDayView(dayOfWeek: daysOfWeek[$0],
                               imageName: weatherData[$0].weatherIconName,
                               temperature: Int(weatherData[$0].temp))
            }
        }
    }
}

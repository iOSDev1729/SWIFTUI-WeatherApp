//
//  FormedWeatherObjectForDisplay.swift
//  SwiftUI-Weather
//
//  Created by Lee on 2/1/21.
//

import Foundation

struct FormedWeatherObjectForDisplay {
    var temp: Double = 0.0
    var dayString: String
    
    var weatherDescriptor: String?  {
        didSet {
            weatherIconName = selectWeatherIcon(from: weatherDescriptor ?? "unknown")
        }
    }
    var weatherIconName: String = weatherIcons.unknown
    var arrayOfWeatherDescriptors: [String] = []
    
    var arrayOfTemps: [Double] = [] {
        didSet {
            /// sets the temp to be the average of the array of temperatures
            self.temp = arrayOfTemps.max()!
            //self.temp = arrayOfTemps.reduce(0, +)/Double(arrayOfTemps.count)
        }
    }
    
    /// set the temp value to 1 dec place
    mutating func roundTempValue() {
        temp = temp.rounded(toPlaces: 0)
    }
    
    /// goes through the list of weather descriptors, creates a dictionary of the items and their frequencies, finds the pair with the highest frequency, then returns the key from that pair
    mutating func allocateWeatherDescriptor() {
        let mappedWeatherDescriptors = arrayOfWeatherDescriptors.map{($0, 1)}
        let counts = Dictionary(mappedWeatherDescriptors, uniquingKeysWith: +)
        let foundWeatherDescriptor = counts.max{a,b in a.value < b.value}
        weatherDescriptor = foundWeatherDescriptor?.key
    }
    
    func selectWeatherIcon(from descriptor: String) -> String {
        switch descriptor.lowercased() {
        case "clouds":
            return weatherIcons.clouds
        case "rain":
            return weatherIcons.rain
        case "clear":
            return weatherIcons.clear

        default:
            print("weather descriptor unknown: \(descriptor)")
            return weatherIcons.unknown
        }
    }
    
    
    init(dayString: String) {
        self.dayString = dayString
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

//
//  WeatherResponseObjects.swift
//  SwiftUI-Weather
//
//  Created by Lee on 1/1/21.
//

import Foundation

/// description of clouds
struct WeatherListWeather: Decodable {
    var main: String
}

struct WeatherListMain: Decodable {
    var temp: Double
}

/// item in the list
struct WeatherList: Decodable {
    
    var dt: Int         /// epoch time
    var main: WeatherListMain
    var weather: [WeatherListWeather]
    var dt_txt: String  /// YYYY-MM-DD format
}


/// overall object, top level
struct WeatherObject: Decodable {
    var list: [WeatherList]
    var cod: String
    var message: Int
    var cnt: Int
}

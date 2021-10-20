//
//  DataManager.swift
//  SwiftUI-Weather
//
//  Created by Lee on 15/12/20.
//

import Foundation

enum WPError: String, Error {
    
    case invalidUsername        = "This username created an invalid request. Please try again"
    case unableToComplete       = "Unable to complete your request. Please check your internet connection"
    case invalidResponse        = "Invalid response from the server. Please try again"
    case invalidData            = "The data received from the server was invalid. Please try again"
    case unableToFavourite      = "There was an error favouriting this user. Please try again"
    case alreadyInFavourites    = "User already in favourites"
}

class DataManager {
    
    //static let shared = DataManager()
    
    init() {}
    
    func getOtherStuff() -> WeatherObject? {
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                do {
                    return try JSONDecoder().decode(WeatherObject.self, from: data)
                } catch let jsonErr {
                    print("something went wrong", jsonErr)
                    return nil
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                return nil
            }
        } else {
            print("Invalid filename/path.")
            return nil
        }
    }
}

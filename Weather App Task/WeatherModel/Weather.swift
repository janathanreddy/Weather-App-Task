//
//  ViewController.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation

struct Weathermodel: Codable {

  var location : Location? = Location()
  var current  : Current?  = Current()
  var forecast : Forecast? = Forecast()

  enum CodingKeys: String, CodingKey {

    case location = "location"
    case current  = "current"
    case forecast = "forecast"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    location = try values.decodeIfPresent(Location.self , forKey: .location )
    current  = try values.decodeIfPresent(Current.self  , forKey: .current  )
    forecast = try values.decodeIfPresent(Forecast.self , forKey: .forecast )
 
  }

  init() {

  }

}

//
//  ViewController.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation

struct Forecast: Codable {

  var forecastday : [Forecastday]? = []

  enum CodingKeys: String, CodingKey {

    case forecastday = "forecastday"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    forecastday = try values.decodeIfPresent([Forecastday].self , forKey: .forecastday )
 
  }

  init() {

  }

}

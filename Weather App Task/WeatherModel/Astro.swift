//
//  ViewController.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation

struct Astro: Codable {

  var sunrise          : String? = nil
  var sunset           : String? = nil
  var moonrise         : String? = nil
  var moonset          : String? = nil
  var moonPhase        : String? = nil
  var moonIllumination : String? = nil

  enum CodingKeys: String, CodingKey {

    case sunrise          = "sunrise"
    case sunset           = "sunset"
    case moonrise         = "moonrise"
    case moonset          = "moonset"
    case moonPhase        = "moon_phase"
    case moonIllumination = "moon_illumination"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    sunrise          = try values.decodeIfPresent(String.self , forKey: .sunrise          )
    sunset           = try values.decodeIfPresent(String.self , forKey: .sunset           )
    moonrise         = try values.decodeIfPresent(String.self , forKey: .moonrise         )
    moonset          = try values.decodeIfPresent(String.self , forKey: .moonset          )
    moonPhase        = try values.decodeIfPresent(String.self , forKey: .moonPhase        )
    moonIllumination = try values.decodeIfPresent(String.self , forKey: .moonIllumination )
 
  }

  init() {

  }

}

//
//  ViewController.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation

struct Forecastday: Codable {

  var date      : String? = nil
  var dateEpoch : Int?    = nil
  var day       : Day?    = Day()
  var astro     : Astro?  = Astro()
  var hour      : [Hour]? = []

  enum CodingKeys: String, CodingKey {

    case date      = "date"
    case dateEpoch = "date_epoch"
    case day       = "day"
    case astro     = "astro"
    case hour      = "hour"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    date      = try values.decodeIfPresent(String.self , forKey: .date      )
    dateEpoch = try values.decodeIfPresent(Int.self    , forKey: .dateEpoch )
    day       = try values.decodeIfPresent(Day.self    , forKey: .day       )
    astro     = try values.decodeIfPresent(Astro.self  , forKey: .astro     )
    hour      = try values.decodeIfPresent([Hour].self , forKey: .hour      )
 
  }

  init() {

  }

}

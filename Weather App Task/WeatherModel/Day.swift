//
//  ViewController.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation

struct Day: Codable {

  var maxtempC          : Double?    = nil
  var maxtempF          : Double?    = nil
  var mintempC          : Double?    = nil
  var mintempF          : Double?    = nil
  var avgtempC          : Double?    = nil
  var avgtempF          : Double?    = nil
  var maxwindMph        : Double?    = nil
  var maxwindKph        : Double?    = nil
  var totalprecipMm     : Double?    = nil
  var totalprecipIn     : Double?    = nil
  var avgvisKm          : Double?    = nil
  var avgvisMiles       : Int?       = nil
  var avghumidity       : Int?       = nil
  var dailyWillItRain   : Int?       = nil
  var dailyChanceOfRain : Int?       = nil
  var dailyWillItSnow   : Int?       = nil
  var dailyChanceOfSnow : Int?       = nil
  var condition         : Condition? = Condition()
  var uv                : Int?       = nil

  enum CodingKeys: String, CodingKey {

    case maxtempC          = "maxtemp_c"
    case maxtempF          = "maxtemp_f"
    case mintempC          = "mintemp_c"
    case mintempF          = "mintemp_f"
    case avgtempC          = "avgtemp_c"
    case avgtempF          = "avgtemp_f"
    case maxwindMph        = "maxwind_mph"
    case maxwindKph        = "maxwind_kph"
    case totalprecipMm     = "totalprecip_mm"
    case totalprecipIn     = "totalprecip_in"
    case avgvisKm          = "avgvis_km"
    case avgvisMiles       = "avgvis_miles"
    case avghumidity       = "avghumidity"
    case dailyWillItRain   = "daily_will_it_rain"
    case dailyChanceOfRain = "daily_chance_of_rain"
    case dailyWillItSnow   = "daily_will_it_snow"
    case dailyChanceOfSnow = "daily_chance_of_snow"
    case condition         = "condition"
    case uv                = "uv"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    maxtempC          = try values.decodeIfPresent(Double.self       , forKey: .maxtempC          )
    maxtempF          = try values.decodeIfPresent(Double.self       , forKey: .maxtempF          )
    mintempC          = try values.decodeIfPresent(Double.self    , forKey: .mintempC          )
    mintempF          = try values.decodeIfPresent(Double.self    , forKey: .mintempF          )
    avgtempC          = try values.decodeIfPresent(Double.self    , forKey: .avgtempC          )
    avgtempF          = try values.decodeIfPresent(Double.self    , forKey: .avgtempF          )
    maxwindMph        = try values.decodeIfPresent(Double.self    , forKey: .maxwindMph        )
    maxwindKph        = try values.decodeIfPresent(Double.self    , forKey: .maxwindKph        )
    totalprecipMm     = try values.decodeIfPresent(Double.self    , forKey: .totalprecipMm     )
    totalprecipIn     = try values.decodeIfPresent(Double.self    , forKey: .totalprecipIn     )
    avgvisKm          = try values.decodeIfPresent(Double.self    , forKey: .avgvisKm          )
    avgvisMiles       = try values.decodeIfPresent(Int.self       , forKey: .avgvisMiles       )
    avghumidity       = try values.decodeIfPresent(Int.self       , forKey: .avghumidity       )
    dailyWillItRain   = try values.decodeIfPresent(Int.self       , forKey: .dailyWillItRain   )
    dailyChanceOfRain = try values.decodeIfPresent(Int.self       , forKey: .dailyChanceOfRain )
    dailyWillItSnow   = try values.decodeIfPresent(Int.self       , forKey: .dailyWillItSnow   )
    dailyChanceOfSnow = try values.decodeIfPresent(Int.self       , forKey: .dailyChanceOfSnow )
    condition         = try values.decodeIfPresent(Condition.self , forKey: .condition         )
    uv                = try values.decodeIfPresent(Int.self       , forKey: .uv                )
 
  }

  init() {

  }

}

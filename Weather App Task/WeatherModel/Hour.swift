//
//  ViewController.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation

struct Hour: Codable {

  var timeEpoch    : Int?       = nil
  var time         : String?    = nil
  var tempC        : Double?    = nil
  var tempF        : Double?    = nil
  var isDay        : Int?       = nil
  var condition    : Condition? = Condition()
  var windMph      : Double?    = nil
  var windKph      : Double?    = nil
  var windDegree   : Int?       = nil
  var windDir      : String?    = nil
  var pressureMb   : Int?       = nil
  var pressureIn   : Double?    = nil
  var precipMm     : Double?    = nil
  var precipIn     : Double?    = nil
  var humidity     : Int?       = nil
  var cloud        : Int?       = nil
  var feelslikeC   : Double?    = nil
  var feelslikeF   : Double?    = nil
  var windchillC   : Double?    = nil
  var windchillF   : Double?    = nil
  var heatindexC   : Double?    = nil
  var heatindexF   : Double?    = nil
  var dewpointC    : Double?    = nil
  var dewpointF    : Double?    = nil
  var willItRain   : Int?       = nil
  var chanceOfRain : Int?       = nil
  var willItSnow   : Int?       = nil
  var chanceOfSnow : Int?       = nil
  var visKm        : Int?       = nil
  var visMiles     : Int?       = nil
  var gustMph      : Double?    = nil
  var gustKph      : Double?    = nil
  var uv           : Int?       = nil

  enum CodingKeys: String, CodingKey {

    case timeEpoch    = "time_epoch"
    case time         = "time"
    case tempC        = "temp_c"
    case tempF        = "temp_f"
    case isDay        = "is_day"
    case condition    = "condition"
    case windMph      = "wind_mph"
    case windKph      = "wind_kph"
    case windDegree   = "wind_degree"
    case windDir      = "wind_dir"
    case pressureMb   = "pressure_mb"
    case pressureIn   = "pressure_in"
    case precipMm     = "precip_mm"
    case precipIn     = "precip_in"
    case humidity     = "humidity"
    case cloud        = "cloud"
    case feelslikeC   = "feelslike_c"
    case feelslikeF   = "feelslike_f"
    case windchillC   = "windchill_c"
    case windchillF   = "windchill_f"
    case heatindexC   = "heatindex_c"
    case heatindexF   = "heatindex_f"
    case dewpointC    = "dewpoint_c"
    case dewpointF    = "dewpoint_f"
    case willItRain   = "will_it_rain"
    case chanceOfRain = "chance_of_rain"
    case willItSnow   = "will_it_snow"
    case chanceOfSnow = "chance_of_snow"
    case visKm        = "vis_km"
    case visMiles     = "vis_miles"
    case gustMph      = "gust_mph"
    case gustKph      = "gust_kph"
    case uv           = "uv"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    timeEpoch    = try values.decodeIfPresent(Int.self       , forKey: .timeEpoch    )
    time         = try values.decodeIfPresent(String.self    , forKey: .time         )
    tempC        = try values.decodeIfPresent(Double.self    , forKey: .tempC        )
    tempF        = try values.decodeIfPresent(Double.self    , forKey: .tempF        )
    isDay        = try values.decodeIfPresent(Int.self       , forKey: .isDay        )
    condition    = try values.decodeIfPresent(Condition.self , forKey: .condition    )
    windMph      = try values.decodeIfPresent(Double.self    , forKey: .windMph      )
    windKph      = try values.decodeIfPresent(Double.self    , forKey: .windKph      )
    windDegree   = try values.decodeIfPresent(Int.self       , forKey: .windDegree   )
    windDir      = try values.decodeIfPresent(String.self    , forKey: .windDir      )
    pressureMb   = try values.decodeIfPresent(Int.self       , forKey: .pressureMb   )
    pressureIn   = try values.decodeIfPresent(Double.self    , forKey: .pressureIn   )
    precipMm     = try values.decodeIfPresent(Double.self       , forKey: .precipMm     )
    precipIn     = try values.decodeIfPresent(Double.self       , forKey: .precipIn     )
    humidity     = try values.decodeIfPresent(Int.self       , forKey: .humidity     )
    cloud        = try values.decodeIfPresent(Int.self       , forKey: .cloud        )
    feelslikeC   = try values.decodeIfPresent(Double.self    , forKey: .feelslikeC   )
    feelslikeF   = try values.decodeIfPresent(Double.self    , forKey: .feelslikeF   )
    windchillC   = try values.decodeIfPresent(Double.self    , forKey: .windchillC   )
    windchillF   = try values.decodeIfPresent(Double.self    , forKey: .windchillF   )
    heatindexC   = try values.decodeIfPresent(Double.self    , forKey: .heatindexC   )
    heatindexF   = try values.decodeIfPresent(Double.self    , forKey: .heatindexF   )
    dewpointC    = try values.decodeIfPresent(Double.self    , forKey: .dewpointC    )
    dewpointF    = try values.decodeIfPresent(Double.self    , forKey: .dewpointF    )
    willItRain   = try values.decodeIfPresent(Int.self       , forKey: .willItRain   )
    chanceOfRain = try values.decodeIfPresent(Int.self       , forKey: .chanceOfRain )
    willItSnow   = try values.decodeIfPresent(Int.self       , forKey: .willItSnow   )
    chanceOfSnow = try values.decodeIfPresent(Int.self       , forKey: .chanceOfSnow )
    visKm        = try values.decodeIfPresent(Int.self       , forKey: .visKm        )
    visMiles     = try values.decodeIfPresent(Int.self       , forKey: .visMiles     )
    gustMph      = try values.decodeIfPresent(Double.self       , forKey: .gustMph      )
    gustKph      = try values.decodeIfPresent(Double.self    , forKey: .gustKph      )
    uv           = try values.decodeIfPresent(Int.self       , forKey: .uv           )
 
  }

  init() {

  }

}

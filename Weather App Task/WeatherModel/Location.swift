//
//  ViewController.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation

struct Location: Codable {

  var name           : String? = nil
  var region         : String? = nil
  var country        : String? = nil
  var lat            : Double? = nil
  var lon            : Double? = nil
  var tzId           : String? = nil
  var localtimeEpoch : Int?    = nil
  var localtime      : String? = nil

  enum CodingKeys: String, CodingKey {

    case name           = "name"
    case region         = "region"
    case country        = "country"
    case lat            = "lat"
    case lon            = "lon"
    case tzId           = "tz_id"
    case localtimeEpoch = "localtime_epoch"
    case localtime      = "localtime"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name           = try values.decodeIfPresent(String.self , forKey: .name           )
    region         = try values.decodeIfPresent(String.self , forKey: .region         )
    country        = try values.decodeIfPresent(String.self , forKey: .country        )
    lat            = try values.decodeIfPresent(Double.self , forKey: .lat            )
    lon            = try values.decodeIfPresent(Double.self , forKey: .lon            )
    tzId           = try values.decodeIfPresent(String.self , forKey: .tzId           )
    localtimeEpoch = try values.decodeIfPresent(Int.self    , forKey: .localtimeEpoch )
    localtime      = try values.decodeIfPresent(String.self , forKey: .localtime      )
 
  }

  init() {

  }

}

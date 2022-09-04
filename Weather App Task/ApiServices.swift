//
//  ApiServices.swift
//  Weather App Task
//
//  Created by Janarthan S on 04/09/22.
//

import Foundation

class ApiServices{
    
   static let shared = ApiServices()
    
    func makeapicall<T:Decodable>(url:URL,type:String,completionHandler:@escaping(Swift.Result<T,Error>) -> Void){
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession(configuration: .default).dataTask(with: request) { [self] (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200,let data = data{
                do {
                    var datajson = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    decoder.keyDecodingStrategy = .convertFromKebabCase
                    let result =  try decoder.decode(T.self, from: data)
                    completionHandler(.success(result))
                } catch let decodeError {
                    let resultJson =  try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    completionHandler(.failure(decodeError))
                }
            }else if let error = error{
                completionHandler(.failure(error))
            }else{
                let httpResponse = response as! HTTPURLResponse
                let errorMessage = "API Call failed : \(httpResponse.statusCode) & Failed URL : \(url)"
                let error = self.getError(code: httpResponse.statusCode, description: "Something went wrong kindly try again later.")
                completionHandler(.failure(error))
            }
        }.resume()
    }
    
    func getError(code:Int,description:String)->Error {
        let userInfo: [String : Any] = [
            NSLocalizedDescriptionKey :  NSLocalizedString("Unauthorized", value: description, comment: "")
        ]
        return NSError(domain: "\(code)", code: code, userInfo: userInfo)
    }

}

public extension JSONDecoder.KeyDecodingStrategy {

      static let convertFromKebabCase = JSONDecoder.KeyDecodingStrategy.custom({ keys in
         // Should never receive an empty `keys` array in theory.
         guard let lastKey = keys.last else {
             return AnyKey.empty
         }
         // Represents an array index.
         if lastKey.intValue != nil {
             return lastKey
         }
         let components = lastKey.stringValue.split(separator: "-")
         guard let firstComponent = components.first?.lowercased() else {
             return lastKey
         }
         let trailingComponents = components.dropFirst().map {
             $0.capitalized
         }
         let lowerCamelCaseKey = ([firstComponent] + trailingComponents).joined()
         return AnyKey(string: lowerCamelCaseKey)
     })

  }

struct AnyKey: CodingKey {

      static let empty = AnyKey(string: "")

      var stringValue: String
     var intValue: Int?

      init?(stringValue: String) {
         self.stringValue = stringValue
         self.intValue = nil
     }

      init?(intValue: Int) {
         self.stringValue = String(intValue)
         self.intValue = intValue
     }

      init(string: String) {
         self.stringValue = string
         self.intValue = nil
     }

  }


extension DateFormatter {
    static let fullISO8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

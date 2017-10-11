//
//  DSDataService.swift
//  based-weather
//
//  Created by Andrew Zah on 10/7/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

// DarkSky API Interface
class DSAPIService {
    static let instance = DSAPIService()
    
    func updateWeatherData(location: Location, completion: @escaping CompletionHandler) {
        let URL = "\(API_URL)\(location.coords)"
        print(URL)
        let params: Parameters = [
            "units": RealmService.inst.getOrCreateUserSettings().unitType,
            "exclude": "minutely,hourly,flags"
        ]
        
        Alamofire.request(URL, method: .get, parameters: params, encoding: URLEncoding.default, headers: HEADERS).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                location.update(json: json)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
}

//
//  JsonDecoderHelper.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import RxSwift
import SwiftyJSON

protocol JsonDecoderProtocol {
    func decodeWeather(from json: JSON) -> Observable<Weather?>
}

class JsonDecoderHelper: JsonDecoderProtocol {
    func decodeWeather(from json: JSON) -> Observable<Weather?> {
        let weather = json["weather"].arrayValue.first
        let mainData = json["main"].dictionaryValue
        let cityName = json["name"].stringValue
        
        if let icon = weather?["icon"].string,
           let temperatureInCelsuis = mainData["temp"]?.double,
           let humidity = mainData["humidity"]?.int {
            
            let weather = Weather(cityName: cityName, temperature: temperatureInCelsuis, humidity: humidity, icon: icon)
            return Observable.just(weather)
        }
        
        return Observable.just(nil)
    }
}

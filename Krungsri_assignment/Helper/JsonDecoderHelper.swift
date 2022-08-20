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
    func decodeWeathersFiveDayForcase(from json: JSON) -> Observable<[Weather]>
}

class JsonDecoderHelper: JsonDecoderProtocol {
    func decodeWeather(from json: JSON) -> Observable<Weather?> {
        let main = json["main"].dictionaryValue
        let cityName = json["name"].stringValue
        
        if let weather = json["weather"].arrayValue.first,
           let icon = weather["icon"].string,
           let temperature = main["temp"]?.double,
           let humidity = main["humidity"]?.int {
          
            let weather = Weather(
                cityName: cityName,
                temperature: temperature,
                humidity: humidity,
                icon: icon
            )
            
            return Observable.just(weather)
        }
        
        return Observable.just(nil)
    }
    
    func decodeWeathersFiveDayForcase(from json: JSON) -> Observable<[Weather]> {
        var weathers: [Weather] = []
        
        let list = json["list"].arrayValue
        let city = json["city"].dictionaryValue
        
        
        for value in list {
            if let weather = value["weather"].arrayValue.first,
               let main = value["main"].dictionary,
               let icon = weather["icon"].string,
               let temperature = main["temp"]?.double,
               let humidity = main["humidity"]?.int,
               let cityName = city["name"]?.string,
               let dateTime = value["dt_txt"].string {
                
                let date = dateTime.components(separatedBy: " ").first
                let time = dateTime.components(separatedBy: " ").last
                let weather = Weather(
                    cityName: cityName,
                    temperature: temperature,
                    humidity: humidity,
                    icon: icon,
                    date: date, time: time
                )
                weathers.append(weather)
            }
        }
        
        return Observable.just(weathers)
    }
}

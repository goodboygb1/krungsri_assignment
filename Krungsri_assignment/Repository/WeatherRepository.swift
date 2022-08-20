//
//  WeatherRepository.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import RxSwift
import SwiftyJSON

enum Units {
    case imperial
    case metric
}

protocol WeatherRepository {
    func getWeather(with cityName: String, units: Units) -> Observable<JSON>
    func getWeatherFiveDayForcast(with cityName: String, units: Units) -> Observable<JSON>
}

class WeatherDataRepository: WeatherRepository {
    
    private var alamofire: Alamofire
    
    init(alamofire: Alamofire) {
        self.alamofire = alamofire
    }
    
    func getWeather(with cityName: String, units: Units) -> Observable<JSON> {
        switch units {
        case .imperial:
            let url = "\(Constant.endPointUrl)/data/2.5/weather?q=\(cityName)&appid=\(Constant.apiKey)&units=imperial"
            return alamofire.getRequest(with: url, parameter: nil, method: .get)
        case .metric:
            let url = "\(Constant.endPointUrl)/data/2.5/weather?q=\(cityName)&appid=\(Constant.apiKey)&units=metric"
            return alamofire.getRequest(with: url, parameter: nil, method: .get)
        }
    }
    
    func getWeatherFiveDayForcast(with cityName: String, units: Units) -> Observable<JSON> {
        switch units {
        case .imperial:
            let url = "\(Constant.endPointUrl)/data/2.5/forecast?q=\(cityName)&appid=\(Constant.apiKey)&units=imperial"
            return alamofire.getRequest(with: url, parameter: nil, method: .get)
        case .metric:
            let url = "\(Constant.endPointUrl)/data/2.5/forecast?q=\(cityName)&appid=\(Constant.apiKey)&units=metric"
            return alamofire.getRequest(with: url, parameter: nil, method: .get)
        }
    }
}

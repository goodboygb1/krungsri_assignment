//
//  Weather.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation

struct Weather {
    let cityName: String?
    let temperature: Double?
    let humidity: Int?
    let icon: String?
    var weatherImageUrl: String {
        return "https://openweathermap.org/img/wn/\(icon ?? "")@2x.png"
    }
}

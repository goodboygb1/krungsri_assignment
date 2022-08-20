//
//  WeatherForcastTableViewCell.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import UIKit
import Kingfisher
import RxSwift

class WeatherForcastTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var degreeSignlabel: UILabel!
    @IBOutlet weak var huminitylabel: UILabel!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setImageForWeatherConditionImageView(with url: String) {
        weatherConditionImageView.kf.setImage(with: URL(string: url))
    }
    
    func setTempurature(with tempurature: Double) {
        temperatureLabel.text = String(tempurature)
    }
    
    func setDegreeSight(with units: Units) {
        switch units {
        case .imperial:
            degreeSignlabel.text = "°F"
        case .metric:
            degreeSignlabel.text = "°C"
        }
    }
    
    func setHumidity(with humidity: Int) {
        huminitylabel.text = String(humidity)
    }
    
    func setDate(with date: String) {
        dateLabel.text = date
    }
    
    func setTime(with time: String) {
        timeLabel.text = time
    }
    
}

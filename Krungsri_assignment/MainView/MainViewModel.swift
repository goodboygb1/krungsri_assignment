//
//  MainViewModel.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import SwiftyJSON

class MainViewModel: BaseViewModel {
    
    var weatherRepository: WeatherRepository
    var jsonDecoder: JsonDecoderProtocol
    
    // input
    let cityName: PublishSubject<(String,Units)> = PublishSubject<(String,Units)>()
    // output
    var temperature: Driver<Double>?
    var huminity: Driver<Int>?
    var weatherImageUrl: Observable<String>?
    let changeTempAction = PublishSubject<Bool>()
    
    var isTempShowInCelsuis: Bool = true
    let weather = BehaviorRelay<Weather?>(value: nil)
    
    
    init(input: MainCoordinatorInput) {
        self.weatherRepository = input.weatherRepository
        self.jsonDecoder = input.jsonDecoderHelper
        bindObserable()
    }
    
    func bindObserable() {
        let weather = cityName
            .flatMap{ [weak self] (cityName, units) -> Observable<JSON> in
                guard let self = self else { return Observable.empty()}
                return self.weatherRepository.getWeather(with: cityName, units: units)
            }
            .flatMap { [weak self] result -> Observable<Weather?> in
                guard let self = self else { return Observable.empty()}
                return self.jsonDecoder.decodeWeather(from: result)
            }
            .do(onNext: { [weak self] weather in
                self?.weather.accept(weather)
            })
        
        temperature = weather
            .map({$0?.temperature ?? 0.0})
            .asDriver(onErrorJustReturn: 0.0)
        
        huminity = weather
            .map({$0?.humidity ?? 0})
            .asDriver(onErrorJustReturn: 0)
        
        weatherImageUrl = weather
            .map({$0?.weatherImageUrl ?? ""})
    }
}

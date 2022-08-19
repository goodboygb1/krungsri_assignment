//
//  ViewController.swift
//  Krungsri_assignment
//
//  Created by PMJs on 19/8/2565 BE.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MainViewController: BaseViewController {

    @IBOutlet weak var degreeSignLabel: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var convertTempToCAndFButton: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        bindAction()
        driveEvent()
    }
    
    func setupButton() {
        convertTempToCAndFButton.setCornerRadius()
    }
    
    func bindAction() {
        guard let viewModel = viewModel else { return }
        cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            viewModel.cityName.onNext((self.cityNameTextField.text ?? "", .metric))
        }).disposed(by: disposeBag)
        
        convertTempToCAndFButton.rx.tap
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            if viewModel.isTempShowInCelsuis {
                viewModel.cityName.onNext((self.cityNameTextField.text ?? "", .imperial))
                self.convertTempToFahrenheit()
            } else {
                viewModel.cityName.onNext((self.cityNameTextField.text ?? "", .metric))
                self.convertTempToCelsuis()
            }
        }).disposed(by: disposeBag)
    }
    
    func driveEvent() {
        viewModel?.temperature?
            .map { String(Int($0)) }
            .drive(temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.huminity?
            .map { String($0) }
            .drive(humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.weatherImageUrl?
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] url in
                guard let self = self else { return }
                self.weatherImageView.kf.setImage(with: URL(string: url))
        })
            .disposed(by: disposeBag)
    }
    
    func convertTempToCelsuis() {
        viewModel?.isTempShowInCelsuis = true
        self.degreeSignLabel.text = "°C"
    }
    
    func convertTempToFahrenheit() {
        viewModel?.isTempShowInCelsuis = false
        self.degreeSignLabel.text = "°F"
    }
}


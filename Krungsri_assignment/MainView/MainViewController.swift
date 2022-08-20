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
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var showForecastButton: UIButton!
    
    var viewModel: MainViewModel?
    let showForecastAction = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        bindAction()
        driveEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupButton() {
        convertTempToCAndFButton.setCornerRadius()
        convertTempToCAndFButton.isHidden = true
        showForecastButton.isHidden = true
        
        showForecastButton
            .rx
            .tap
            .bind(to: showForecastAction)
            .disposed(by: disposeBag)
    }
    
    func bindAction() {
        guard let viewModel = viewModel else { return }
        cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                viewModel.input.accept((self.cityNameTextField.text ?? "", .metric))
            }).disposed(by: disposeBag)
        
        convertTempToCAndFButton.rx.tap
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                switch viewModel.units {
                case .imperial:
                    viewModel.input.accept((self.cityNameTextField.text ?? "", .metric))
                    self.convertTempToCelsuis()
                case .metric:
                    viewModel.input.accept((self.cityNameTextField.text ?? "", .imperial))
                    self.convertTempToFahrenheit()
                }
                
            }).disposed(by: disposeBag)
    }
    
    func driveEvent() {
        viewModel?.temperature?
            .do(onNext: { [weak self] _ in
                self?.convertTempToCAndFButton.isHidden = false
                self?.showForecastButton.isHidden = false
            })
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
        
        viewModel?.backgroundColour?
            .drive(backgroundView.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
    
    func convertTempToCelsuis() {
        viewModel?.units = .metric
        self.degreeSignLabel.text = "°C"
    }
    
    func convertTempToFahrenheit() {
        viewModel?.units = .imperial
        self.degreeSignLabel.text = "°F"
    }
}


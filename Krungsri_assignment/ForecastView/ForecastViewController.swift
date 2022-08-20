//
//  ForecastViewController.swift
//  Krungsri_assignment
//
//  Created by PMJs on 20/8/2565 BE.
//

import UIKit

class ForecastViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ForecastViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavbar()
        bindObservable()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel?.backgroundColour.subscribe(onNext: { [weak self] colour in
            self?.tableView.backgroundColor = colour
        }).disposed(by: disposeBag)
    }
    
    func setupNavbar() {
        self.navigationItem.title = viewModel?.input.value.cityName
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func bindObservable() {
        self.viewModel?.reloadTableViewAction.subscribe(onNext: { [weak self] in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        self.viewModel?.weatherForcasts.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.weatherForcasts.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: Constant.TableViewCellName.weatherForcastCell, for: indexPath) as? WeatherForcastTableViewCell else { fatalError("faild to dequeueing the cell") }
        
        let weatherForCell = viewModel?.weatherForcasts.value[indexPath.row]
        
        cell.setTempurature(with: weatherForCell?.temperature ?? 0.0)
        cell.setDegreeSight(with: viewModel?.input.value.units ?? .metric)
        cell.setHumidity(with: weatherForCell?.humidity ?? 0)
        cell.setImageForWeatherConditionImageView(with: weatherForCell?.weatherImageUrl ?? "")
        cell.setDate(with: weatherForCell?.date ?? "")
        cell.setTime(with: weatherForCell?.time ?? "")
        
        return cell
    }
}

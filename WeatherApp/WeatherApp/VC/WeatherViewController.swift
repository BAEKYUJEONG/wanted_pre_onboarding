//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by 백유정 on 2022/06/16.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // 공주, 광주(전라남도), 구미, 군산, 대구, 대전, 목포, 부산, 서산, 서울, 속초, 수원, 순천, 울산, 익산, 전주, 제주시, 천안, 청주, 춘천
    var cityArray: [String] = ["busan", "seoul", "jeju"]
    var weatherList: [WeatherResponse] = []
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.prefetchDataSource = self
    }
    
    func fetchWeatherData(city: String) {
        WeatherAPIManager().getWeather(city: city) { data, error in
            guard let data = data else {
                return
            }
            
            self.weatherList.append(data)
            
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
        }
    }
}

extension WeatherViewController: UITableViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            fetchWeatherData(city: cityArray[indexPath.row])
            print("prefetch:\(indexPath)")
        }
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = weatherTableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier) as? WeatherTableViewCell else { return UITableViewCell() }
        
        let row = weatherList[indexPath.row]
        
        cell.cityLabel.text = cityArray[indexPath.row]
        cell.temperatureLabel.text = "\(row.main.temp)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

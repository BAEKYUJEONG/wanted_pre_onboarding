//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by 백유정 on 2022/06/17.
//

import UIKit

// 도시이름, 날씨 아이콘, 현재기온, 체감기온, 헌재습도, 최저기온, 최고기온, 기압, 풍속, 날씨설명

class WeatherDetailViewController: UIViewController {
    
    static let identifier = "WeatherDetailViewController"
    
    var city: String?
    var descript: String?
    var icon: String?
    var temp: String?
    var tempMax: String?
    var tempMin: String?
    var feelsLike: String?
    var humi: String?
    var pressure: String?
    var speed: String?

    @IBOutlet weak var detailCityLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailIconImageView: UIImageView!
    @IBOutlet weak var detailTempLabel: UILabel!
    @IBOutlet weak var detailTempMaxLabel: UILabel!
    @IBOutlet weak var detailTempMinLabel: UILabel!
    @IBOutlet weak var detailFeelsLikeLabel: UILabel!
    @IBOutlet weak var detailHumidityLabel: UILabel!
    @IBOutlet weak var detailPressureLabel: UILabel!
    @IBOutlet weak var detailSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingUI()
    }
    
    func settingUI() {
        detailCityLabel.text = city
        detailDescriptionLabel.text = descript
        detailTempLabel.text = temp
        detailTempMaxLabel.text = tempMax
        detailTempMinLabel.text = tempMin
        detailFeelsLikeLabel.text = feelsLike
        detailHumidityLabel.text = humi
        detailPressureLabel.text = pressure
        detailSpeedLabel.text = speed
        
        let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(icon ?? "00")@2x.png")
        let data = try? Data(contentsOf: imageUrl!)
        if let data = data {
            detailIconImageView.image = UIImage(data: data)
        }
    }
}

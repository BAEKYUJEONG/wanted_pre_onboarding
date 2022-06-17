//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by 백유정 on 2022/06/17.
//

import Foundation

struct Weather: Codable {
    // 도시이름, 날씨 아이콘, 현재기온, 현재습도
    let city: String
    let icon: String
    let temp: Double
    let humi: Double
}

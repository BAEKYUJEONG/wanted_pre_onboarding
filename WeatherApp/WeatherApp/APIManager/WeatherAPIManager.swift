//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by 백유정 on 2022/06/17.
//

import Foundation

// 에러 정의
enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class WeatherAPIManager {
    
    func getWeather(city: String, completion: @escaping (WeatherResponse?, APIError?) -> Void) {
        let url = URL(string: "\(EndPoint.openWeatherURL)q=\(city)&appid=\(APIKey.OPEN_WEATHER)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async { // 메인스레드에서!
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(WeatherResponse.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            
        }.resume()
    }
}

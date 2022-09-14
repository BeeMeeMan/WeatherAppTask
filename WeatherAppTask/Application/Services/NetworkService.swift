//
//  NetworkService.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

private enum APIKeys {
    static let weatherAPIKey = "935816ca51975865a24c12784fe691a1"
}

private enum Urls {
    static func urlForWeatherByCity(city: String) -> URL {
        return  URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=\(APIKeys.weatherAPIKey)")!
    }
}

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T> {
    let url: URL
    var httpMethod: HttpMethod = .get
    let parse: (Data) -> T?
}

final class Webservice {
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}

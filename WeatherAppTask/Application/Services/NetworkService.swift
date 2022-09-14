//
//  NetworkService.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

//enum NetworkError: Error {
//    case decodingError
//    case domainError
//    case urlError
//}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T> {
    let url: URL
    var httpMethod: HttpMethod = .get
    let parse: (Data) -> T?
}

final class NetworkService {
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

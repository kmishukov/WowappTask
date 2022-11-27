//
//  NetworkManager.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import Foundation

struct NetworkResponse {
    let data: Data?
    let response: URLResponse?
    let error: NetworkError?
}

enum NetworkError: Error {
    case wrongURL
    case networkError(String)
}

final class NetworkManager {
    static func request(url: String, parameter: String?, completion: @escaping (NetworkResponse) -> Void) {
        guard let url = URL(string: url) else {
            completion(NetworkResponse(data: nil, response: nil, error: .wrongURL))
            return
        }
        HTTPRequest.request(url: url, parameter: parameter) { (data, response, error) in
            completion(NetworkResponse(data: data, response: response, error: error))
        }
    }
}

final class HTTPRequest {
    static func request(url: URL,
                        parameter: String?,
                        completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: NetworkError?) -> Void) {
        let request = NSMutableURLRequest(url: url)
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 10
        config.timeoutIntervalForRequest = 10
        let task = URLSession(configuration: config).dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, nil, .networkError(error.localizedDescription))
                } else {
                    completion(data, response, nil)
                }
            }
        }
        task.resume()
    }
}

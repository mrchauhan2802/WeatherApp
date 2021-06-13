//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

class NetworkManager {
    
    // MARK: - Class Enums

    enum HTTPMethod: String {
        case get    = "GET"
        case post   = "POST"
    }

    enum APIStatus {
        case invalidORFailedRequest
        case successResponse
        case invalidData
        case noDataFound
        case noInternet
        case jsonMappingFailed
    }

    // -----------------------------------------------------------------------------------------------

    
    // MARK: - Static Properties
    
    static let shared = NetworkManager()

    // -----------------------------------------------------------------------------------------------

    // MARK: - Class Functions
    
    func request(url: String,
                     methodType: HTTPMethod = .post,
                     parameters: [String: Any]? = nil,
                     withLoader isLoader: Bool = true,
                     withdebugLog isDebug: Bool = true,
                     withBlock completion: ((AnyObject?, Error?, APIStatus) -> Void)?) {
        
        guard let finalURL = URL(string: url) else { completion?(nil, nil, .noDataFound); return }
        
        if isLoader {
            Indicator.show()
        }

        if isDebug {
            Log.shortLine()
            Log.server("Request URL:\n\n\(finalURL)\n")
            Log.shortLine()
            Log.server("Request Parameters:\n\n\(parameters as AnyObject)\n")
        }
        
        var request = URLRequest(url: finalURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = methodType.rawValue
        
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        
        let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if isLoader {
                    Indicator.hide()
                }
            }
            
            if let error = error {
                
                if isDebug {
                    Log.shortLine()
                    Log.error("Response Error\n\n\(error.localizedDescription)")
                    Log.shortLine()
                }
                
                DispatchQueue.main.async {
                    completion?(nil, error, .invalidORFailedRequest)
                }
            }
            
            if let data = data {
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    if isDebug {
                        Log.shortLine()
                        Log.server("Response Data:\n\n\(jsonData as AnyObject)\n")
                        Log.shortLine()
                    }
                    
                    DispatchQueue.main.async {
                        completion?(jsonData as AnyObject, nil, .successResponse)
                    }
                    
                } catch let error {
                    
                    if isDebug {
                        Log.shortLine()
                        Log.error("Response Error\n\n\(error.localizedDescription)")
                        Log.shortLine()
                    }
                    
                    DispatchQueue.main.async {
                        completion?(nil, error, .jsonMappingFailed)
                    }
                }
                
            } else {
                
                if isDebug {
                    Log.shortLine()
                    Log.error("Response Error\n\nNo Data Found")
                    Log.shortLine()
                }
                
                DispatchQueue.main.async {
                    completion?(nil, error, .noDataFound)
                }
            }
        }
        sessionTask.resume()
    }
    
    // -----------------------------------------------------------------------------------------------
}

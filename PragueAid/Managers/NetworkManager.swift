//
//  NetworkManager.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseUrlString = "http://api.golemio.cz/v2/medicalinstitutions"
    private let apiKey = "" //generate your own at https://api.golemio.cz/api-keys
    
    
    func getTargets(params: String = "", completed: @escaping(Result<TargetCollection, PAError>) -> Void) {
        let endpointString = baseUrlString + params
        guard let url = URL(string: endpointString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-access-token")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let locations = try decoder.decode(TargetCollection.self, from: data)
                completed(.success(locations))
            } catch {
                print(response)
                completed(.failure(.unableToDecode))
            }
        }
        task.resume()
    }
}

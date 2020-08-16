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
    let baseUrlString = "http://opendata.praha.eu/dataset/78c4691d-b0a3-4ba7-b3c4-0a97d3491253/resource/1516aad7-8319-4417-9db6-22f0a56f776c/download/c97f002f-d79c-4b0c-b2bb-0411025334fa-medical-institutions.json"
    
    func getAllLocations(completed: @escaping(Result<Collection, PAError>) -> Void) {
        
        let endpointString = baseUrlString + ""
        
        guard let url = URL(string: endpointString) else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                let locations = try decoder.decode(Collection.self, from: data)
                completed(.success(locations))
            } catch {
                completed(.failure(.unableToDecode))
            }
        }
        task.resume()
    }
}

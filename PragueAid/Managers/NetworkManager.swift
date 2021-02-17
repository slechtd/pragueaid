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
    
    private let baseUrlString = "https://api.golemio.cz/v2/medicalinstitutions"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImRhbi5zbGVjaHRhQGdtYWlsLmNvbSIsImlkIjozNTksIm5hbWUiOm51bGwsInN1cm5hbWUiOm51bGwsImlhdCI6MTU5NzU3MDY2NSwiZXhwIjoxMTU5NzU3MDY2NSwiaXNzIjoiZ29sZW1pbyIsImp0aSI6IjM0Mzc1NWJlLTRmYTktNGVmYS1hMGU1LTA5NjM4MWM0YjY1YiJ9.rQxBlzqmcA3wsXUluPFBDK3M1QUprjq6w4lmO3ozoaE"
    
    
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

//
//  Services.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 06/11/20.
//

import Foundation

class RequestsManager {
    
    static let shared = RequestsManager()
    
    private init() {}
    
    func makeRequest(to url: String, method: RequestMethod, completion: @escaping (Result<Data,Error>) -> Void ) {
        
        guard let parsedURL = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: parsedURL)
        let session = URLSession.shared
        request.httpMethod = method.rawValue
        
        session.dataTask(with: request) { (data, response, error) in
            guard let error = error else {
                if let data = data {
                    completion(.success(data))
                }
                return
            }
            completion(.failure(error))
            return
        }.resume()
        
        request.httpMethod = method.rawValue
    }
}

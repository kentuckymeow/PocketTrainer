//
//  AuthService.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 20.04.2024.
//

import Foundation

enum ServiceError: Error {
    case serverError(String)
    case unkown(String = "An unknown error occured.")
    case decodingError(String = "Error parsing server response.")
}

class AuthService {
    
    static func fetch(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ServiceError.unkown()))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                // Success
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(ServiceError.decodingError()))
                }
                
            case 400...499:
                // Client errors
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.decodingError()))
                }
                
            default:
                // Other errors
                completion(.failure(ServiceError.unkown()))
            }
        }.resume()
    }


    
    // MARK: - Sign Out
    static func signOut() {
        let url = URL(string: Constants.fullURL)!
        let cookie = HTTPCookieStorage.shared.cookies(for: url)!.first!
        HTTPCookieStorage.shared.deleteCookie(cookie)
    }
    
}

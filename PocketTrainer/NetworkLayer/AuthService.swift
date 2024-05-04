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
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                guard
                    let url = response?.url,
                    let httpResponse = response as? HTTPURLResponse,
                    let fields = httpResponse.allHeaderFields as? [String: String]
                else {
                    completion(.failure(ServiceError.unkown()))
                    return
                }

                let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
                HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                for cookie in cookies {
                    var cookieProperties = [HTTPCookiePropertyKey: Any]()
                    cookieProperties[.name] = cookie.name
                    cookieProperties[.value] = cookie.value
                    cookieProperties[.domain] = cookie.domain
                    cookieProperties[.path] = cookie.path
                    cookieProperties[.version] = cookie.version
                    cookieProperties[.expires] = Date().addingTimeInterval(31536000)

                    let newCookie = HTTPCookie(properties: cookieProperties)
                    HTTPCookieStorage.shared.setCookie(newCookie!)

                    print("name: \(cookie.name) value: \(cookie.value)")
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
                            completion(.failure(ServiceError.serverError("Client error: \(httpResponse.statusCode), Description: \(error.localizedDescription)")))
                        } else {
                            completion(.failure(ServiceError.decodingError("Client error: \(httpResponse.statusCode), Description: \(error?.localizedDescription)")))
                        }
                        
                    default:
                        // Other errors
                        completion(.failure(ServiceError.unkown("Other error: \(httpResponse.statusCode), Description: \(error?.localizedDescription ?? "Unknown error")")))
                }

            }
            task.resume()
        }
    
    // MARK: - Sign Out
    static func signOut() {
        let url = URL(string: Constants.fullURL)!
        let cookie = HTTPCookieStorage.shared.cookies(for: url)!.first!
        HTTPCookieStorage.shared.deleteCookie(cookie)
    }
    
}

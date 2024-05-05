//
//  Endpoints.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 20.04.2024.
//

import Foundation

enum Endpoint {
    
    case createAccount(path: String = "/auth/register", userRequest: RegisterUserModel)
    case signIn(path: String = "/auth/login", userRequest: SignInUserModel)
    case forgotPassword(path: String = "/auth/forgot-password", email: String)
    case healthData(path: String = "/users/health-data", userRequest: HealthDataModel)
    case healthDataUpdate(path: String = "/users/update-data", userRequest: HealthDataModel)
    case userHealthData(path: String = "/users/user-health-data", userRequest: HealthDataModel)
    
    
    case getData(path: String = "/data/get-data")
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.addValues(for: self)
        request.httpBody = self.httpBody
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        return components.url
    }
    
    private var path: String {
        switch self {
        case .createAccount(let path, _),
                .signIn(let path, _),
                .forgotPassword(let path, _),
                .healthData(let path, _),
                .healthDataUpdate(let path, _),
                .userHealthData(let path, _),
                .getData(let path):
            return path
        }
    }
    
    private var httpMethod: String {
            switch self {
            case .createAccount,
                    .signIn,
                    .forgotPassword,
                    .healthData:
                return HTTP.Method.post.rawValue
            case .healthDataUpdate:
                return HTTP.Method.pacth.rawValue
            case .getData,
                    .userHealthData:
                return HTTP.Method.get.rawValue
            
            }
        }
        
        private var httpBody: Data? {
            switch self {
            case .createAccount(_, let userRequest):
                return try? JSONEncoder().encode(userRequest)
                
            case .signIn(_, let userRequest):
                return try? JSONEncoder().encode(userRequest)
                
            case .forgotPassword(_, let email):
                return try? JSONSerialization.data(withJSONObject: ["email": email], options: [])
                
            case .healthData(_, let userRequest):
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .custom { (date, encoder) in
                    let dateString = formatter.string(from: date)
                    var container = encoder.singleValueContainer()
                    try container.encode(dateString)
                }

                let data = try? encoder.encode(userRequest)
                print("health data: \(String(data: data ?? Data(), encoding: .utf8) ?? "nil")")
                return try? encoder.encode(userRequest)
                
            case .healthDataUpdate(_, let userRequest):
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .custom { (date, encoder) in
                    let dateString = formatter.string(from: date)
                    var container = encoder.singleValueContainer()
                    try container.encode(dateString)
                }

                let data = try? encoder.encode(userRequest)
                print("health data update: \(String(data: data ?? Data(), encoding: .utf8) ?? "nil")")
                return try? encoder.encode(userRequest)
                return try? JSONEncoder().encode(userRequest)
                
            case  .userHealthData(_, let userRequest):
                return nil
                
            case .getData:
                return nil
            
            }
        }
        
    }

    extension URLRequest {
        
        mutating func addValues(for endpoint: Endpoint) {
            switch endpoint {
            case .createAccount,
                    .signIn,
                    .forgotPassword,
                    .healthData,
                    .healthDataUpdate,
                    .userHealthData,
                    .getData:
                self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
           
            }
        }
    }

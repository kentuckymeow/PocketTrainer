//
//  HTTP.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 20.04.2024.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case pacth = "PATCH"
    }
    
    enum Headers {
        
        enum Key: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
        
    }
    
}

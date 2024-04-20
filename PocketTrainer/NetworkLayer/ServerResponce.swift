//
//  ServerResponce.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 20.04.2024.
//

import Foundation

struct SucessResponse: Decodable {
    let success: String
}

struct ErrorResponse: Decodable {
    let error: String
}

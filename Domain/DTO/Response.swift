//
//  Response.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - Response
struct Response<T: Codable>: Codable {
    let resultCount: Int
    let results: [T]
}

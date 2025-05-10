//
//  Response.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - Response
public struct Response<T: Codable>: Codable {
    let resultCount: Int
    public let results: [T]
}

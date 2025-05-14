//
//  SeasonType.swift
//  Presentation
//
//  Created by Quarang on 5/14/25.
//

import Foundation

// MARK: - 계절별 표시 타입
enum SeasonType: String {
    case category
    case spring = "봄"
    case summer = "여름"
    case autumn = "가을"
    case winter = "겨울"
    
    // 헤더 타이틀
    var title: String {
        switch self {
        case .category:
            return ""
        case .spring:
            return "봄 Best"
        case .summer:
            return "여름"
        case .autumn:
            return "가을"
        case .winter:
            return "겨울"
        }
    }
    
    // 헤더 부 타이틀
    var subtitle: String {
        switch self {
        case .category:
            return ""
        case .spring:
            return "봄이 생각나는 🌷"
        case .summer:
            return "너무 더울 때는? 🌞"
        case .autumn:
            return "가을처럼 쓸쓸할 때 🍂"
        case .winter:
            return "눈이 오잖아~ ❄️"
        }
    }
}

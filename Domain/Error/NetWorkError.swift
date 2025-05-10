//
//  NetWorkError.swift
//  Domain
//
//  Created by Quarang on 5/10/25.
//

import Foundation

// MARK: 네트워크 통신 시 일어날 수 있는 에러 정의
public enum NetWorkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case statusCodeError(Int)
    case dataParsingError
    case noData
    case decodingError
    case timeout
    case unknown
    case invalidHTTPStatus

    var message: String {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .requestFailed:
            return "요청에 실패했습니다."
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .statusCodeError(let code):
            return "오류 상태 코드: \(code)"
        case .dataParsingError:
            return "데이터 파싱에 실패했습니다."
        case .noData:
            return "데이터가 없습니다."
        case .decodingError:
            return "디코딩 중 오류가 발생했습니다."
        case .timeout:
            return "요청 시간이 초과되었습니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        case .invalidHTTPStatus:
            return "서버로부터 유효하지 않은 상태 코드 응답을 받았습니다."
        }
    }
}

//
//  BaseViewModel.swift
//  Presentation
//
//  Created by Quarang on 5/15/25.
//

import Foundation
import Domain

// MARK: - 공통된 뷰 모델 기능을 사용하기 위함
public class BaseViewModel {
    /// 에러 핸들러
    func errorHandler(_ error: Error) {
        if let networkError = error as? NetWorkError {
            switch networkError {
            case .decodingError:
                print("❗️디코딩에 실패했습니다. 형식을 확인하세요.")
            case .statusCodeError(let code):
                print("❗️서버 상태 코드 오류: \(code)")
            case .dataParsingError:
                print("❗️데이터가 존재하지 않습니다.")
            default: break
            }
        } else {
            print("❗️알 수 없는 오류: \(error.localizedDescription)")
        }
    }
}

//
//  Presentation_Tests.swift
//  Presentation_Tests
//
//  Created by Quarang on 5/10/25.
//

import Testing
import Domain
import Data
import RxSwift

struct Presentation_Tests {
    
    var disposeBag = DisposeBag()
    
    var fetchITunesUseCase: FetchITunesUseCase {
        let repository = FetchITunesRepository()
        return FetchITunesUseCase(repository: repository)
    }
    
    @Test("음악 정보 데이터 수신 테스트")
    func testFetchMusic() async throws {
        let type = ViewType.music(entity: "song")
        
        fetchITunesUseCase.excute(term: "봄", type)
            .subscribe(onSuccess: { items in
                print("데이터 수신 성공 \(items)")
                #expect(true)
            }, onFailure: { error in
                guard let error = error as? NetWorkError else {
                    print(error.localizedDescription)
                    #expect(Bool(false))
                    return
                }
                print(error)
                #expect(Bool(false))
            })
            .disposed(by: disposeBag)
            
    }
}

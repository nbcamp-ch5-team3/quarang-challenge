//
//  ITunesAPIManager.swift
//  Data
//
//  Created by Quarang on 5/10/25.
//

import Foundation
import Domain
import RxSwift

// MARK: API 통신 네트워크 매니저
final class ITunesAPIManager {
    
    static let shared = ITunesAPIManager()
    private init() { }
    
    /// 아이튠즈 API 요청 및 Single 타입으로 반환
    func fetchITunesData(term: String, media: MediaType, entity: String) -> Single<[ITunes]> {
        
        let session = URLSession(configuration: .default)
        let requset = APIRequest.iTunes(term: term, media: media.rawValue, entity: entity).urlRequest
        print(requset)
        return Single.create { single in
            
            session.dataTask(with: requset) { data, response, error in
                if let error {
                    single(.failure(error))
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                    single(.failure(NetWorkError.statusCodeError(httpResponse.statusCode)))
                    return
                }
                guard let data else {
                    single(.failure(NetWorkError.dataParsingError))
                    return
                }
                do {
                    let response = try self.makeITunesResponse(data: data, media: media)
                    single(.success(response))
                } catch {
                    single(.failure(NetWorkError.decodingError))
                }
            }.resume()
            
            return Disposables.create()
        }
    }
    
    /// 디코딩 한 데이터로 DTO -> Model로 변환
    private func makeITunesResponse(data: Data, media: MediaType) throws -> [ITunes] {
        switch media {
        case .app: try decodeITunesResponse(Response<AppResponse>.self, from: data) { $0.toModel() }
        case .movie: try decodeITunesResponse(Response<MovieResponse>.self, from: data) { $0.toModel() }
        case .music: try decodeITunesResponse(Response<MusicResponse>.self, from: data) { $0.toModel() }
        case .podcast: try decodeITunesResponse(Response<PodcastResponse>.self, from: data) { $0.toModel() }
        }
    }
    
    /// 각 타입 별 디코딩 작업
    private func decodeITunesResponse<T: Decodable>(_ type: Response<T>.Type, from data: Data, transform: (T) -> ITunes) throws -> [ITunes] {
        do{
            let decoded = try JSONDecoder().decode(type, from: data)
            return decoded.results.map(transform)
        }
        catch {
            print("Error decoding: \(error)")
            throw NetWorkError.decodingError
        }
    }
}

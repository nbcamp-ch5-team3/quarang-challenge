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
    
    /// 아이튠즈 API 요청  Single 타입으로 반환
    func fetchITunesData(term: String, media: MediaType, entity: String) -> Single<[ITunes]> {
        let request = APIRequest.iTunes(term: term, media: media.rawValue, entity: entity).urlRequest
        return requestITunesData(with: request, media: media)
    }
    
    /// 아이튠즈 상세 데이터  API 요청  Single 타입으로 반환
    func fetchITunesDetailData(id: Int, media: MediaType) -> Single<[ITunesDetail]> {
        let request = APIRequest.iTunesDetail(id: id).urlRequest
        return requestITunesDetailData(with: request, media: media)
    }
    
    /// 아이튠즈 API 요청
    private func requestITunesData(with request: URLRequest, media: MediaType) -> Single<[ITunes]> {
        let session = URLSession(configuration: .default)
        print(request)
        return Single.create { single in
            session.dataTask(with: request) { data, response, error in
                do {
                    let data = try self.handleResponse(data: data, response: response, error: error)
                    let models = try self.makeITunesResponse(data: data, media: media, responseType: ITunes.self)
                    single(.success(models))
                } catch {
                    single(.failure(error))
                }
            }.resume()
            
            return Disposables.create()
        }
    }
    
    /// 아이튠즈 상세 데이터  API 요청
    private func requestITunesDetailData(with request: URLRequest, media: MediaType) -> Single<[ITunesDetail]> {
        let session = URLSession(configuration: .default)
        print(request)
        return Single.create { single in
            session.dataTask(with: request) { data, response, error in
                do {
                    let data = try self.handleResponse(data: data, response: response, error: error)
                    let models = try self.makeITunesResponse(data: data, media: media, responseType: ITunesDetail.self)
                    single(.success(models))
                } catch {
                    single(.failure(error))
                }
            }.resume()
            
            return Disposables.create()
        }
    }
    
    /// 에러 핸들링
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) throws -> Data {
        if let error { throw error }
        if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            throw NetWorkError.statusCodeError(httpResponse.statusCode)
        }
        guard let data else { throw NetWorkError.dataParsingError }
        return data
    }
    
    /// 디코딩 한 데이터로 DTO -> Model로 변환
    private func makeITunesResponse<T>(data: Data, media: MediaType, responseType: T.Type) throws -> [T] {
        switch media {
        case .app:
            return try decodeITunesResponse(Response<AppResponse>.self, from: data) {
                T.self == ITunes.self ? $0.toModel() as! T : $0.toDetailModel() as! T
            }
        case .movie:
            return try decodeITunesResponse(Response<MovieResponse>.self, from: data) {
                T.self == ITunes.self ? $0.toModel() as! T : $0.toDetailModel() as! T
            }
        case .music:
            return try decodeITunesResponse(Response<MusicResponse>.self, from: data) {
                T.self == ITunes.self ? $0.toModel() as! T : $0.toDetailModel() as! T
            }
        case .podcast:
            return try decodeITunesResponse(Response<PodcastResponse>.self, from: data) {
                T.self == ITunes.self ? $0.toModel() as! T : $0.toDetailModel() as! T
            }
        }
    }
    
    /// 각 타입 별 디코딩 작업
    private func decodeITunesResponse<R: Decodable, T>(_ type: Response<R>.Type, from data: Data, transform: (R) -> T) throws -> [T] {
        do {
            let decoded = try JSONDecoder().decode(type, from: data)
            return decoded.results.map(transform)
        } catch {
            print("Error decoding: \(error)")
            throw NetWorkError.decodingError
        }
    }
}

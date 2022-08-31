//
//  NetworkManager.swift
//  CoffeeAppCode
//
//  Created by 김현석 on 2022/08/26.
//

import UIKit

//MARK: - 네트워크에서 발생할 수 있는 에러 정의
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking (서버와 통신하는) 클래스 모델

final class NetworkManager {
    
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = NetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
        
    typealias NetworkCompletion = (Result<[Product], NetworkError>) -> Void

    // 네트워킹 요청하는 함수 (음악데이터 가져오기)
    func fetchProduct(searchTerm: String, completion: @escaping NetworkCompletion) {
        print(#function)
        print("2")
        
//        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        let urlString = ProjectApi.requestUrl
        print(urlString)
        
        
        performRequest(with: urlString) { result in
            print("5")
            completion(result)
        }
        
    }
    
    // 실제 Request하는 함수 (비동기적 실행 ===> 클로저 방식으로 끝난 시점을 전달 받도록 설계)
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        //print(#function)
        print("3")
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                print(error!.localizedDescription)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                print(error!.localizedDescription)
                completion(.failure(.dataError))
                return
            }
            
            // 메서드 실행해서, 결과를 받음
            if let products = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(products))
            } else {
                print("Parse 실패")
                print(error!.localizedDescription)
                completion(.failure(.parseError))
                
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseJSON(_ productData: Data) -> [Product]? {
        //print(#function)
        print("4")
        
        // 성공
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> MusicData 구조체)
            let productData = try JSONDecoder().decode(PrdListData.self, from: productData)
            print(productData)
            return productData.prdList
        // 실패
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
}

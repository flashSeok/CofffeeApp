//
//  NetworkManager.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

//MARK: - 네트워크에서 발생할 수 있는 에러 정의
enum ProductNetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking (서버와 통신하는) 클래스 모델
final class ProductNetworkManager {
    
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = ProductNetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
        
    typealias ProductNetworkCompletion = (Result<[PrdList], ProductNetworkError>) -> Void

    // 네트워킹 요청하는 함수 (상품데이터 가져오기)
    func fetchProduct(searchTerm: String, completion: @escaping ProductNetworkCompletion) {
        print(#function)
        print("2")

        let urlString = ProjectApi.productListRequestURL
        print("urlString : \(urlString)")
        
        performProductListRequest(with: urlString, search: searchTerm) { result in
            print("5")
            completion(result)
        }
        
    }
    
    // 실제 Request하는 함수 (비동기적 실행 ===> 클로저 방식으로 끝난 시점을 전달 받도록 설계)
    private func performProductListRequest(with urlString: String, search searchText: String?, completion: @escaping ProductNetworkCompletion) {
        print(#function)
        print("3")
        
        let PRD_CATE = "DRINK"
        let PRD_CATE_SUB = ""
        
        let param = [
                        "PRD_CATE" : PRD_CATE,
                        "PRD_CATE_SUB" : PRD_CATE_SUB,
                        "PRD_NAME_KR" : searchText
                    ]
        
        let param2 = ["REQ_BODY": param]
        
        let paramData = try! JSONSerialization.data(withJSONObject: param2, options: [])
        print("==================================")
        let jsonObj = String(data: paramData, encoding: .utf8) ?? ""
        print(jsonObj)
        print("==================================")
        
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = Data(jsonObj.utf8)
        
        // HTTP 메시지 헤더
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        

        let task = session.dataTask(with: request) { (data, response, error) in
            
            print("response : \(String(describing: response))")

            if error != nil {
                print(error!)
                print(String(describing: error))
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                print("바인딩 실패")
                print(String(describing: error))
                completion(.failure(.dataError))
                return
            }

            
            // 메서드 실행해서, 결과를 받음
            if let products = self.parseProductJSON(safeData) {

                print("Parse 실행")
//                dump(products)
                completion(.success(products))
            } else {
                print("Parse 실패")
                print(error!)
                print(String(describing: error))
                completion(.failure(.parseError))
                
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseProductJSON(_ productData: Data) -> [PrdList]? {
        print(#function)
        print("4")
        
//        dump(productData)
        // 별거없고 그냥 json 데이터형식으로 이쁘게 프린트하기..
        print("--------------------------------------------------------")
        if let json = try? JSONSerialization.jsonObject(with: productData, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("이쁘게 뽑기 실패")
        }
        print("--------------------------------------------------------")
        
        // 성공
        
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> ApiData 구조체)
            var productDataDecode = try JSONDecoder().decode(ApiData.self, from: productData)
            if productDataDecode.resBodyProduct.prdList[0].prdSeq == nil {
                print("널널널")
                let _ = productDataDecode.resBodyProduct.prdList = []
            }
            
            return productDataDecode.resBodyProduct.prdList
        // 실패
        } catch {
            print("실패!!!")
            print(String(describing: error))
            return nil
        }
    }
    
    
    
    
}

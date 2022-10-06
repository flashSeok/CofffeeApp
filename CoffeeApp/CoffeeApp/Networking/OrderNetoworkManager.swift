//
//  OrderNetoworkManager.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/10/06.
//

import UIKit

//MARK: - 네트워크에서 발생할 수 있는 에러 정의
enum OrderNetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

final class OrderNetworkManager {
    
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = OrderNetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    typealias OrderNetworkCompletion = (Result<OrderResultData, OrderNetworkError>) -> Void
    
    func fetchOrderResult(body: OrderInfo, completion: @escaping OrderNetworkCompletion) {
        print(#function)
        
        let urlString = ProjectApi.orderRequestURL
        print(urlString)
        
//        print("reqbody : \(reqBody)")
        
        performRequestOrder(url: urlString, body: body) { result in
            print("resultddd: \(result)")
            completion(result)
        }

        
    }
    
    private func performRequestOrder(url: String, body: OrderInfo, completion: @escaping OrderNetworkCompletion) {
        print(#function)
        

        // 문제
//        let reqBodyData = try! JSONSerialization.data(withJSONObject: reqBody, options: [])
        
        let encodedData = try! JSONEncoder().encode(body)
        let reqBody = String(data: encodedData, encoding: .utf8)
        
        guard let reqBody = reqBody else { return }
        
        print("reqBody: \(reqBody)")
        
//        let jsonObj = String(data: reqBodyData, encoding: .utf8) ?? ""
//        print("jsonObj : \(jsonObj)")
        
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = Data(reqBody.utf8)
        
        
        print("==================================")
//        let reqBodyDataPrint = String(data: reqBodyData, encoding: .utf8) ?? ""
//        print(reqBodyDataPrint)
        print("==================================")
        

        
        // HTTP 메시지 헤더
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(encodedData.count), forHTTPHeaderField: "Content-Length")
        
        let task = session.dataTask(with: request) { data, response, error in
            print("response : \(String(describing: response))")
            
            if error != nil {
                print("주문실패")
                print(error!)
                completion(.failure(.networkingError))
                
                return
            }
            
            guard let safeData = data else {
                print("데이터 이상")
                print(error!)
                completion(.failure(.dataError))
                
                return
            }
            
            if let orderInfoResultData = self.parseJsonOrderInfoResult(safeData) {
                print("Parsing 성공")
                completion(.success(orderInfoResultData))
            } else {
                print("Parsing 실패")
                completion(.failure(.parseError))
            }
            
        }
        task.resume()
        
    }
    
    private func parseJsonOrderInfoResult(_ orderData: Data) -> OrderResultData? {
        print(#function)
        
        // 별거없고 그냥 json 데이터형식으로 이쁘게 프린트하기..
        print("--------------------------------------------------------")
        if let json = try? JSONSerialization.jsonObject(with: orderData, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print("jsonData : \(jsonData)")
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("이쁘게 뽑기 실패")
        }
        print("--------------------------------------------------------")
        
        
        
        do {
            let orderResultInfoDecode = try JSONDecoder().decode(OrderResultData.self, from: orderData)
            
            return orderResultInfoDecode.self
            
        } catch {
            print(String(describing: error))
            
            return nil
        }
        
    }
    
    
}

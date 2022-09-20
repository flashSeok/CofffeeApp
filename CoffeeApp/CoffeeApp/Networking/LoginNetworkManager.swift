//
//  LoginNetworkManager.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit
import SwiftUI

//MARK: - 네트워크에서 발생할 수 있는 에러 정의
enum LoginNetworkError: Error {
    case networkingError
    case dataError
    case parseError
}


final class LoginNetworkManager {
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = LoginNetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
        
    typealias LoginNetworkCompletion = (Result<LoginInfo, LoginNetworkError>) -> Void

    func fetchLogginResult(id: String, pw: String, completion: @escaping LoginNetworkCompletion) {
        print(#function)
        print("2")
        
        //        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        let urlString = ProjectApi.requestURL
        print(urlString)
        
        
        performRequestLogin(with: urlString, id: id, pw: pw) { result in
            print("5")
            completion(result)
        }
        
    }
    
    private func performRequestLogin(with urlString: String, id: String, pw: String, completion: @escaping LoginNetworkCompletion) {
        print(#function)
        print("3")
        //        print(id)
        //        print(pw)
        
        let param = ["MEMBER_ID" : id, "MEMBER_PW" : pw]
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
            print("respone : \(String(describing: response))")
            if error != nil {
                print(error!)
                print(String(describing: error))
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                print(error!)
                print(String(describing: error))
                completion(.failure(.dataError))
                return
            }
            
            let safedata1 = String(data: safeData, encoding: .utf8) ?? ""
            print("safedata1 : \(safedata1)")
            
            
            // 메서드 실행해서, 결과를 받음
            //            if let safedata = String(data: safeData, encoding: .utf8) {
            if let login = self.parseJsonLoginInfo(safeData) {
                print("Parse 실행")
                print("login : \(login)")
                completion(.success(login))
            } else {
                print("Parse 실패")
                print(error!)
                print(String(describing: error))
                completion(.failure(.parseError))
                
            }
        }
        task.resume()
    }
    
    private func parseJsonLoginInfo(_ loginData: Data) -> LoginInfo? {
        print(#function)
        print("4")
        
        // 별거없고 그냥 json 데이터형식으로 이쁘게 프린트하기..
        print("--------------------------------------------------------")
        if let json = try? JSONSerialization.jsonObject(with: loginData, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("이쁘게 뽑기 실패")
        }
        print("--------------------------------------------------------")
        
        // 성공
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> LoginData 구조체)
            let loginUserDecode = try JSONDecoder().decode(LoginData.self, from: loginData)

            
            
//            switch loginUserDecode.resHead.retnCode {
//            case "200": // 성공
//            case "400": // 필수값 누락
//            case "500": // 없는 회원 번호
//            case "999": // 시스템 오류
//          
//            default:
//                break
//            }
            
            return loginUserDecode.loginUser
            // 실패
        } catch {
            print(String(describing: error))
            return nil
        }
    }
}

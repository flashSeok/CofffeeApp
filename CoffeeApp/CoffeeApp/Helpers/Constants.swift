//
//  Constants.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

//MARK: - Name Space 만들기

// 데이터 영역에 저장 (열거형, 구조체 다 가능 / 전역 변수로도 선언 가능)
// 사용하게될 API 문자열 묶음
public enum ProjectApi {
    static let requestURL = "http://mjydbgg.cafe24.com/member/loginMember.do"
//    static let mediaParam = "media=music"
    static let loginURL = "http://172.30.1.50:9090/member/loginMember.do"
    
}


// 사용하게될 Cell 문자열 묶음
public struct Cell {
    static let productCellIdentifier = "MainTableViewCell"
    static let productCollectionViewCellIdentifier = "ProductCollectionViewCell"
    private init() {}
}



// 컬렉션뷰 구성을 위한 설정
public struct CVCell {
    static let spacingWitdh: CGFloat = 1
    static let cellColumns: CGFloat = 3
    private init() {}
}

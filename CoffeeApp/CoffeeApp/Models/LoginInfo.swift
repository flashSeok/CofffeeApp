//
//  LoginInfo.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

// 서버에서 받는 데이터
// MARK: - Welcome
struct LoginData: Codable {
    let resHead: ResHead
    let loginUser: LoginInfo

    enum CodingKeys: String, CodingKey {
        case resHead = "RES_HEAD"
        case loginUser = "RES_BODY"
    }
}

// MARK: - ResBody
struct LoginInfo: Codable {
    let memberName: String?
    let memberSeq: Int?
    let memberNick: String?
    let ment: String?

    enum CodingKeys: String, CodingKey {
        case memberName = "MEMBER_NAME"
        case memberSeq = "MEMBER_SEQ"
        case memberNick = "MEMBER_NICK"
        case ment = "MENT"
    }
}

// MARK: - ResHead
struct ResHead: Codable {
    let retnMent, retnCode: String

    enum CodingKeys: String, CodingKey {
        case retnMent = "RETN_MENT"
        case retnCode = "RETN_CODE"
    }
}

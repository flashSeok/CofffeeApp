//
//  OrderResultInfo.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/10/06.
//

import UIKit



// MARK: - Welcome
struct OrderResultData: Codable {
    let resHead: OrderResultResHead
    let resBody: OrderResultResBody

    enum CodingKeys: String, CodingKey {
        case resHead = "RES_HEAD"
        case resBody = "RES_BODY"
    }
}

// MARK: - ResBody
struct OrderResultResBody: Codable {
    let orderSeq: String?
    let memberNick: String?
    let orderDate: String?
    let orderList: [OrderListResult]

    enum CodingKeys: String, CodingKey {
        case orderSeq = "ORDER_SEQ"
        case memberNick = "MEMBER_NICK"
        case orderDate = "ORDER_DATE"
        case orderList = "ORDER_LIST"
    }
}

// MARK: - OrderList
struct OrderListResult: Codable {
    let prdSeq: Int?
    let prdNameKr: String?
    let prdNameEn: String?
    let prdPrice: String?

    enum CodingKeys: String, CodingKey {
        case prdSeq = "PRD_SEQ"
        case prdNameKr = "PRD_NAME_KR"
        case prdNameEn = "PRD_NAME_EN"
        case prdPrice = "PRD_PRICE"
    }
}

// MARK: - ResHead
struct OrderResultResHead: Codable {
    let retnCode: String?
    let retnMent: String?

    enum CodingKeys: String, CodingKey {
        case retnCode = "RETN_CODE"
        case retnMent = "RETN_MENT"
    }
}

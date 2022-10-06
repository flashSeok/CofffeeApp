//
//  OrderInfo.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/10/04.
//

import UIKit


// MARK: - Welcome
struct OrderInfo: Codable {
    let reqBody: ReqBody

    enum CodingKeys: String, CodingKey {
        case reqBody = "REQ_BODY"
    }
}

// MARK: - ReqBody
struct ReqBody: Codable {
    let memberSeq: Int
    let orderSect: String
    let orderBranch: String
    let orderList: [OrderList]

    enum CodingKeys: String, CodingKey {
        case memberSeq = "MEMBER_SEQ"
        case orderSect = "ORDER_SECT"
        case orderBranch = "ORDER_BRANCH"
        case orderList = "ORDER_LIST"
    }
}

// MARK: - OrderList
struct OrderList: Codable {
    let prdSeq: Int
    let orderCnt: Int
    let orderShot: Int
    let orderType: String
    let orderSize: String

    enum CodingKeys: String, CodingKey {
        case prdSeq = "PRD_SEQ"
        case orderCnt = "ORDER_CNT"
        case orderShot = "ORDER_SHOT"
        case orderType = "ORDER_TYPE"
        case orderSize = "ORDER_SIZE"
    }
}

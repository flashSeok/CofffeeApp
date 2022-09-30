//
//  Product.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

//MARK: - 데이터 모델
// 실제 API에서 받게 되는 정보
// MARK: - Welcome
struct ApiData: Codable {
    let resHead: ResHeadProduct
    var resBodyProduct: ResBodyProduct

    enum CodingKeys: String, CodingKey {
        case resHead = "RES_HEAD"
        case resBodyProduct = "RES_BODY"
    }
}

// MARK: - ResBody
struct ResBodyProduct: Codable {
    var prdList: [PrdList]

    enum CodingKeys: String, CodingKey {
        case prdList = "PRD_LIST"
    }
}

// MARK: - PrdList
struct PrdList: Codable {
    let prdCateSub: String?
    let prdNameKr: String?
    let inputID: InputID?
    let prdCnt: String?
    let prdSeq: Int?
    var prdPrice: String?
    let dbStatus: DBStatus?
    let prdNameEn: String?
    let prdCate: PrdCate?
    let prdNotice: String?
    let prdImg: String?
    let prdType: String?

    enum CodingKeys: String, CodingKey {
        case prdCateSub = "PRD_CATE_SUB"
        case prdNameKr = "PRD_NAME_KR"
        case inputID = "INPUT_ID"
        case prdCnt = "PRD_CNT"
        case prdSeq = "PRD_SEQ"
        case prdPrice = "PRD_PRICE"
        case dbStatus = "DB_STATUS"
        case prdNameEn = "PRD_NAME_EN"
        case prdCate = "PRD_CATE"
        case prdNotice = "PRD_NOTICE"
        case prdImg = "PRD_IMG"
        case prdType = "PRD_TYPE"
    }
}

// MARK: - ResHead
enum DBStatus: String, Codable {
    case a = "A"
}

enum InputID: String, Codable {
    case jymin = "jymin"
}

enum PrdCate: String, Codable {
    case drink = "DRINK"
}

// MARK: - ResHead
struct ResHeadProduct: Codable {
    let retnMent, retnCode: String

    enum CodingKeys: String, CodingKey {
        case retnMent = "RETN_MENT"
        case retnCode = "RETN_CODE"
    }
}

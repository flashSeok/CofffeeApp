//
//  Commons.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

final class Commons {
    
    // MARK: - getDecimalPrice()
    func getDecimalPrice(price: String?) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let price = price else { return "" }
        
        let priceInt = Int(price)!
        
        guard let prdPriceString = numberFormatter.string(from: NSNumber(value: priceInt)) else { return "값 오류"}
        return String(prdPriceString) + "원"
    }

}


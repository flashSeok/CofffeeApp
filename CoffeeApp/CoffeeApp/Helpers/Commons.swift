//
//  Commons.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

final class Commons {
    
    func getDecimalPrice(price: Int) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let prdPriceString = numberFormatter.string(from: NSNumber(value: price)) else { return "값 오류"}
        return String(prdPriceString) + "원"
    }

}


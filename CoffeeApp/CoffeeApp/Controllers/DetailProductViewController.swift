//
//  DetailProductViewController.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

final class DetailProductViewController: UIViewController {

    private let detailProductView = DetailProductView()
    
    var selectedProduct: Product?
    
    override func loadView() {
        view = detailProductView
//        view.backgroundColor = .gray
        print("넘어온 데이터")
        print(selectedProduct)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    // 멤버를 뷰에 전달⭐️ (뷰에서 알아서 화면 셋팅)
    private func setupData() {
        print(#function)
        detailProductView.selectedProduct = selectedProduct
    }
}


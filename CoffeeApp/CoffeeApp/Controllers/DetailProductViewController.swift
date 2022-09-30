//
//  DetailProductViewController.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

final class DetailProductViewController: UIViewController {

    private let detailProductView = DetailProductView()
        
    var selectedProduct: PrdList?
    
    let commons = Commons()
  
    
    // 뷰 교체(viewDidLoad보다 먼저 실행됨)
    override func loadView() {
        view = detailProductView
//        view.backgroundColor = .gray
        print("넘어온 데이터")
        dump(selectedProduct)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setUpAddTarget()
    }
    
    func setUpAddTarget() {
        print(#function)
        detailProductView.orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }
    
    
    
    // MARK: - setupData()
    // 멤버를 뷰에 전달⭐️ (뷰에서 알아서 화면 셋팅)
    private func setupData() {
        print(#function)
        detailProductView.selectedProduct = selectedProduct
        detailProductView.selectedProduct?.prdPrice = commons.getDecimalPrice(price: selectedProduct?.prdPrice)
        
    }
    
    // MARK: - orderButtonTapped()
    @objc func orderButtonTapped() {
        print(#function)
        print("주문하기 버튼 클릭!")
        let orderView = OrderViewController()
        orderView.orderProduct = detailProductView.selectedProduct
                
//        orderView.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(orderView, animated: true)
        self.present(orderView, animated: true)
    }
}


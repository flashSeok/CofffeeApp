//
//  OrderViewController.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/22.
//

import UIKit
import SnapKit

final class OrderViewController: UIViewController {

    private let orderView = OrderView()

    var orderProduct: PrdList?
    
    var orderType: String? = nil
    var orderSize: String = "TALL"
    var orderHereOrTogo: String = ""
    var espressoShotTimes: Int = 1
    var orderQty: Int = 1
    
    var orderList: [OrderList] = []

    
    
    
    // MARK: - loadView()
    override func loadView() {
        // super.loadView() 필요없음
        view = orderView
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        setupNaviBar()
        setupData()
        setupClickSizeEvent()
        tappedTallSize()
        setUpAddTarget()
        
        orderView.espressoShotTimesLabel.text = "1"
        orderView.qtyOrderLabel.text = "1"
        
        orderView.espressoShotMinusButton.isEnabled = false
        orderView.qtyOrderMinusButton.isEnabled = false

    }
    
    // MARK: - setUpNaviBar()
    func setupNaviBar() {
        title = "주문하기"
        
        // 네비게이션바 설정관련
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = .blue
        
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - setupData()
    func setupData() {
        orderView.orderProduct = orderProduct
    }
    
    // MARK: - setUpAddTarget()
    func setUpAddTarget() {
        print(#function)
        orderView.choiceHereButton.addTarget(self, action: #selector(tappedHereButton), for: .touchUpInside)
        orderView.choiceTakeOutButton.addTarget(self, action: #selector(tappedTakeOutButton), for: .touchUpInside)
        orderView.espressoShotMinusButton.addTarget(self, action: #selector(tappedEspressoShotMinusButton), for: .touchUpInside)
        orderView.espressoShotPlusButton.addTarget(self, action: #selector(tappedEspressoShotPlusButton), for: .touchUpInside)
        orderView.hotButton.addTarget(self, action: #selector(tappedHotButton), for: .touchUpInside)
        orderView.iceButton.addTarget(self, action: #selector(tappedIceButton), for: .touchUpInside)
        orderView.qtyOrderMinusButton.addTarget(self, action: #selector(tappedQtyMinusButton), for: .touchUpInside)
        orderView.qtyOrderPlusButton.addTarget(self, action: #selector(tappedQtyPlusButton), for: .touchUpInside)
        orderView.orderButton.addTarget(self, action: #selector(tappedOrderButton), for: .touchUpInside)
        
        
    }
    
    @objc func tappedHereButton() {
        self.orderHereOrTogo = "IN"
        
        orderView.choiceHereButton.setTitleColor(.black, for: .normal)
        orderView.choiceHereButton.layer.borderWidth = 2.0
        orderView.choiceHereButton.layer.borderColor = UIColor(rgb: 0x00A862).cgColor
        
        orderView.choiceTakeOutButton.setTitleColor(UIColor(rgb: 0xA4A4A4), for: .normal)
        orderView.choiceTakeOutButton.layer.borderWidth = 1.0
        orderView.choiceTakeOutButton.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
    }
    
    @objc func tappedTakeOutButton() {
        self.orderHereOrTogo = "OUT"
        
        orderView.choiceTakeOutButton.setTitleColor(.black, for: .normal)
        orderView.choiceTakeOutButton.layer.borderWidth = 2.0
        orderView.choiceTakeOutButton.layer.borderColor = UIColor(rgb: 0x00A862).cgColor
        
        orderView.choiceHereButton.setTitleColor(UIColor(rgb: 0xA4A4A4), for: .normal)
        orderView.choiceHereButton.layer.borderWidth = 1.0
        orderView.choiceHereButton.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        
    }
    
    func checkEspressoShotTimes() {
        if orderView.espressoShotTimesLabel.text == "1" {
            orderView.espressoShotMinusButton.isEnabled = false
        } else {
            orderView.espressoShotMinusButton.isEnabled = true
        }
    }
    
    @objc func tappedEspressoShotMinusButton() {
        print(#function)
      
        self.espressoShotTimes -= 1
    
        orderView.espressoShotTimesLabel.text = String(espressoShotTimes)
        checkEspressoShotTimes()

    }
    
    @objc func tappedEspressoShotPlusButton() {
        print(#function)
  
        self.espressoShotTimes += 1
        
        orderView.espressoShotTimesLabel.text = String(espressoShotTimes)
        checkEspressoShotTimes()
    }

    @objc func tappedHotButton() {
        self.orderType = "HOT"
        
        orderView.hotButton.backgroundColor = UIColor(rgb: 0xC8443A)
        orderView.hotButton.setTitleColor(.white, for: .normal)
        
        orderView.iceButton.backgroundColor = UIColor.clear
        orderView.iceButton.setTitleColor(UIColor(rgb: 0xA4A4A4), for: .normal)
        
    }
    
    @objc func tappedIceButton() {
        self.orderType = "ICE"
        
        orderView.iceButton.backgroundColor = UIColor(rgb: 0x0076FF)
        orderView.iceButton.setTitleColor(.white, for: .normal)
        
        orderView.hotButton.backgroundColor = UIColor.clear
        orderView.hotButton.setTitleColor(UIColor(rgb: 0xA4A4A4), for: .normal)
    }
    
    func checkOrderQty() {
        if orderView.qtyOrderLabel.text == "1" {
            orderView.qtyOrderMinusButton.isEnabled = false
        } else {
            orderView.qtyOrderMinusButton.isEnabled = true
        }
    }
    
    @objc func tappedQtyMinusButton() {
        print(#function)

        self.orderQty -= 1
        orderView.qtyOrderLabel.text = String(orderQty)
        checkOrderQty()
    }
    
    @objc func tappedQtyPlusButton() {
        print(#function)
        
        self.orderQty += 1
        orderView.qtyOrderLabel.text = String(orderQty)
        checkOrderQty()
    }
    
    @objc func tappedOrderButton() {
        orderNetwork()
    }
    
    func orderNetwork() {
        print(#function)

        let memeberSeq = UserDefaults.standard.object(forKey: "memberSeq")
        
        let orderSect = self.orderHereOrTogo
        
        let prdSeq = orderProduct!.prdSeq!
        let orderCnt = self.orderQty
        let orderShot = self.espressoShotTimes
        guard let orderType = self.orderType else { return }
        let orderSize = self.orderSize
        
        self.orderList = []
        
        let order = OrderList(prdSeq: prdSeq, orderCnt: orderCnt, orderShot: orderShot, orderType: orderType, orderSize: orderSize)
        orderList.append(order)
       
        
        let reqBody = ReqBody(memberSeq: memeberSeq as! Int, orderSect: orderSect, orderBranch: "부평점", orderList: orderList)
        
        let body = OrderInfo(reqBody: reqBody)
        

        
        // 서버통신 시작
        let orderNetworkManager = OrderNetworkManager.shared
        
        orderNetworkManager.fetchOrderResult(body: body) { result in
            
            switch result {
            case .success(let orderResultData):
                print("주문 성공")
                print("orderList : \(orderResultData)")
                
                guard let retnCode = orderResultData.resHead.retnCode else { return }
                
                switch retnCode {
                case "200": print("성공")
                case "400": print("필수값 누락")
                case "500": print("재고 없음")
                case "999": print("시스템 오류")
                default:
                    break
                }
                
                
            case .failure(let error):
                print("주문 실패")
                print("error : \(error.localizedDescription)")
                
                return
            }
            
        
        }
        
        
        
        
//        print("orderList")
//        print(orderList)
//
//        print("reqBody")
//        print(reqBody)
//        print("--------")
        

    }
    
    
    
    func setupClickSizeEvent() {
        orderView.tallUIView.tag = 1
        orderView.grandeUIView.tag = 2
        orderView.ventiUIView.tag = 3
        
        //클릭 가능하도록 설정
        self.orderView.tallUIView.isUserInteractionEnabled = true
        self.orderView.grandeUIView.isUserInteractionEnabled = true
        self.orderView.ventiUIView.isUserInteractionEnabled = true
      
        
        //제스쳐 추가
        self.orderView.tallUIView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        self.orderView.grandeUIView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        self.orderView.ventiUIView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
    }
    
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        print("\(sender.view!.tag) 클릭됨")
        
        guard let tag = sender.view?.tag else { return }
        
        switch tag {
        case 1: tappedTallSize()
            print(orderProduct!)
        case 2: tappedGrandeSize()
                print(orderProduct!)
        case 3: tappedVentiSize()
                print(orderProduct!)
        default:
            break
        }
    }
    
    func tappedTallSize() {
        self.orderSize = "TALL"
        
        orderView.tallLabel.textColor = .black
        orderView.tallUIView.layer.borderColor = UIColor(rgb: 0x00A862).cgColor
        orderView.tallUIView.layer.borderWidth = 2.0
        
        orderView.grandeLabel.textColor = UIColor(rgb: 0xA4A4A4)
        orderView.grandeUIView.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        orderView.grandeUIView.layer.borderWidth = 1.0
        
        orderView.ventiLabel.textColor = UIColor(rgb: 0xA4A4A4)
        orderView.ventiUIView.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        orderView.ventiUIView.layer.borderWidth = 1.0
        
    }
    
    func tappedGrandeSize() {
        self.orderSize = "GRANDE"
        
        orderView.grandeLabel.textColor = .black
        orderView.grandeUIView.layer.borderColor = UIColor(rgb: 0x00A862).cgColor
        orderView.grandeUIView.layer.borderWidth = 2.0
        
        orderView.tallLabel.textColor = UIColor(rgb: 0xA4A4A4)
        orderView.tallUIView.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        orderView.tallUIView.layer.borderWidth = 1.0
        
        orderView.ventiLabel.textColor = UIColor(rgb: 0xA4A4A4)
        orderView.ventiUIView.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        orderView.ventiUIView.layer.borderWidth = 1.0
        
    }
    
    func tappedVentiSize() {
        self.orderSize = "VENTI"
        
        orderView.ventiLabel.textColor = .black
        orderView.ventiUIView.layer.borderColor = UIColor(rgb: 0x00A862).cgColor
        orderView.ventiUIView.layer.borderWidth = 2.0
        
        orderView.grandeLabel.textColor = UIColor(rgb: 0xA4A4A4)
        orderView.grandeUIView.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        orderView.grandeUIView.layer.borderWidth = 1.0
        
        orderView.tallLabel.textColor = UIColor(rgb: 0xA4A4A4)
        orderView.tallUIView.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        orderView.tallUIView.layer.borderWidth = 1.0
    }

}





























#if DEBUG

import SwiftUI

struct ViewControllerPresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        OrderViewController()
    }
}


struct ViewControllerPrepresentable_PreviewProvider : PreviewProvider {
    static var previews: some View {
        ViewControllerPresentable()
            .previewDevice("iPhone 13 Pro")
            .previewDisplayName("iPhone 13 Pro")
            .ignoresSafeArea()
    }
}

#endif

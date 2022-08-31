//
//  DetailProductView.swift
//  CoffeeAppCode
//
//  Created by 김현석 on 2022/08/27.
//

import UIKit
import UniformTypeIdentifiers

class DetailProductView: UIView {
    
    let commons = Commons()
    var imageUrl: String?

    //MARK: - 멤버 저장속성 구현
    // 멤버 데이터가 바뀌면 ===> didSet(속성감시자) 실행
    // 속성감시자도 (저장 속성을 관찰하는) 어쨌든 자체는 메서드임
    var selectedProduct: Product? {
        didSet {
            guard var selectedProduct = selectedProduct else {
                // 멤버가 없으면 (즉, 새로운 멤버를 추가할때의 상황)
                // 멤버가 없으면 버튼을 "SAVE"라고 셋팅
//                saveButton.setTitle("SAVE", for: .normal)
                // 멤버가 없으면, 타입 저장 속성의 현재 숫자 가져오기
//                productNameKR.text = "\(selectedProduct?.prdNameKr)"
                return
            }
            // 멤버가 있으면
        //    mainImageView.image = selectedProduct.prdImg
            productNameKR.text = selectedProduct.prdNameKr
            productNameEN.text = selectedProduct.prdNameEn
            productNotice.text = selectedProduct.prdNotice
            productPrice.text = commons.getDecimalPrice(price: selectedProduct.prdPrice)
            
            loadImage()
        
        }
    }


    
    // MARK: - 컨텐츠 생성
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        
        return imageView
    }()
        
    let productNameKR: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.backgroundColor = .lightGray
        
        return label
    }()
    
    let productNameEN: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.backgroundColor = .lightGray
        
        return label
    }()
    
    let productNotice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.backgroundColor = .lightGray
        label.numberOfLines = 3
        label.lineBreakStrategy = .hangulWordPriority
        
        return label
    }()
    
    let productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.backgroundColor = .lightGray
        
        return label
    }()
    
    
    
    // MARK: - 생성자 세팅
    override init(frame: CGRect) {
        print(#function)
        super.init(frame: frame)
        backgroundColor = .white
        setAddView()
        loadImage()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - 오토레이아웃 셋팅
    
    // 오토레이아웃 업데이트
    override func updateConstraints() {
        print(#function)
        
        setConstraints()
        super.updateConstraints()
        loadImage()
    }
    
    func setAddView() {
        print(#function)
        
        self.addSubview(mainImageView)
        self.addSubview(productNameKR)
        self.addSubview(productNameEN)
        self.addSubview(productNotice)
        self.addSubview(productPrice)
    }
    
    func setConstraints() {
        print(#function)
        
        setMainImageViewConstraints()
        setProductNameKrLabelConstraints()
        setProductNameEnLabelConstraints()
        setProductNoticeLabelConstraints()
        setProductPriceLabelConstraints()
    }
    
    func setMainImageViewConstraints() {
        print(#function)
        
        mainImageView.snp.makeConstraints { make in
            
            make.width.height.equalTo(frame.width)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            
        }
    }
    
    func setProductNameKrLabelConstraints() {
        print(#function)
        
        productNameKR.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(40)
            make.top.equalTo(self.mainImageView.snp.bottom).offset(10)
           
        }
    }
    
    func setProductNameEnLabelConstraints() {
        print(#function)
        
        productNameEN.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(productNameKR.snp.bottom).offset(10)
          
        }
    }
    
    func setProductNoticeLabelConstraints() {
        print(#function)
        
        productNotice.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(productNameEN.snp.bottom).offset(15)
        }
    }
    
    func setProductPriceLabelConstraints() {
        print(#function)
        
        productPrice.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(productNotice.snp.bottom).offset(20)
        }
    }
    
    private func loadImage() {
        print(#function)
//        guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
        guard let urlString = selectedProduct?.prdImg, let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async {
        
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
//                self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 2
//                self.mainImageView.clipsToBounds = true
            }
        }
    }
    

    
    
    
}



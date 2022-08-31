//
//  MainTableViewCell.swift
//  CoffeeAppCode
//
//  Created by 김현석 on 2022/08/26.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {

    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    var prdNotice: String?
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow

        return imageView
    }()
    
    let prdNameKR: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = .lightGray
        
        return label
    }()
    
    let prdNameEn: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = .lightGray
        label.textColor = UIColor.darkGray
        
        return label
    }()
    
    let prdPrice: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var stackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 6

        return sv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setAddSubView()
        setConstraints()
    }

    func setAddSubView() {
        self.addSubview(mainImageView)
        self.addSubview(prdNameKR)
        self.addSubview(prdNameEn)
        self.addSubview(prdPrice)

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 오토레이아웃 정하는 정확한 시점
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
        
    }

    
    // MARK: - Constraints 설정
    
    func setConstraints() {
        setMainImageViewConstraints()
        setProductNameKrLabelConstraints()
        setProductNameEnLabelConstraints()
        setProductPriceLabelConstraints()
    }

    func setMainImageViewConstraints() {

        
        mainImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerY.equalToSuperview()
            make.left.equalTo(self).offset(20)
        }

    }
    
    func setProductNameKrLabelConstraints() {
        prdNameKR.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.top).offset(15)
            make.left.equalTo(mainImageView.snp.right).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }
    }
                                           
    func setProductNameEnLabelConstraints() {
        prdNameEn.snp.makeConstraints { make in
            make.top.equalTo(prdNameKR.snp.bottom).offset(6)
            make.left.equalTo(mainImageView.snp.right).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }
       
    }
    
    func setProductPriceLabelConstraints() {
        prdPrice.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.bottom).offset(-15)
            make.left.equalTo(mainImageView.snp.right).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }

    }
    
    private func loadImage() {
        print(#function)
        guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async {
        
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
                self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 2
                self.mainImageView.clipsToBounds = true
            }
        }
    }
    
    


}

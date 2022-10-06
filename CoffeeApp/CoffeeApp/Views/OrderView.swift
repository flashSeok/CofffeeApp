//
//  OrderView.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/22.
//

import UIKit
import SnapKit

class OrderView: UIView {
    
    var orderProduct: PrdList? {
        didSet {
            guard let orderProduct = orderProduct else {
                print("주문할 정보를 못불러왔음")
                return
            }

            print("orderProduct.prdNameKr : \(orderProduct.prdNameKr)")
            orderProductNameLabel.text = orderProduct.prdNameKr
        }
    }
    
    
    // MARK: - UI 생성
    let orderProductNameLabel: UILabel = {
        let label = UILabel()
        label.text = "아이스 아메리카노"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    let safeNoticeLabel: UILabel = {
        let label = BasePaddingLabel()
        label.backgroundColor = UIColor(rgb: 0xF3FAF8)
        label.text = "환경을 위해 일회용컵 사용 줄이기에 동참해주세요"
        label.textColor = UIColor(rgb: 0x018849)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Hot Ice
    let hotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("HOT", for: .normal)
        button.setTitleColor(UIColor(rgb: 0xA4A4A4), for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.isEnabled = true
        
        return button
    }()
    
    let iceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ICE", for: .normal)
        button.setTitleColor(UIColor(rgb: 0xA4A4A4), for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.isEnabled = true
        
        return button
    }()
    
    lazy var choiceHotIceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hotButton, iceButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()
        
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "사이즈"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        
        return label
    }()
    
    // MARK: - Tall 사이즈
    lazy var tallUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addSubview(tallImageView)
        view.addSubview(tallLabel)
        view.addSubview(tallSizeLabel)

        return view
    }()
    
    lazy var tallImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cup.and.saucer")
        
        return imageView
    }()
    
    lazy var tallLabel: UILabel = {
        let label = UILabel()
        label.text = "Tall"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(rgb: 0xA4A4A4)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var tallSizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(rgb: 0xA4A4A4)
        label.text = "355ml"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var tallStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tallImageView, tallLabel, tallSizeLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()
    
    
    // MARK: - Grande 사이즈
    lazy var grandeUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addSubview(grandeImageView)
        view.addSubview(grandeLabel)
        view.addSubview(grandeSizeLabel)

        return view
    }()
    
    lazy var grandeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cup.and.saucer")
        
        return imageView
    }()
    
    lazy var grandeLabel: UILabel = {
        let label = UILabel()
        label.text = "Grande"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(rgb: 0xA4A4A4)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var grandeSizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(rgb: 0xA4A4A4)
        label.text = "473ml"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var grandeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [grandeImageView, grandeLabel, grandeSizeLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.layer.borderWidth = 1.0

        return stackView
    }()
    
   
    // MARK: - Venti 사이즈
    lazy var ventiUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addSubview(ventiImageView)
        view.addSubview(ventiLabel)
        view.addSubview(ventiSizeLabel)

        return view
    }()
    
    lazy var ventiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cup.and.saucer")
        
        return imageView
    }()
    
    lazy var ventiLabel: UILabel = {
        let label = UILabel()
        label.text = "Venti"
        label.textColor = UIColor(rgb: 0xA4A4A4)
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var ventiSizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(rgb: 0xA4A4A4)
        label.text = "591ml"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var ventiStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ventiImageView, ventiLabel, ventiSizeLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
//        stackView.layer.borderColor = UIColor.orange.cgColor
        stackView.layer.borderWidth = 1.0

        return stackView
    }()
    
    
    
    lazy var sizeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tallUIView, grandeUIView, ventiUIView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()

    
    // MARK: - 컵 선택
    let cupChoiceLabel: UILabel = {
        let label = UILabel()
        label.text = "컵 선택"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        
        return label
    }()
    
    let choiceHereButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("매장", for: .normal)
        button.setTitleColor(UIColor(rgb: 0xA4A4A4), for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.isEnabled = true
        
        
        return button
    }()
    
    let choiceTakeOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("포장", for: .normal)
        button.setTitleColor(UIColor(rgb: 0xA4A4A4), for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgb: 0xA4A4A4).cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.isEnabled = true
        
        return button
    }()
    
    lazy var choiceCupStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [choiceHereButton, choiceTakeOutButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 60

        return stackView
    }()

    
    // MARK: - 퍼스널옵션
    let choicePersonalOption: UILabel = {
        let label = UILabel()
        label.text = "퍼스널 옵션"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        
        return label
    }()
    
    let espressoShotLabel: UILabel = {
        let label = UILabel()
        label.text = "에스프레소 샷"
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    let espressoShotMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)

        return button
    }()
    
    let espressoShotTimesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment  = .center

        return label
    }()
                                
    let espressoShotPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)

        return button
    }()
    
    lazy var espressoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [espressoShotMinusButton, espressoShotTimesLabel, espressoShotPlusButton ])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
//        stackView.spacing = 1
        stackView.layer.borderColor = UIColor.red.cgColor
        stackView.layer.borderWidth = 2.0

        return stackView
    }()
    
    lazy var personalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [espressoShotLabel, espressoStackView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 120
        
        return stackView
    }()
                                
    
    //
    let qtyOrderMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)

        return button
    }()
    
    let qtyOrderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "100"
        label.textAlignment  = .center

        return label
    }()
                                
    let qtyOrderPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)

        return button
    }()
    
    lazy var qtyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [qtyOrderMinusButton, qtyOrderLabel, qtyOrderPlusButton ])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.layer.borderColor = UIColor.red.cgColor
        stackView.layer.borderWidth = 2.0

        return stackView
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "1,000원"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [qtyStackView, totalPriceLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layer.borderColor = UIColor.green.cgColor
        stackView.layer.borderWidth = 2.0
        stackView.spacing = 120
        
        return stackView
    }()
    
    let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("주문하기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(rgb: 0x00A862)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.isEnabled = true
        
        return button
    }()
    
    
    
    // MARK: - init(frame: CGRect)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setAddSubView()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setAddSubView()
    func setAddSubView() {
        self.addSubview(orderProductNameLabel)
        self.addSubview(safeNoticeLabel)
        
        self.addSubview(hotButton)
        self.addSubview(iceButton)
        self.addSubview(choiceHotIceStackView)
        
        self.addSubview(sizeLabel)
        
        self.addSubview(tallUIView)
        self.addSubview(grandeUIView)
        self.addSubview(ventiUIView)
        
        self.addSubview(sizeStackView)
        
        self.addSubview(cupChoiceLabel)
        self.addSubview(choiceHereButton)
        self.addSubview(choiceTakeOutButton)
        
        self.addSubview(choiceCupStackView)
        
        
        self.addSubview(choicePersonalOption)
        self.addSubview(espressoShotLabel)
        self.addSubview(espressoShotMinusButton)
        self.addSubview(espressoShotTimesLabel)
        self.addSubview(espressoShotPlusButton)
        
        self.addSubview(espressoStackView)
        self.addSubview(personalStackView)
        
        self.addSubview(qtyOrderMinusButton)
        self.addSubview(qtyOrderLabel)
        self.addSubview(qtyOrderPlusButton)
        self.addSubview(qtyStackView)
        self.addSubview(totalStackView)
        
        self.addSubview(orderButton)
        
    }
    
    
    
    // MARK: - setConstraints()
    func setContraints() {
        setOrderProductNameLabelConstraints()
        setSafeNoticeLabelConstraints()
        
        setChoiceHotIceStackViewConstraints()
        
        //사이즈
        setSizeLableConstraints()
        
        setTallUIViewConstraints()
        setTallImageViewConstraints()
        setTallLabelConstraints()
        setTallSizeLabelConstraints()
                
        setGrandeUIViewConstraints()
        setGrandeImageViewConstraints()
        setGrandeLabelConstraints()
        setGrandeSizeLabelConstraints()
        
        setVentiUIViewConstraints()
        setVentiImageViewConstraints()
        setVentiLabelConstraints()
        setVentiSizeLabelConstraints()
        
        setSizeStackViewConstraints()
        
        // 컵선택
        setCupChoiceLabelConstraints()

        setCupChoiceStackViewConstraints()
        
        // 퍼스널 옵션
        setChoicePersonalOptionConstraints()

        setEspressoStackViewConstraints()
        setPersonalStackViewConstraints()
        
        setTotalStackViewConstraints()
        
        setOrderButtonConstraints()
    }
    
    func setOrderProductNameLabelConstraints() {
        orderProductNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func setSafeNoticeLabelConstraints() {
        safeNoticeLabel.snp.makeConstraints { make in
            make.top.equalTo(orderProductNameLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func setChoiceHotIceStackViewConstraints() {
        choiceHotIceStackView.snp.makeConstraints { make in
            make.top.equalTo(safeNoticeLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    
    func setSizeLableConstraints() {
        sizeLabel.snp.makeConstraints { make in
            make.top.equalTo(choiceHotIceStackView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    

    // tall
    func setTallUIViewConstraints() {
        tallUIView.snp.makeConstraints { make in
//            make.width.equalTo(110)
            make.height.equalTo(tallUIView.snp.width).multipliedBy(1.2)
            make.top.equalTo(sizeLabel.snp.bottom).offset(20)

        }
    }
    
    func setTallImageViewConstraints() {
        tallImageView.snp.makeConstraints { make in
            make.top.equalTo(tallUIView.snp.top).offset(30)
            make.size.width.height.equalTo(30)
            make.centerX.equalTo(tallUIView.snp.centerX)
        }
    }
    
    func setTallLabelConstraints() {
        tallLabel.snp.makeConstraints { make in
            make.top.equalTo(tallImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setTallSizeLabelConstraints() {
        tallSizeLabel.snp.makeConstraints { make in
            make.top.equalTo(tallLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    // Grande
    func setGrandeUIViewConstraints() {
        grandeUIView.snp.makeConstraints { make in
//            make.width.equalTo(110)
            make.height.equalTo(tallUIView.snp.width).multipliedBy(1.2)
            make.top.equalTo(sizeLabel.snp.bottom).offset(20)
        }
    }
    
    func setGrandeImageViewConstraints() {
        grandeImageView.snp.makeConstraints { make in
            make.top.equalTo(grandeUIView.snp.centerY).offset(-42)
            make.size.width.height.equalTo(40)
            make.centerX.equalTo(grandeUIView.snp.centerX)

        }
    }
    
    func setGrandeLabelConstraints() {
        grandeLabel.snp.makeConstraints { make in
            make.top.equalTo(grandeImageView.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setGrandeSizeLabelConstraints() {
        grandeSizeLabel.snp.makeConstraints { make in
            make.top.equalTo(grandeLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
   
    
    // Venti
    func setVentiUIViewConstraints() {
        ventiUIView.snp.makeConstraints { make in
//            make.width.equalTo(110)
            make.height.equalTo(grandeUIView.snp.width).multipliedBy(1.2)
            make.top.equalTo(sizeLabel.snp.bottom).offset(20)
        }
    }
    
    func setVentiImageViewConstraints() {
        ventiImageView.snp.makeConstraints { make in
            make.top.equalTo(ventiUIView.snp.centerY).offset(-50)
            make.size.width.height.equalTo(50)
            make.centerX.equalTo(ventiUIView.snp.centerX)
        }
    }
    
    func setVentiLabelConstraints() {
        ventiLabel.snp.makeConstraints { make in
            make.top.equalTo(ventiImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setVentiSizeLabelConstraints() {
        ventiSizeLabel.snp.makeConstraints { make in
            make.top.equalTo(ventiLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }


    func setSizeStackViewConstraints() {
        sizeStackView.snp.makeConstraints { make in
            make.top.equalTo(sizeLabel.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }

    // 컵 선택
    func setCupChoiceLabelConstraints() {
        cupChoiceLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeStackView.snp.bottom).offset(40)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    func setCupChoiceStackViewConstraints() {
        choiceCupStackView.snp.makeConstraints { make in
            make.top.equalTo(cupChoiceLabel.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)

        }
    }
    
    // 퍼스널 옵션
    func setChoicePersonalOptionConstraints() {
        choicePersonalOption.snp.makeConstraints { make in
            make.top.equalTo(choiceCupStackView.snp.bottom).offset(40)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
        
    func setEspressoStackViewConstraints() {
        espressoStackView.snp.makeConstraints { make in
            make.top.equalTo(choicePersonalOption.snp.bottom).offset(20)
            
        }
    }
    
    func setPersonalStackViewConstraints() {
        personalStackView.snp.makeConstraints { make in
            make.top.equalTo(choicePersonalOption.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    func setTotalStackViewConstraints() {
        totalStackView.snp.makeConstraints { make in
            make.top.equalTo(personalStackView.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
    
    func setOrderButtonConstraints() {
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(totalStackView.snp.bottom).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(totalStackView.snp.width).dividedBy(2)
            make.height.equalTo(totalStackView.snp.width).dividedBy(6)
        }
    }
    
    
    
}

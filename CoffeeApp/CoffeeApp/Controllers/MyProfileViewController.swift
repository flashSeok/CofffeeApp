//
//  MyProfileViewController.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

class MyProfileViewController: UIViewController {

    var loginUser: LoginInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(rgb: 0xffd448)
        test()
    }
    
    func test() {
        guard let loginUserInfo = loginUser else { return }
        print(loginUserInfo.memberName ?? "")
        print(loginUserInfo.memberNick ?? "")
        print(loginUserInfo.memberSeq ?? "")
        print(loginUserInfo.ment ?? "")
    }

}



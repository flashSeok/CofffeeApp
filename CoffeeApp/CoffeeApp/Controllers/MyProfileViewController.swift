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

//        view.backgroundColor = #colorLiteral(red: 1, green: 0.8557364941, blue: 0.349532187, alpha: 1) // ffd448
        view.backgroundColor = UIColor(rgb: 0xffd448)
        test()
    }
    
    func test() {
        print(loginUser?.memberName)
        print(loginUser?.memberNick)
        print(loginUser?.memberSeq)
        print(loginUser?.ment)
    }

}



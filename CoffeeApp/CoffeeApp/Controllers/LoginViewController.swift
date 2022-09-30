//
//  LoginViewController.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    lazy var loginInfoView: LoginInfo? = nil

    override func loadView() {
        // super.loadView() 필요없음
        view = loginView
    }
    
    override func viewDidLoad() {
        print(#function)
        
        super.viewDidLoad()
        setUpAddTarget()
        
    }
    
    func setUpAddTarget() {
        print(#function)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        print(#function)
        
        loginNetwork()
    }
    
    
    func loginNetwork() {
        print(#function)
        guard let id = loginView.emailTextField.text else { return }
        guard let pw = loginView.passwordTextField.text else { return }
        
        // 네트워크 매니저 (싱글톤)
        let networkManager = LoginNetworkManager.shared
        
        print("1")
        // 네트워킹의 시작
        networkManager.fetchLogginResult(id: id, pw: pw) { result in
            print(#function)
            print("6")
            print("result : \(result)")
            print("id : \(id)")
            print("pw : \(pw)")
            
            switch result {
            case .success(let loginInfo):
                print("loginInfo : \(loginInfo)")
                self.loginInfoView = loginInfo
                     
                if let _ = loginInfo.ment {
                    DispatchQueue.main.async {
                        self.makeTabBar()
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "로그인 실패", message: "로그인 정보를 다시 확인해주세요.", preferredStyle: UIAlertController.Style.alert)
                        let cancelAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                return
                
            }
        }
    }
    
    func makeTabBar() {
        print(#function)
        // 탭바컨트롤러의 생성
        let tabBarVC = UITabBarController()
        
        // 첫번째 화면은 네비게이션컨트롤러로 만들기 (기본루트뷰 설정)
        let vc1 = UINavigationController(rootViewController: MainTableViewCellController())
        let vc2 = MyProfileViewController()
        
        
        // 탭바 이름들 설정
        vc1.title = "메뉴"
        vc2.title = "내 정보"
        
        
        // 탭바로 사용하기 위한 뷰 컨트롤러들 설정
        tabBarVC.setViewControllers([vc1, vc2], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.tabBar.backgroundColor = .yellow
        
        // 탭바 이미지 설정 (이미지는 애플이 제공하는 것으로 사용)
        guard let items = tabBarVC.tabBar.items else { return }
        
        items[0].image = UIImage(systemName: "menucard")
        items[1].image = UIImage(systemName: "person")
        
        print("탭바생성 후")
        print("loginInfoView : \(loginInfoView)")
        vc2.loginUser = loginInfoView
        
        // 프리젠트로 탭바를 띄우기
        self.present(tabBarVC, animated: true)
        
       
    }

}


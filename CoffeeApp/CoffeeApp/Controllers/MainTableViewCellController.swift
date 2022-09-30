//
//  MainTableViewCellController.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/11.
//

import UIKit

final class MainTableViewCellController: UIViewController {
    
    var isLoggedIn = false
    
    // 🍏 서치 컨트롤러 생성 ===> 네비게이션 아이템에 할당
    let searchController = UISearchController()
    let commons = Commons()
    
    // 🍎 서치 Results컨트롤러 ⭐️
    //let search = UISearchController(searchResultsController: <#T##UIViewController?#>)
    
    //    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    
    let mainTableView = UITableView()
    
    // 네트워크 매니저 (싱글톤)
    var networkManager = ProductNetworkManager.shared
    
    // (상품 데이터를 다루기 위함) 빈배열로 시작
    var productArrays: [PrdList] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // ⭐️ 로그인이 되어있지 않다면 로그인화면 띄우기
        // 로그인화면 -> 메인 화면으로 가면 로그인화면이 계속 힙메모리에 올라가져있어서 효율적이지 못함.
        // 앱을 띄우면 바로 메인뷰로 이동시키고 로그인 안되어있으면 그때 로그인 화면으로 이동.
        //        if !isLoggedIn {
        //            let vc = LoginViewController()
        //            vc.modalPresentationStyle = .fullScreen
        //
        //            // 내비게이션컨트롤러를 이용해야될 때 아래 코드 사용
        //            self.navigationController?.pushViewController(vc, animated: false) // present
        //
        //        }
        
        setupNaviBar()
        setupTableView()
        setupDatas()
        setUpTableViewConstraints()
        setUpSearchBar()
    }
    
    func setupNaviBar() {
        title = "메뉴"
        
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
    
    func setUpSearchBar() {
        self.title = "메뉴 검색"
        navigationItem.searchController = searchController
        
        // 1) (단순) 서치바의 사용
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
    }
    
    
    func setupTableView() {
        // 델리게이트 패턴의 대리자 설정
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        // 셀의 높이 설정
        mainTableView.rowHeight = 120
        
        // 스크롤시 키보드 내리기
        mainTableView.keyboardDismissMode = .onDrag
        
        // 셀의 등록⭐️ (타입인스턴스 - 메타타입)
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    func setupDatas() {
        print("1")
        
        // 네트워킹의 시작
        networkManager.fetchProduct(searchTerm: "") { result in
            print(#function)
            print("6")
            
            switch result {
            case .success(let productDatas):
                // 데이터(배열)을 받아오고 난 후
                self.productArrays = productDatas
                //                dump(self.productArrays)
                
                // 테이블뷰 리로드
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 테이블뷰의 오토레이아웃 설정
    func setUpTableViewConstraints() {
        view.addSubview(mainTableView)
        mainTableView.backgroundColor = .darkGray
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    
}

extension MainTableViewCellController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        print(section)
        print(productArrays.count)
        
        return productArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // (힙에 올라간)재사용 가능한 셀을 꺼내서 사용하는 메서드 (애플이 미리 잘 만들어 놓음)
        // (사전에 셀을 등록하는 과정이 내부 메커니즘에 존재)
        let cell = mainTableView.dequeueReusableCell(withIdentifier: Cell.productCellIdentifier, for: indexPath) as! MainTableViewCell
        
        cell.imageUrl = productArrays[indexPath.row].prdImg
        cell.prdNameKR.text = productArrays[indexPath.row].prdNameKr
        cell.prdNameEn.text = productArrays[indexPath.row].prdNameEn
        cell.prdNotice = productArrays[indexPath.row].prdNotice
        cell.prdPrice.text = commons.getDecimalPrice(price: productArrays[indexPath.row].prdPrice)
        
        dump(productArrays[indexPath.row])
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension MainTableViewCellController: UITableViewDelegate {
    
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 다음화면으로 이동
        let detailVC = DetailProductViewController()
        let selectedData = productArrays[indexPath.row]
        
        print("선택-------------------------------------------")
        dump(productArrays[indexPath.row])
        print("----------------------------------------------")
        
        detailVC.selectedProduct = selectedData
        
        
        // 화면이동
        navigationController?.pushViewController(detailVC, animated: true)
        // show(detailVC, sender: nil)
    }
    
    // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶다면 구현할 수 있는 메서드
    // (musicTableView.rowHeight = 120 대신에 사용가능)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - UISearchBarDelegate
extension MainTableViewCellController: UISearchBarDelegate {
    
    // 입력하는 순간마다
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        
        print("검색단어 : \(searchText)")
        self.productArrays = []
        
        networkManager.fetchProduct(searchTerm: searchText) { result in
            switch result {
            case .success(let productDatas):
                self.productArrays = productDatas
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - searchBarSearchButtonClicked
    // 검색 버튼을 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        
        print("검색 단어 : \(text)")
        
        self.productArrays = []
        
        networkManager.fetchProduct(searchTerm: text) { result in
            switch result {
            case .success(let productDatas):
                self.productArrays = productDatas
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.view.endEditing(true)
    }
    
    // MARK: - searchBarCancelButtonClicked()
    // 캔슬 버튼 클릭시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        guard let text = searchController.searchBar.text else { return }
        
        print("검색 단어 : \(text)")
        
        self.productArrays = []
        
        networkManager.fetchProduct(searchTerm: text) { result in
            switch result {
            case .success(let productDatas):
                self.productArrays = productDatas
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.view.endEditing(true)
    }
    

}


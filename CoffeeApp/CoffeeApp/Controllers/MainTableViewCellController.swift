//
//  MainTableViewCellController.swift
//  CoffeeApp
//
//  Created by ๊นํ์ on 2022/09/11.
//

import UIKit

final class MainTableViewCellController: UIViewController {
    
    var isLoggedIn = false
    
    // ๐ ์์น ์ปจํธ๋กค๋ฌ ์์ฑ ===> ๋ค๋น๊ฒ์ด์ ์์ดํ์ ํ ๋น
    let searchController = UISearchController()
    let commons = Commons()
    
    // ๐ ์์น Results์ปจํธ๋กค๋ฌ โญ๏ธ
    //let search = UISearchController(searchResultsController: <#T##UIViewController?#>)
    
    //    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    
    let mainTableView = UITableView()
    
    // ๋คํธ์ํฌ ๋งค๋์  (์ฑ๊ธํค)
    var networkManager = ProductNetworkManager.shared
    
    // (์ํ ๋ฐ์ดํฐ๋ฅผ ๋ค๋ฃจ๊ธฐ ์ํจ) ๋น๋ฐฐ์ด๋ก ์์
    var productArrays: [PrdList] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // โญ๏ธ ๋ก๊ทธ์ธ์ด ๋์ด์์ง ์๋ค๋ฉด ๋ก๊ทธ์ธํ๋ฉด ๋์ฐ๊ธฐ
        // ๋ก๊ทธ์ธํ๋ฉด -> ๋ฉ์ธ ํ๋ฉด์ผ๋ก ๊ฐ๋ฉด ๋ก๊ทธ์ธํ๋ฉด์ด ๊ณ์ ํ๋ฉ๋ชจ๋ฆฌ์ ์ฌ๋ผ๊ฐ์ ธ์์ด์ ํจ์จ์ ์ด์ง ๋ชปํจ.
        // ์ฑ์ ๋์ฐ๋ฉด ๋ฐ๋ก ๋ฉ์ธ๋ทฐ๋ก ์ด๋์ํค๊ณ  ๋ก๊ทธ์ธ ์๋์ด์์ผ๋ฉด ๊ทธ๋ ๋ก๊ทธ์ธ ํ๋ฉด์ผ๋ก ์ด๋.
        //        if !isLoggedIn {
        //            let vc = LoginViewController()
        //            vc.modalPresentationStyle = .fullScreen
        //
        //            // ๋ด๋น๊ฒ์ด์์ปจํธ๋กค๋ฌ๋ฅผ ์ด์ฉํด์ผ๋  ๋ ์๋ ์ฝ๋ ์ฌ์ฉ
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
        title = "๋ฉ๋ด"
        
        // ๋ค๋น๊ฒ์ด์๋ฐ ์ค์ ๊ด๋ จ
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
        self.title = "๋ฉ๋ด ๊ฒ์"
        navigationItem.searchController = searchController
        
        // 1) (๋จ์) ์์น๋ฐ์ ์ฌ์ฉ
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
    }
    
    
    func setupTableView() {
        // ๋ธ๋ฆฌ๊ฒ์ดํธ ํจํด์ ๋๋ฆฌ์ ์ค์ 
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        // ์์ ๋์ด ์ค์ 
        mainTableView.rowHeight = 120
        
        // ์คํฌ๋กค์ ํค๋ณด๋ ๋ด๋ฆฌ๊ธฐ
        mainTableView.keyboardDismissMode = .onDrag
        
        // ์์ ๋ฑ๋กโญ๏ธ (ํ์์ธ์คํด์ค - ๋ฉํํ์)
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    func setupDatas() {
        print("1")
        
        // ๋คํธ์ํน์ ์์
        networkManager.fetchProduct(searchTerm: "") { result in
            print(#function)
            print("6")
            
            switch result {
            case .success(let productDatas):
                // ๋ฐ์ดํฐ(๋ฐฐ์ด)์ ๋ฐ์์ค๊ณ  ๋ ํ
                self.productArrays = productDatas
                //                dump(self.productArrays)
                
                // ํ์ด๋ธ๋ทฐ ๋ฆฌ๋ก๋
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // ํ์ด๋ธ๋ทฐ์ ์คํ ๋ ์ด์์ ์ค์ 
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
        // (ํ์ ์ฌ๋ผ๊ฐ)์ฌ์ฌ์ฉ ๊ฐ๋ฅํ ์์ ๊บผ๋ด์ ์ฌ์ฉํ๋ ๋ฉ์๋ (์ ํ์ด ๋ฏธ๋ฆฌ ์ ๋ง๋ค์ด ๋์)
        // (์ฌ์ ์ ์์ ๋ฑ๋กํ๋ ๊ณผ์ ์ด ๋ด๋ถ ๋ฉ์ปค๋์ฆ์ ์กด์ฌ)
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
    
    // ์์ด ์ ํ์ด ๋์์๋ ์ด๋ค ๋์์ ํ  ๊ฒ์ธ์ง ๋ทฐ์ปจํธ๋กค๋ฌ์๊ฒ ๋ฌผ์ด๋ด
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ๋ค์ํ๋ฉด์ผ๋ก ์ด๋
        let detailVC = DetailProductViewController()
        let selectedData = productArrays[indexPath.row]
        
        print("์ ํ-------------------------------------------")
        dump(productArrays[indexPath.row])
        print("----------------------------------------------")
        
        detailVC.selectedProduct = selectedData
        
        
        // ํ๋ฉด์ด๋
        navigationController?.pushViewController(detailVC, animated: true)
        // show(detailVC, sender: nil)
    }
    
    // ํ์ด๋ธ๋ทฐ ์์ ๋์ด๋ฅผ ์ ๋์ ์ผ๋ก ์กฐ์ ํ๊ณ  ์ถ๋ค๋ฉด ๊ตฌํํ  ์ ์๋ ๋ฉ์๋
    // (musicTableView.rowHeight = 120 ๋์ ์ ์ฌ์ฉ๊ฐ๋ฅ)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - UISearchBarDelegate
extension MainTableViewCellController: UISearchBarDelegate {
    
    // ์๋ ฅํ๋ ์๊ฐ๋ง๋ค
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        
        print("๊ฒ์๋จ์ด : \(searchText)")
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
    // ๊ฒ์ ๋ฒํผ์ ๋๋ ์ ๋
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        
        print("๊ฒ์ ๋จ์ด : \(text)")
        
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
    // ์บ์ฌ ๋ฒํผ ํด๋ฆญ์
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        guard let text = searchController.searchBar.text else { return }
        
        print("๊ฒ์ ๋จ์ด : \(text)")
        
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


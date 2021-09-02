//
//  HomeViewController.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/25.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var carButton: UIBarButtonItem!
    
    private var banner = Banner()
    private var product = Product()
    private var productData = Product.List(records: [])
    private var bannerData = Banner.List(records: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLargeTitles = true
        topItemTitle = "景品瀏覽"
        carButton.addBadge(number: OrderManager.shared.list.count)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startSpinner()
        banner.sendRequest(method: .get, reponse: Banner.List.self, completion: setupBannerData(result:))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carButton.updateBadge(number: OrderManager.shared.list.count)
        
    }
    
    func setupBannerData(result: Result<Banner.List,Error>) {
        stopSpinner()
        switch result {
        case .success(let data):
            self.bannerData = data
            DispatchQueue.main.async {
                self.startSpinner()
                self.product.sendRequest(method: .get, reponse: Product.List.self, completion: self.setupProductData(result:))
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.reloadData()
            }
        case .failure(let error):
            print("product.sendRequest failure \(error.localizedDescription)")
        }
    }
    
    func setupProductData(result: Result<Product.List,Error>) {
        stopSpinner()
        switch result {
        case .success(let data):
            self.productData = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .failure(let error):
            print("product.sendRequest failure \(error.localizedDescription)")
        }
    }
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> ProductDetailViewController? {
        guard let indexPath = self.collectionView.indexPathsForSelectedItems?.first
              else { return nil}
        return ProductDetailViewController(coder: coder, product: self.productData.records[indexPath.row])
    }
}

extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let reusableView =
                collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(ProductHeaderCollectionReusableView.self)", for: indexPath) as? ProductHeaderCollectionReusableView else {return UICollectionReusableView()}
        if let records = self.bannerData.records.first {
            reusableView.bannerData = records
        }
        
        
        return reusableView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData.records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProductCell.self)", for: indexPath) as! ProductCell
        let data = productData.records[indexPath.row]
        cell.setup(for: data)
        
        
        return cell
        
    }
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((UIScreen.main.bounds.width - 30 * 2) - 10)/2, height: 275)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

//
//  ProductDetailViewController.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/28.
//

import UIKit

class ProductDetailViewController: UITableViewController {

    
    @IBOutlet weak var photosCollectionView: UICollectionView!{
        didSet{
            photosCollectionView.delegate = self
            photosCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var quantityGroupView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var quantityControlView:QuantityControlView!
    let product:Product.List.Fields
    
    init?(coder: NSCoder, product:Product.List.Fields){
        self.product = product
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quantityControlView = QuantityControlView(frame: quantityGroupView.bounds)
        quantityControlView.product = product
        quantityGroupView.addSubview(quantityControlView)
        nameLabel.text = product.name
        stockLabel.text = "剩餘：\(product.stock)"
        pointLabel.text = "$\(product.point)"
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCellSize()
    }
    
    func configureCellSize() {
        let flowLayout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        let width = photosCollectionView.frame.width
        let height = photosCollectionView.frame.height
        flowLayout?.itemSize = CGSize(width: width, height: height)
        print(width,height)
        
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.minimumLineSpacing = 0
            
    }
    @IBAction func addProduct(_ sender: Any) {
        
    }
    
}
extension ProductDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = product.photos.count
        return product.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BannerCell.self)", for: indexPath) as! BannerCell
        
        let photo = product.photos[indexPath.row]
        cell.downloadPhoto(url: photo.url)
        
        return cell
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(Int(scrollView.contentOffset.x) ,Int(photosCollectionView.frame.width))
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(photosCollectionView.frame.width)
    }
    
}

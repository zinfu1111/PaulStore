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
    @IBOutlet weak var noteTextView:UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var quantityControlView:QuantityControlView!
    let product:Product.List.Record
    
    init?(coder: NSCoder, product:Product.List.Record){
        self.product = product
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        quantityControlView = QuantityControlView()
        quantityControlView.product = product.fields
        quantityGroupView.addSubview(quantityControlView)
        nameLabel.text = product.fields.name
        stockLabel.text = "剩餘：\(product.fields.stock)"
        pointLabel.text = "$\(product.fields.point)"
        noteTextView.text = product.fields.note

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        quantityControlView.frame = quantityGroupView.bounds
        quantityGroupView.layer.borderWidth = 1
        quantityGroupView.layer.borderColor = UIColor.black.cgColor
        quantityGroupView.layer.cornerRadius = quantityGroupView.frame.height/2
        configurePhotoSize()
    }
    
    private func configurePhotoSize() {
        let flowLayout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        let width = photosCollectionView.frame.width
        let height = photosCollectionView.frame.height
        flowLayout?.itemSize = CGSize(width: width, height: height)
        
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.minimumLineSpacing = 0
            
    }
    
    @IBAction func addProduct(_ sender: Any) {
        OrderManager.shared.addOrder(by: product.id, add: quantityControlView.quantity)
    }
    
}
extension ProductDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = product.fields.photos.count
        return product.fields.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BannerCell.self)", for: indexPath) as! BannerCell
        
        let photo = product.fields.photos[indexPath.row]
        cell.downloadPhoto(imageData: photo)
        
        return cell
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(photosCollectionView.frame.width)
    }
    
}

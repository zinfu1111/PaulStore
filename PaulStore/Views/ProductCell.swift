//
//  ProductCell.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/26.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel:UILabel!
    @IBOutlet weak var BgView: UIView!
    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var photoWidth: NSLayoutConstraint!
    @IBOutlet weak var cellWidthConstraints: NSLayoutConstraint!
    static let width = floor((UIScreen.main.bounds.width - 20) / 2)
    
    var product:Product.List.Record!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellWidthConstraints?.constant = Self.width
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //陰影
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.addProductButton.layer.cornerRadius = self.addProductButton.frame.height/2
        
        configPhotoSize()
    }
    
    func setup(for product:Product.List.Record){
        
        self.product = product
        
        nameLabel.text = product.fields.name
        pointLabel.text = "$\(product.fields.point)"
        
        
        downloadPhoto()
    }
    
    private func configPhotoSize(){
        
        guard let photo = self.product.fields.photos.first else { return }
        
        if photo.height < photo.width {
            //橫的
            let scale = photoImageView.frame.height/CGFloat(photo.height)
            photoWidth.constant = scale * CGFloat(photo.width)
            photoImageView.layoutIfNeeded()
        }else{
            photoWidth.constant = self.frame.width
            photoImageView.layoutIfNeeded()
        }
        
    }
    
    private func downloadPhoto() {
        
        guard let photo = self.product.fields.photos.first else { return }
        
        let productId = product.id
        let url = photo.url
        
        PhotoManager.shared.downloadImage(url: url) {[weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.photoImageView.image = productId == self.product.id ? image : UIImage(systemName: "photo")
            }
        }
        
    }
    
    @IBAction func addProduct(_ sender: Any) {
        guard let superView = self.superview as? UICollectionView else {
                print("superview is not a UITableView - getIndexPath")
                return
            }
        let indexPath = superView.indexPath(for: self)
        
        guard let superVC = parentViewController as? HomeViewController else { return }
        OrderManager.shared.addOrder(by: product.id, add: 1)
        superVC.performSegue(withIdentifier: "showOrder", sender: nil)
        
    }
}

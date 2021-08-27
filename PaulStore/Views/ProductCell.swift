//
//  ProductCell.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/26.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stockLabel:UILabel!
    @IBOutlet weak var pointLabel:UILabel!
    @IBOutlet weak var BgView: UIView!
    @IBOutlet weak var addProductButton: UIButton!
    
    var product:Product.List.Record!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //陰影
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.addProductButton.layer.cornerRadius = self.addProductButton.frame.height/2
        
    }
    
    func setup(for product:Product.List.Record){
        
        self.product = product
        
        nameLabel.text = product.fields.name
        pointLabel.text = "$\(product.fields.point)"
        stockLabel.text = "剩餘：\(product.fields.stock)"
        
        downloadPhoto()
    }
    
    private func downloadPhoto() {
        let productId = product.id
        if let url = self.product.fields.photos.first?.url {
            PhotoManager.shared.downloadImage(url: url) {[weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.photo.image = productId == self.product.id ? image : UIImage(systemName: "photo")
                }
            }
        }
    }
    
    @IBAction func addProduct(_ sender: Any) {
    }
}

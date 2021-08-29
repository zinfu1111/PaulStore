//
//  OrderCell.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/28.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var photoWidth: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    
    private var product:Product.List.Record!
    private var quantity:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bgView.layer.cornerRadius = self.bgView.frame.height * 0.1
        configPhotoSize()
    }
    
    func set(for product:Product.List.Record,quantity:Int) {
        quantityStepper.isHidden = false
        self.product = product
        self.quantity = quantity
        
        nameLabel.text = product.fields.name
        pointLabel.text = "$\(product.fields.point)"
        quantityStepper.value = Double(quantity)
        quantityLabel.text = String(format: "數量：%d", quantity)
        
        downloadPhoto()
    }
    
    func notfoundProduct() {
        quantityStepper.isHidden = true
        nameLabel.text = "無此產品"
        pointLabel.text = ""
        quantityLabel.text = ""
        
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

    @IBAction func stepperChange(_ sender: UIStepper) {
        
        OrderManager.shared.updateOrder(by: product.id, add: Int(sender.value))
        quantityLabel.text = String(format: "數量：%d", Int(sender.value))
        
    }
}

//
//  BannerCell.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/27.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoWidth: NSLayoutConstraint!
    private var imageData:ImageData!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configPhotoSize()
    }
    
    
    func downloadPhoto(imageData: ImageData){
        self.imageData = imageData
        let url = imageData.url
        
        PhotoManager.shared.downloadImage(url: imageData.url) {[weak self] image in
            guard let self = self,url == self.imageData.url else { return }
            DispatchQueue.main.async {
                guard let image = image else {
                    self.photo.image = nil
                    return
                }
                self.photo.image = image
            }
        }
    }
    
    private func configPhotoSize(){
        if imageData.width > imageData.height{
            //橫的
            self.photoWidth.constant = self.frame.width
        }
        else{
            //正方形 直的
            let scale = self.photo.frame.height/CGFloat(imageData.height)
            self.photoWidth.constant = self.frame.width * scale
        }
        self.layoutIfNeeded()
    }
}

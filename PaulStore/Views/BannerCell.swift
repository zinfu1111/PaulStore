//
//  BannerCell.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/27.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    private var photoURL:URL!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    func downloadPhoto(url: URL){
        
        self.photoURL = url
        
        PhotoManager.shared.downloadImage(url: url) {[weak self] image in
            guard let self = self,url == self.photoURL else { return }
            DispatchQueue.main.async {
                self.photo.image = image
            }
        }
    }
}

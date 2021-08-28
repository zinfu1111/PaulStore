//
//  ProductHeaderCollectionReusableView.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/26.
//

import UIKit

class ProductHeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    var bannerData: Banner.List.Record!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCellSize()
    }
    
    func configureCellSize() {
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        flowLayout?.itemSize = CGSize(width: width, height: height)
        print(width,height)
        
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.minimumLineSpacing = 0
            
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        collectionView.selectItem(at: IndexPath(row: sender.currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension ProductHeaderCollectionReusableView: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = bannerData.fields.photo.count
        return bannerData.fields.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BannerCell.self)", for: indexPath) as! BannerCell
        
        let photo = bannerData.fields.photo[indexPath.row]
        cell.downloadPhoto(imageData: photo)
        
        return cell
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(Int(scrollView.contentOffset.x) ,Int(collectionView.frame.width))
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(collectionView.frame.width)
    }
}

//
//  QuantityControlView.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/26.
//

import UIKit

class QuantityControlView: UIView {

    @IBOutlet weak var quantityLabel: UILabel!
    var contentView:UIView!
    var quantity = 0
    var product:Product.List.Fields!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    func setUp() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(QuantityControlView.self)", bundle: bundle)
        contentView = (nib.instantiate(withOwner: self, options: nil)[0] as! UIView)
        contentView.frame = bounds
        addSubview(contentView)
        quantityLabel.text = "\(quantity)"
        quantityLabel.layer.borderColor = UIColor.black.cgColor
        quantityLabel.layer.borderWidth = 1
    }

    @IBAction func cutQuantity(_ sender: Any) {
        if quantity > 0 {
            quantity -= 1
            quantityLabel.text = "\(quantity)"
        }
    }
    @IBAction func addQuantity(_ sender: Any) {
        if quantity < 99 {
            quantity += 1
            quantityLabel.text = "\(quantity)"
        }
    }
}

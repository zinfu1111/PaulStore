//
//  OrderManager.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/27.
//

import Foundation

class OrderManager {
    
    static let shared = OrderManager()
    
    ///ProductId,Quantity
    var list = [String:Int]()
    
    
    func addOrder(by productId:String,add quantity: Int) {
        
        if list.keys.first(where: {$0 == productId}) != nil {
            list[productId] = quantity + list[productId]!
        }else{
            list.updateValue(quantity, forKey: productId)
        }
        print("[OrderManager] list",list)
    }
}

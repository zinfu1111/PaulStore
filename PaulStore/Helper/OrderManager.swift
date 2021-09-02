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
    var totalPoint:Double = 0
    
    func addOrder(by productData:[Product.List.Record],name:String,phone:String,address:String,lineId:String,fbId:String,email:String) -> [Order.Create.Record] {
        
        var result = [Order.Create.Record]()
        
        self.list.forEach({ item in
            if let product = productData.first(where: {$0.id == item.key})?.fields {
                let record = Order.Create.Record(fields: .init(customerName: name, phone: phone, address: address, lineId: lineId, fbId: fbId, email: email, quantity: item.value, productId: item.key, productName: product.name))
                result.append(record)
            }
        })
        return result
    }
    
    func addOrder(by productId:String,add quantity: Int) {
        
        if list.keys.first(where: {$0 == productId}) != nil {
            list[productId] = quantity + list[productId]!
        }else{
            list.updateValue(quantity, forKey: productId)
        }
        print("[OrderManager] list add",list)
    }
    
    func updateOrder(by productId:String,add quantity: Int) {
        list[productId] = quantity
        print("[OrderManager] list update",list)
    }
    
    func clearOrder() {
        list.removeAll()
    }
}

//
//  Order.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/27.
//

import Foundation

struct Order {
    
    struct List:Decodable {
        
        let records: [Record]
        struct Record: Codable {
            let id: String
            let fields: Fields
        }
        
        struct Fields: Codable {
            let customerName: String
            let phone: String
            let address: String
            let lineId: String
            let fbId: String
            let email: String
            let quantity: Int
            let productId: String
        }
        
    }
    
    struct Create:Encodable {
        
        let records: [Record]
        struct Record: Codable {
            let fields: Fields
        }
        
        struct Fields: Codable {
            let customerName: String
            let phone: String
            let address: String
            let lineId: String
            let fbId: String
            let email: String
            let quantity: Int
            let productId: String
            let productName: String
        }
        
    }
    
    struct Update:Encodable {
        
        let records: [Record]
        struct Record: Codable {
            let id: String
            let fields: Fields
        }
        
        struct Fields: Codable {
            let customerName: String
            let phone: String
            let address: String
            let lineId: String
            let fbId: String
            let email: String
            let quantity: Int
            let productId: String
        }
        
    }
    
    struct Delete:Decodable {
        let records: [Record]
        struct Record: Codable {
            let id: String
            let deleted: Bool
        }
    }
    
}
extension Order:APIService{
    var route: APIRoute {
        get {
            .order()
        }
        set {
            newValue
        }
    }
}

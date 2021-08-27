//
//  Product.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/25.
//

import Foundation

struct Product {
    
    struct List:Decodable {
        
        let records: [Record]
        struct Record: Codable {
            let id: String
            let fields: Fields
        }
        
        struct Fields: Codable {
            let name: String
            let point: Double
            let stock: Int
            let note: String
            let photos: [ImageData]
        }
        
        struct ImageData: Codable {
            let url: URL
        }
        
    }
    
    struct Create:Encodable {
        
        let records: [Record]
        struct Record: Codable {
            let fields: Fields
        }
        
        struct Fields: Codable {
            let name: String
            let point: Double
            let stock: Double
            let note: String
            let photos: [ImageData]
        }
        
        struct ImageData: Codable {
            let url: URL
        }
    }
    
    struct Update:Encodable {
        
        let records: [Record]
        struct Record: Codable {
            let id: String
            let fields: Fields
        }
        
        struct Fields: Codable {
            let name: String
            let point: Double
            let stock: Double
            let note: String
            let photos: [ImageData]
        }
        
        struct ImageData: Codable {
            let url: URL
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
extension Product:APIService{
    var route: APIRoute {
        get {
            .product()
        }
        set {
            newValue
        }
    }
}

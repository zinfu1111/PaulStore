//
//  Banner.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/28.
//

import Foundation

struct Banner {
    
    struct List:Decodable {
        
        let records: [Record]
        struct Record: Codable {
            let id: String
            let fields: Fields
        }
        
        struct Fields: Codable {
            let photo: [ImageData]
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
            let photo: [ImageData]
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
            let photo: [ImageData]
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
extension Banner:APIService{
    var route: APIRoute {
        get {
            .banner()
        }
        set {
            newValue
        }
    }
}

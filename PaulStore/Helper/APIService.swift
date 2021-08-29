//
//  APIService.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/25.
//

import Foundation

private let baseURL = "https://api.airtable.com/v0/apphC2VdXkwsSgwVS"
private let apiKey = "keyk9UtV73WZD5WkQ"

enum APIRoute {
    
    case product(addPath:String? = nil)
    case banner(addPath:String? = nil)
    case order(addPath:String? = nil)
    
    var path:String{
        switch self {
        case .product(let addPath):
            return addPath == nil ? "/Product" : "/Product\(addPath!)"
        case .banner(let addPath):
            return addPath == nil ? "/Banner" : "/Banner\(addPath!)"
        case .order(let addPath):
            return addPath == nil ? "/Order" : "/Order\(addPath!)"
        }
    }
    
}

enum HTTPMethod:String {
    case get     = "GET"
    case post    = "POST"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol APIService {
    var route:APIRoute { get set }
}

extension APIService {
    
    mutating func sendRequest<T>(body:Data? = nil,method:HTTPMethod,reponse:T.Type ,completion: @escaping (Result<T,Error>)->Void) where T:Decodable {
        
        let url = URL(string: "\(baseURL)\(route.path)")
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        if let body = body {
            request.httpBody = body
            
            let json = String(data: body, encoding: .utf8)
            print("[API] request:\(json)")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = String(data: data, encoding: .utf8)
                //有印出來
                print("[API] response:\(json)")
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(reponse, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
        
    }
}

extension Encodable {
    func encodeToData() -> Data? {
        
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.string(from: Date())
        encoder.dateEncodingStrategy = .formatted(formatter)
        return try? encoder.encode(self)
        
    }
}

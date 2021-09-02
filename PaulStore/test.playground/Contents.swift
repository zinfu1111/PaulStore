import UIKit
import Foundation
import PlaygroundSupport
//var data = ["123":1,"23":2]
//data.removeValue(forKey: "123")
////print(Array(data.keys)[0])
//print(data)

//let apiKey = "keyk9UtV73WZD5WkQ"
//
//
//var request = URLRequest(url: URL(string:"https://api.airtable.com/v0/apphC2VdXkwsSgwVS/Product")!)
//request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//request.httpMethod = "GET"
//
//URLSession.shared.dataTask(with: request) { data, response, error in
//    if let data = data {
//        let body = String(data: data, encoding: .utf8)
//        print("[API] response \(body)")
//    }
//}.resume()

let view = UIView()
view.backgroundColor = .white
view.frame.size = CGSize(width: 300, height: 600)
PlaygroundSupport.PlaygroundPage.current.liveView = view



let view2 = UIView()
view2.backgroundColor = .black
view2.frame.size = CGSize(width: 100, height: 100)
view2.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
view.addSubview(view2)

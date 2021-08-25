//
//  PhotoManager.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/26.
//

import UIKit
import Alamofire
import Foundation

struct UploadImageResult: Decodable {
    struct Data: Decodable {
        let link: URL
    }
    let data: Data
}

class PhotoManager {
    
    static let shared = PhotoManager()
    
    func uploadImage(image: UIImage,completion:@escaping (UploadImageResult.Data)->Void ) {
            let headers: HTTPHeaders = [
                "Authorization": "Client-ID d41dd1368bb4f01",
            ]
            AF.upload(multipartFormData: { (data) in
                let imageData = image.jpegData(compressionQuality: 0.9)
                data.append(imageData!, withName: "image")
                
            }, to: "https://api.imgur.com/3/image", headers: headers).responseDecodable(of: UploadImageResult.self, queue: .main, decoder: JSONDecoder()) { (response) in
                switch response.result {
                case .success(let result):
                    print(result.data.link)
                    completion(result.data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    

}

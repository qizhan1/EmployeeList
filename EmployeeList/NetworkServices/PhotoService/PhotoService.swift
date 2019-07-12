//
//  PhotoService.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/10/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//


import Foundation


class PhotoService {
    
    
    static func fetchPhoto(from link: String?, completion: @escaping (_ image: UIImage?) -> Void) {
        guard let link = link, let url = URL(string: link) else { return }
        
        fetchPhoto(from: url, completion: completion)
    }
    
    
    static func fetchPhoto(from url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
            }
                completion(image)
        }.resume()
    }
    
    
}

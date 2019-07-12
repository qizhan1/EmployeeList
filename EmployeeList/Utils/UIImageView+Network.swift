//
//  UIImageView+Network.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloaded(from url: URL,
                    contentMode mode: UIView.ContentMode = .scaleAspectFit,
                    completion: @escaping ((_ image: UIImage?) -> Void)) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    completion(nil)
                    
                    return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                completion(image)
            }
            }.resume()
    }
    
    
    func downloaded(from link: String,
                    contentMode mode: UIView.ContentMode = .scaleAspectFit,
                    completion: @escaping ((_ image: UIImage?) -> Void)) {
        guard let url = URL(string: link) else { return }
        
        downloaded(from: url, contentMode: mode, completion: completion)
    }
    
    
}

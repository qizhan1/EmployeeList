//
//  PhotoDataStore.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/10/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//


import Foundation


enum PhotoSize: String {
    case large = "large"
    case small = "small"
}


class  PhotoDataProvider {
    
    
    // - MARK: Singleton
    
    
    static let shared = PhotoDataProvider()
    
    
    // - MARK: Cached data in memeory
    
    
    var photoDict: Dictionary<String, UIImage> = Dictionary<String, UIImage>()
    
    
    public func fetchPhoto(for employee: EmployeeInfo?,
                           with photoSize: PhotoSize,
                           completion: @escaping (_ image: UIImage?) -> Void) {
        var url: String?
        switch photoSize {
        case .small:
            url = employee?.smallPhotoURL
        case .large:
            url = employee?.largePhotoURL
        }
        guard let photoURL = url else {
            completion(nil)
            
            return
        }
        
        
        // TODO: Add lock to ensure thread safety
        
        // 1. try memory
        if let cachedImage = photoDict[photoURL] {
            completion(cachedImage)
            
            return
        }
        
        // 2. try local
        if let localImage = UIImage.getSavedImage(named: photoURL) {
            self.photoDict[photoURL] = localImage
            completion(localImage)
            
            return
        }
        
        // 3. try remote api
        PhotoService.fetchPhoto(from: photoURL) { [weak self] image in
            completion(image)
            self?.photoDict[photoURL] = image
            image?.save(at: .documentDirectory, pathAndImageName: photoURL)
        }
    }
    
}



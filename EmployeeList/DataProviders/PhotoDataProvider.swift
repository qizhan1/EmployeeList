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
        
        // try local first
        if let localImage = UIImage.getSavedImage(named: photoURL) {
            self.photoDict[photoURL] = localImage
            completion(localImage)
            
            return
        }
        
        // if it's not in local storage, try fetching from server
        PhotoService.fetchPhoto(from: photoURL) { [weak self] image in
            completion(image)
            self?.photoDict[photoURL] = image
            image?.save(at: .documentDirectory, pathAndImageName: photoURL)
        }
    }
    
}



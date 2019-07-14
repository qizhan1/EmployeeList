//
//  PhotoDataStore.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/10/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//


import Foundation


protocol PhotoDataProviderDelegate: NSObjectProtocol {
    
    
    func didFinishFetchingPhoto(for employeID: String?, image: UIImage?, at indexPath: IndexPath)
    
    
}


enum PhotoSize: String {
    case large = "large"
    case small = "small"
}


class  PhotoDataProvider {
    
    
    // - MARK: Singleton
    
    
    static let shared = PhotoDataProvider()
    
    
    // - MARK: Private Properties
    
    private let concurrentPhotoQueue = DispatchQueue( label: "com.employeeList.photoQueue",
                                                      attributes: .concurrent)
    
    
    // - MARK: Cached data in memeory
    
    
    private var unsafePhotoDict = [String: UIImage]()
    var photoDict: [String: UIImage] {
        var photoDictCopy = [String: UIImage]()
        concurrentPhotoQueue.sync {
            photoDictCopy = self.unsafePhotoDict
        }
        return photoDictCopy
    }
    
    
    // - MARK: Delegate
    
    
    weak var delegate: PhotoDataProviderDelegate?
    
    
    // - MARK: Public Methods
    
    
    public func fetchPhoto(for employee: EmployeeInfo?, at indexPath: IndexPath) {
        fetchPhoto(for: employee, with: .large) { [weak self] image in
            self?.delegate?.didFinishFetchingPhoto(for: employee?.uuid, image: image, at: indexPath)
        }
    }
    
    
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
            addPhoto(localImage, with: photoURL)
            completion(localImage)
            
            return
        }
        
        // 3. try remote api
        PhotoService.fetchPhoto(from: photoURL) { [weak self] image in
            completion(image)
            self?.addPhoto(image, with: photoURL)
            image?.save(at: .documentDirectory, pathAndImageName: photoURL)
        }
    }
    
    
    private func addPhoto(_ photo: UIImage?, with key: String?) {
        guard let photo = photo, let key = key else { return }
        concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
            self?.unsafePhotoDict[key] = photo
        }
    }
}



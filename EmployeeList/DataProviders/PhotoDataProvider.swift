// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// - MARK: PhotoDataProviderDelegate


protocol PhotoDataProviderDelegate: NSObjectProtocol {
    
    
    func didFinishFetchingPhoto(for employeID: String?, image: UIImage?, at indexPath: IndexPath)
    
    
}


// *************************************************************************************************
// - MARK: PhotoSize Enum


enum PhotoSize: String {
    case large = "large"
    case small = "small"
}


// *************************************************************************************************
// - MARK: PhotoDataProvider


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
        
        let photoURLPathMD5 = photoURL.MD5
        
        // 1. try memory
        if let cachedImage = photoDict[photoURLPathMD5] {
            completion(cachedImage)
            
            return
        }
        
        // 2. try local
        if let localImage = UIImage.getSavedImage(named: photoURLPathMD5) {
            addPhoto(localImage, with: photoURLPathMD5)
            completion(localImage)
            
            return
        }
        
        // 3. try remote api
        PhotoService.fetchPhoto(from: photoURL) { [weak self] image in
            completion(image)
            self?.addPhoto(image, with: photoURLPathMD5)
            image?.save(at: .cachesDirectory, pathAndImageName: photoURLPathMD5)
        }
    }
    
    
    // - MARK: Private Methods
    
    
    private func addPhoto(_ photo: UIImage?, with key: String?) {
        guard let photo = photo, let key = key else { return }
        
        concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
            self?.unsafePhotoDict[key] = photo
        }
    }
    
    
}



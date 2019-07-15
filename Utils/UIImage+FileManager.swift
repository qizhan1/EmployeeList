// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: UIImage Extension


extension UIImage {
    
    
    @discardableResult
    func save(at directory: FileManager.SearchPathDirectory,
              pathAndImageName: String,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
            let documentsDirectory = try FileManager.default.url(for: directory, in: .userDomainMask,
                                                                 appropriateFor: nil,
                                                                 create: false)
            return save(at: documentsDirectory.appendingPathComponent(pathAndImageName),
                        createSubdirectoriesIfNeed: createSubdirectoriesIfNeed,
                        compressionQuality: compressionQuality)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
    
    
    @discardableResult
    func save(at url: URL,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
            if createSubdirectoriesIfNeed {
                try FileManager.default.createDirectory(at: url.deletingLastPathComponent(),
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            }
            guard let data = jpegData(compressionQuality: compressionQuality) else { return nil }
            try data.write(to: url)
            return url
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
    
}


extension UIImage {
    
    
    static func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            let urlPath = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path
            if FileManager.default.fileExists(atPath: urlPath) {
                
                return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
            }
        }
        
        return nil
    }
    
    
}

// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: UIFont Extension


extension UIFont {
    
    
    static var titleFont: UIFont {
        guard let font = UIFont(name: "AvenirNext-Heavy", size: 30) else {
            
            return UIFont.systemFont(ofSize: 30)
        }
        
        return font
    }
    
    
    static var descriptionFont: UIFont {
        guard let font = UIFont(name: "AvenirNext-Medium", size: 16) else {
            
            return UIFont.systemFont(ofSize: 30)
        }
        
        return font
    }
    
    
}

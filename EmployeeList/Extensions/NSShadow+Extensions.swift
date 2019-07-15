// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: NSShadow Extension


extension NSShadow {
    
    static var titleTextShadow: NSShadow {
        let shadow: NSShadow = NSShadow()
        
        shadow.shadowColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.3)
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        shadow.shadowBlurRadius = 3.0
        
        return shadow
    }
    
    
    static var descriptionTextShadow: NSShadow {
        let shadow: NSShadow = NSShadow()
        
        shadow.shadowColor = UIColor(white: 0, alpha: 0.3)
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 3.0
        
        return shadow
    }
    
    
}

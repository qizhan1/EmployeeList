// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: NSParagraphStyle Extension


extension NSParagraphStyle {
    
    static var justifiedParagraphStyle: NSParagraphStyle {
        let paragraphStlye: NSMutableParagraphStyle = NSMutableParagraphStyle()
        
        paragraphStlye.alignment = .justified
        
        return paragraphStlye
    }
    
    
}

// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: NSAttributedString Extension


extension NSAttributedString {
    
    
    static func attributedString(title: String?) -> NSAttributedString? {
        guard let title = title else {
            return nil
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.titleFont,
            .foregroundColor: UIColor.white,
            .shadow: NSShadow.titleTextShadow,
            .paragraphStyle: NSParagraphStyle.justifiedParagraphStyle
        ]
        
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    
    static func attributedString(description: String?) -> NSAttributedString? {
        guard let description = description else {
            return nil
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.descriptionFont,
            .foregroundColor: UIColor.white,
            .shadow: NSShadow.descriptionTextShadow,
            .paragraphStyle: NSParagraphStyle.justifiedParagraphStyle
        ]
        
        return NSAttributedString(string: description, attributes: attributes)
    }
    
}

//
//  AttributedString+Extension.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation
import UIKit


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

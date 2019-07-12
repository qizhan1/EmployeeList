//
//  NSParagraphStyle+Extensions.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation
import UIKit

extension NSParagraphStyle {
    
    static var justifiedParagraphStyle: NSParagraphStyle {
        let paragraphStlye: NSMutableParagraphStyle = NSMutableParagraphStyle()
        
        paragraphStlye.alignment = .justified
        
        return paragraphStlye
    }
    
    
}

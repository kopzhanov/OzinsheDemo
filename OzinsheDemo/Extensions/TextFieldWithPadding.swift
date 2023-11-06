//
//  TextFieldWithPadding.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 30.09.2023.
//

import UIKit

class TextFieldWithPadding: UITextField {
   
    var padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 16)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open  func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}



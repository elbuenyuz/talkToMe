//
//  MatrerialTextField.swift
//  talkToMe
//
//  Created by Daniel Ramirez on 10/28/16.
//  Copyright © 2016 simpleCoding. All rights reserved.
//

import UIKit

class MatrerialTextField: UITextField {
    
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.borderWidth = 1.0
    }
    //for placeholder alignment
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
}

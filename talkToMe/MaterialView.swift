//
//  MaterialView.swift
//  talkToMe
//
//  Created by Daniel Ramirez on 10/28/16.
//  Copyright © 2016 simpleCoding. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    /*
     Funcion para determinar la punta redondeada y las sombras
     */
    override func awakeFromNib() {
        
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red:SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }

}

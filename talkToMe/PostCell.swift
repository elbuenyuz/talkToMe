//
//  PostCell.swift
//  talkToMe
//
//  Created by Daniel Ramirez on 11/4/16.
//  Copyright © 2016 simpleCoding. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    override func drawRect(rect: CGRect) {
         profImg.layer.cornerRadius = profImg.frame.size.width / 2
    }
    
}

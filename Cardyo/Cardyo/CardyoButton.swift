//
//  CardyoButton.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/6/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit

@IBDesignable
class CardyoButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0

    
        override func drawRect(rect: CGRect) {
        // Drawing code
            
            self.layer.cornerRadius = cornerRadius
            clipsToBounds = true
            layer.masksToBounds = true
            
    }
    

}

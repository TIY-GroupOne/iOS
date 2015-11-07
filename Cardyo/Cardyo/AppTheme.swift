//
//  AppTheme.swift
//  Cardyo
//
//  Created by Mac Bellingrath on 11/6/15.
//  Copyright © 2015 TeamOne. All rights reserved.
//

import UIKit
import UIColor_FlatColors

private let _theme = AppTheme()
class AppTheme: NSObject {
    
    let themeColor = UIColor.flatWetAsphaltColor()
    let highLightColor = UIColor.whiteColor()
    class func sharedTheme() -> AppTheme {
        return _theme
    }
    
    enum colors {
        
        case Turquoise, GreenSea, Emerald, Nephritis, PeterRiver, BelizeHole, Amethyst, Wisteria, WetAsphalt, MidnightBlue, SunFlower, Orange, Carrot, Pumpkin, Alizarin, Pomegranate, Clouds, Silver, Concrete, Asbestos

    }

}

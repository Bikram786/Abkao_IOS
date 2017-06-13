//
//  UILabel+Customization.swift
//  
//
//  Created by Apple on 22/05/17.
//  Copyright © 2017 Abhishek Singla. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    class func fitLabeltoFixWidth(label :UILabel)  {
        
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        
    }
    
}


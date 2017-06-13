//
//  UIView+Customization.swift
//  
//
//  Created by Apple on 12/05/17.
//  Copyright © 2017 Abhishek Singla. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class func addShadowToView(view : UIView) -> UIView{
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowColor = UIColor.gray.cgColor
        return view
    }

}

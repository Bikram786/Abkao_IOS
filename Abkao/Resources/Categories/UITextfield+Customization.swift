//
//  UITextfield+Customization.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//


import Foundation
import UIKit

extension UITextField {
    
    class func addShadowToTextfield(view : UITextField)-> UITextField {
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 5.0
        return view
    }
    
}

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
    
     func addShadowToTextfield() {
//        view.layer.cornerRadius = 5
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        view.layer.shadowOpacity = 1.0
//        view.layer.shadowRadius = 5.0
//        return view
        
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        self.leftView = leftView
        self.leftViewMode = .always

    }
    
}

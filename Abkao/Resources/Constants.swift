//
//  Constants.swift
//  
//
//  Created by admin on 08/05/17.
//  Copyright © 2017 Abhishek Singla. All rights reserved.
//

import Foundation
import UIKit

public struct Constants {
    
    static let kMainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    
    static let baseUrl = "http://6.abkao-webservices.appspot.com/"

    
    
    static let kDateFormatter = "MM-dd-yyyy hh:mma"
    
    static let baseUrlCountries = "http://api.geonames.org/"
    
    
    static let scannerKey = "AbBqFilpM4BjGVMLCST1EBwD7BZcGhzMCFVNMXlTKQyCSU1aYVmHxEhdrZkxSCz0RWDUzndj/mkdUtG2AjFsK2pdZ04reExpJDsAm1Bgz226I1Z6w2LLpbkEWeFdlVGvD5g+ZrCpC4MGEX1ot1jcWuZ+wCk+W2LXZZatl7Kq+EypE0B6lWi4ROnpz9wDmHtJcIrpzGJeB7t/lQmrDJgvi2r/n9RpDxW5cd7A8yT7+ML5UiBQIoNErsy8J6DOHvm9qvJTFsx0w1K1kMUygnJ4aD+yIs4AQKd8GSmfWJTFi9t/SCJxzQ21T/f7245afrGgRZFn/XpYP+2aJKE5to7VJ0tKeMKB6lpbuNwx2cOxR9EqPuIrI2I4QO/bfsx0vkvfu6cWNYEpg4sWTSwPBE+LsP8Knc9mL8XNoToXU+PbcjTnbosQMTbS4ycYbJlQy4+uaJrLEVn1wv+Rrnpds1JAhXIG3GAZ02uGkwC/ZUsIlEGzdS8KAWg/OdtuK8HWNj+fuxz6uESyL3ZdsdWyRr+jJIhm5zxbNLE8ZUrbYP8+v12wwS7j8L3PE60VRUhmhK7CxRKJEmRJPsMfyL89FYs7bExNj8JvoxNk3QrJ0nVltC/lGFba85WxQ6hIczgf3q9EdISKeDqPmeFD5Ga8+jsycGKcKidGDiG5AEilfDpPrTy8e+PujzIligo9V5RoX1Dlgv02EZMyazZsKR5Zk91i5eI9FOTXOaG4dyCQcdX5blL9sj5g4DmyamNhQT6z8BTwGUZs4W7RwsSnTkVyibY/Swg973F7MhTHL8GM"
    
    enum AvenirNextCondensed : String {
        case Regular    = "AvenirNextCondensed-Regular"
        case Bold       = "AvenirNextCondensed-Bold"
        case SemiBold   = "AvenirNextCondensed-DemiBold"
        case Medium     = "AvenirNextCondensed-Medium"
        case Italic     = "AvenirNextCondensed-Italic"

    }

    struct appColor {
        
        static let appDeleteColor = UIColor.init(colorLiteralRed: 69.0/255.0, green: 109.0/255.0, blue: 173.0/255.0, alpha: 1)
        static let appEditColor = UIColor.init(colorLiteralRed: 219.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1)
        
        
        static let appBlueColor = UIColor.init(colorLiteralRed: 87.0/255.0, green: 91.0/255.0, blue: 99.0/255.0, alpha: 1)
        static let skyBlueColor = UIColor.init(colorLiteralRed: 67/255, green: 175/255, blue: 205/255, alpha: 1)

    }
    
    // RelayFont Constants
    struct appFont {
        
        static func AvenirNextCondensedFont(fontName: String,fontSize: CGFloat) -> UIFont {
            
            return UIFont.init(name: fontName, size: fontSize)!
            
        }
        
    }
    
    struct appFontSize
    {
        static let extraSmallFont = 16.00
        static let smallFont = 18.00
        static let regularFont = 20.00
        static let largeFont = 22.00
        static let extraLargeFont = 24.00
        
    }

    
}

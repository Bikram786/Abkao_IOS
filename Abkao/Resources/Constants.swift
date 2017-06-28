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
    
    static let baseUrlBarCode = "http://nexportretail.azurewebsites.net/API/PriceBookQuery/GetProduct/?parameters="
    
    static let kDateFormatter = "MM-dd-yyyy hh:mma"
    
    static let baseUrlCountries = "http://api.geonames.org/countryInfoJSON?"
    
    
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

    
}

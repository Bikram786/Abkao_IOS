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
    
    
    static let scannerKey = "AeqKAFlpQ656FGqLli+680omKuPUM/SsJ23iRPdEl7uJaSZrZ3vRyNtRfhgue833kWYsDSN/s0OwKuJkokX5USFfuc/+bBkASBec2GJ/PS7OUYKiBHAEXHI3AoUZT60vdsoHJs9FZVRzkSdRWVRBvMmYqAQRS2GIMfjFuHxr0cLIV3ZNmRTpbU3xprhaMMs8Mmu2OlchHE+VyBvMk8HDDYD6fsKDaDN9aHYRiuNN57c97BRgAFMgoWxQZRfDROlU2fnQSYawT/90QYrGPUFfYRy6xTWVTNS7UCphS6BbKmIv3X+2C42aGCysAB5ALaEIo4i/Jt6Sq/fCDjlpmDqCqCgjD5IL08MuHsne30CCee6VIHLPH7My48nPIlaMke3zFjKsksLwxgqmfPAYK65dN4TpxnyecfYJQvKhMnu0CImg7wK9jKiH63t6RyNksDfxDv2aHnt1cNaJCooXuXigVRoeGJ/ORbNdZn822egPTVD6fqSZkKHHqEt3O2AEkG/mV9dcbW+S3FV4tXh0+ccFkDE2YqKPFA/ewzuwH+HtLqx6VE4B5ZEXAhsM0Hyx7DW4LqODa9J8r89DtSdD7qNXKT4vMBMRzrWcEWrk/2JqJkx92Nrf87HwuxFXhKEHji1cY0rxtD0ftU0Gk1MnnjY9HMXERUNp+aE7wSSK+N0belW8EEFbb+h5lprwXyvi/gIHpmu2oZ20Cz0K4ClFYaGTNN6jVxHEAIvIg5ZUnh/QctxJlGDXbnKy38j2mEVFxrdCTHh0RnfnjOB7aBdb5oP1XkIYUmkw3Hb1Po7IWA=="
    
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

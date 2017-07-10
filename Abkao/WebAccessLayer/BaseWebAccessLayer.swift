//
//  BaseWebAccessLayer.swift
//  Rezli
//
//  Created by Kabir Chandoke on 1/24/17.
//  Copyright © 2017 iOS. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SVProgressHUD

import ReachabilitySwift

class BaseWebAccessLayer: NSObject {
    
    static let reachability = Reachability()
    
    override init() {
        
        BaseWebAccessLayer.isInternetReachable { (isInternetAvailable, strMessage) in
            
            
        }
    }
    
    
    class func isInternetReachable(reachabilityHandler : @escaping (Bool,String) -> Void) -> Void
    {
        reachability?.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                reachabilityHandler(true,"")
                
                print("Internet Reachable")
                
            }
        }
        reachability?.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                print("Not reachable")
                reachabilityHandler(false,"No Internet Available")
                
            }
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    class func requestURLWithDictionaryResponse(requestType : HTTPMethod , strURL: String,headers : Bool,params : [String : Any]?, result:@escaping (NSDictionary , Int) -> Void) {
        
        
        if (reachability?.isReachable)!
        {
            // proceed
            
            SVProgressHUD.setStatus("Loging.....")
            
            var finalStrUrl = String()
            
            finalStrUrl = Constants.baseUrl + strURL
            
            let escapedUrl = finalStrUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            let headersHttp = [
                // "User-Agent" : "Mozilla/5.0 (iPhone; CPU iPhone OS 10_1_1 like Mac OS X) AppleWebKit/602.2.14 (KHTML, like Gecko) Version/10.0 Mobile/14B100 Safari/602.1",
                "Content-Type": "application/json"
            ]
            
            
            let alamofiremManager = Alamofire.SessionManager.default
            
            alamofiremManager.session.configuration.timeoutIntervalForRequest = 30
            
            alamofiremManager.request(escapedUrl!, method: requestType, parameters: params!, encoding: JSONEncoding.default, headers: headersHttp).responseJSON {  (responseObject) in
                
                if responseObject.result.isSuccess {
                    
                    SVProgressHUD.dismiss()
                    let statusCode : Int = (responseObject.response?.statusCode)!
                    let resJson = responseObject.result.value as! NSDictionary
                    result(resJson , statusCode)
                    
                }
            }
            
        }
        else
        {
            SVProgressHUD.setMinimumDismissTimeInterval(0.01)
            SVProgressHUD.showError(withStatus: "No Internet Available")
        }
        
    }
        
    
    
    class func getRequestURLforContriesResponse(requestType : HTTPMethod , strURL: String,headers : Bool, result:@escaping (NSDictionary , Int) -> Void) {
        
        
        if (reachability?.isReachable)!
        {
            // proceed
            
            SVProgressHUD.setStatus("Loging.....")
            
            var finalStrUrl = String()
            
            finalStrUrl = Constants.baseUrlCountries + strURL
                        
            let escapedUrl = finalStrUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            let headersHttp = [
                // "User-Agent" : "Mozilla/5.0 (iPhone; CPU iPhone OS 10_1_1 like Mac OS X) AppleWebKit/602.2.14 (KHTML, like Gecko) Version/10.0 Mobile/14B100 Safari/602.1",
                "Content-Type": "application/json"
            ]
            
            
            let alamofiremManager = Alamofire.SessionManager.default
            
            alamofiremManager.session.configuration.timeoutIntervalForRequest = 30
            
            alamofiremManager.request(escapedUrl!, method: requestType, encoding: JSONEncoding.default, headers: headersHttp).responseJSON {  (responseObject) in
                
                if responseObject.result.isSuccess {
                    
                    SVProgressHUD.dismiss()
                    let statusCode : Int = (responseObject.response?.statusCode)!
                    let resJson = responseObject.result.value as! NSDictionary
                    result(resJson , statusCode)
                    
                }
            }
            
        }
        else
        {
            SVProgressHUD.setMinimumDismissTimeInterval(0.01)
            SVProgressHUD.showError(withStatus: "No Internet Available")
        }
    }

    
    
    //
    //    class func tempRequestURLWithDictionaryResponse(requestType : HTTPMethod , strURL: String,headers : Bool, params : NSDictionary?, result:@escaping (NSDictionary , Int) -> Void) {
    //
    //
    //        if (reachability?.isReachable)!
    //        {
    //            // proceed
    //
    //            var finalStrUrl = String()
    //
    //            finalStrUrl = Constants.baseUrl + strURL
    //
    //            print("API Url : \(finalStrUrl)")
    //
    //            let dict : NSMutableDictionary = params as! NSMutableDictionary
    //            dict.setValue("application/json", forKey: "Content-Type",
    //
    //
    //            let headersHttp = [
    //                // "User-Agent" : "Mozilla/5.0 (iPhone; CPU iPhone OS 10_1_1 like Mac OS X) AppleWebKit/602.2.14 (KHTML, like Gecko) Version/10.0 Mobile/14B100 Safari/602.1",
    //                //"Content-Type": "application/json",
    //
    //                dict
    //
    //
    //                ]
    //            let alamofiremManager = Alamofire.SessionManager.default
    //
    //            alamofiremManager.session.configuration.timeoutIntervalForRequest = 30
    //
    //
    //            alamofiremManager.request(finalStrUrl, method: "POST" , parameters: nil, encoding: JSONEncoding.default, headers: headersHttp).responseJSON {  (responseObject) in
    //                print(responseObject)
    //
    //                if responseObject.result.isSuccess {
    //
    //                    let statusCode : Int = (responseObject.response?.statusCode)!
    //
    //                    let resJson = responseObject.result.value as! NSDictionary
    //
    //                    result(resJson , statusCode)
    //
    //                }
    //            }
    //
    //        }
    //        else
    //        {
    //            // show message
    //            
    //            // unreachable
    //        }
    //        
    //    }
    
    
}

//
//  YummlyNetworking.swift
//  Recipes10
//
//  Created by Cesar Ramirez on 2/5/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration



class yummlyNetworking {
    

    struct SharedInstance {
        static var recipes: [Recipes] = [Recipes]()
    }
    
    func searchRecipes(searchRecepie: String!, completionHandler: (matches: [NSDictionary], success: Bool, error: String? ) -> Void){
        
        var recipeDataDictionary = [String: AnyObject]()
        
        let apiURL: String = "https://api.yummly.com/v1/api/recipes?_app_id=65564e28&_app_key=622e80311e622e2d858f9a560b848cf4&q=\(searchRecepie)" //replace rice
        
        
        if isConnectedToNetwork() == false {
            completionHandler( matches: [], success : false, error: "No internet Connection")
            return
        }
        
  
        
        let url = NSURL(string: apiURL)
              
        let jsonData: NSData?
        do {
            jsonData = try NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMapped)
        } catch let error as NSError {
            completionHandler( matches: [], success : false, error: "Connection error")
            jsonData = nil
            return
        }
        
        do {
            
            let jsonDataDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.AllowFragments)
            
            recipeDataDictionary = jsonDataDictionary as! Dictionary<String, AnyObject>
            
            let matches = jsonDataDictionary["matches"] as! [NSDictionary]
            

            if matches.isEmpty{
                completionHandler( matches: [], success : false, error: "No results")
            } else{
                completionHandler( matches: matches, success : true ,error: nil)
            }
            return
            
        } catch let error as NSError {
            completionHandler( matches: [], success : false, error: "No results")
            return
        }
    
        
    }
    
    
    
    func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        }
    
   
    
}



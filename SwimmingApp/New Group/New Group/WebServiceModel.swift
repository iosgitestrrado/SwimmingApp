//
//  WebServiceModel.swift
//  SwimmingApp
//
//  Created by Monish M S on 23/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import Alamofire
public class WebServiceModel{
    open class func makePostApiCallWithParameters(parameter:[String:String], withUrl url:URL, onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        if isInternetAvailable(){
            print(url)
            print(parameter)
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 30
            manager.request(url,method: .post, parameters: parameter)
                .responseJSON { response in
                    
                    if let err = response.result.error
                    {
                        failure(err as NSError)
                    } else {
                        if let JSON = response.result.value as! Dictionary<String, AnyObject>? {
                            print(JSON)
                            success(JSON)
                            
                        }else {
                            failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
                        }
                    }
                    
            }
            
        }else{
            failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No internet connection"]))
        }
    }
    
    open class func makePostApiCallWithParameterss(parameter:[String:AnyObject],
                                                  withUrl url:URL,
                                                  onSuccess success:@escaping successClosure,
                                                  onFailure failure:@escaping failureClosure,
                                                  duringProgress progress:progressClosure?) {
        
        if isInternetAvailable(){
            
            print(url)
            
            print(parameter)
            
            let manager = Alamofire.SessionManager.default
            
            manager.session.configuration.timeoutIntervalForRequest = 30
            
            
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameter)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            Alamofire.request(request).responseJSON { response in
                
                if let err = response.result.error{
                    
                    failure(err as NSError)
                    
                } else {
                    
                    if let JSON = response.result.value as! Dictionary<String, AnyObject>? {
                        
                        print(JSON)
                        
                        success(JSON)
                        
                        
                        
                    }else {
                        
                        failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
                        
                    }
                    
                }
                
            }
            
        } else {
            
            failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No internet connection"]))
            
        }
        
    }

}



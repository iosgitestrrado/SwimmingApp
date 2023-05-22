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
//            let manager = Alamofire.SessionManager.default
            AF.session.configuration.timeoutIntervalForRequest = 30
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                switch response.result {
                case .success(_):
                    do {
                        if let jsonData = response.data {
                            let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: [])
                            success(jsonResponse as! Dictionary<String, AnyObject>)
                        } else {
                            failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
                        }
//                        print(jsonResponse) //Response result
                    } catch let parsingError {
                        print("Error", parsingError)
                        failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
                    }
                case .failure(let error):
                    failure(error as NSError)
                }
//                if let err = response.result.error {
//                    failure(err as NSError)
//                } else {
//                    if let JSON = response.result.value as! Dictionary<String, AnyObject>? {
//                        print(JSON)
//                        success(JSON)
//
//                    } else {
//                        failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
//                    }
//                }
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
                        
            AF.session.configuration.timeoutIntervalForRequest = 30
            
            
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameter)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default,headers: nil).responseJSON { response in
                switch response.result {
                case .success(_):
                    do {
                        if let jsonData = response.data {
                            let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: [])
                            success(jsonResponse as! Dictionary<String, AnyObject>)
                        } else {
                            failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
                        }
//                        print(jsonResponse) //Response result
                    } catch let parsingError {
                        print("Error", parsingError)
                        failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
                    }
                case .failure(let error):
                    failure(error as NSError)
                }
//            AF.request(request).responseJSON { response in
          
//                if let err = response.result.error{
//                    
//                    failure(err as NSError)
//                    
//                } else {
//                    
//                    if let JSON = response.result.value as! Dictionary<String, AnyObject>? {
//                        
//                        print(JSON)
//                        
//                        success(JSON)
//                        
//                        
//                        
//                    }else {
//                        
//                        failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"JSON NOT VALID"]))
//                        
//                    }
//                    
//                }
                
            }
            
        } else {
            
            failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"No internet connection"]))
            
        }
        
    }

}



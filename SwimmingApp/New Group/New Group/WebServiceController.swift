//
//  WebServiceController.swift
//  SwimmingApp
//
//  Created by Monish M S on 23/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
public class WebServiceApi {
    
    public class func loginSubmission(mobile:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["phone":mobile];
        let loginUrl = NSURL(string: webServiceUrls.loginUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: loginUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func OTPVerification(mobile:String,otp:String,type:String,deviceToken:String,OS:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["phone":mobile,"otp":otp,"otp_type":type,"deviceToken":deviceToken,"os":OS];
        let otpVerificationUrl = NSURL(string: webServiceUrls.otpVerificationUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: otpVerificationUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func versionInfo(onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["":""]
        let versionUrl = NSURL(string: webServiceUrls.versionUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: versionUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func registerUser(name:String,phone:String,email:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["name":name,"phone":phone,"email":email]
        let registrationUrl = NSURL(string: webServiceUrls.registrationUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: registrationUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func resendOTP(mobile:String,type:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["phone":mobile,"otp_type":type];
        let resendOtpUrl = NSURL(string: webServiceUrls.resendOtpUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: resendOtpUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func addUserType(mobile:String,type:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["phone":mobile,"user_type":type];
        let addUserTypeUrl = NSURL(string: webServiceUrls.addUserTypeUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: addUserTypeUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func relationshipList(onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["":""]
        let relationshipListUrl = NSURL(string: webServiceUrls.relationshipListUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: relationshipListUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    internal class func addNewChild(mobile:String,childModelList:[[String : AnyObject]],onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary = [String:AnyObject]()
        //parameterDictionary = ["phone":mobile,"child":childModelList]
        parameterDictionary = ["phone":mobile,"child":childModelList] as [String : AnyObject]
        let addNewChildUrl = NSURL(string: webServiceUrls.addNewChildUrl)!
        WebServiceModel.makePostApiCallWithParameterss( parameter: parameterDictionary, withUrl: addNewChildUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func locationList(accessToken:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accessToken]
        let courseLocationsUrl = NSURL(string: webServiceUrls.courseLocationsUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: courseLocationsUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func courseList(accessToken:String,id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accessToken,"location":id]
        let courseListUrl = NSURL(string: webServiceUrls.courseListUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: courseListUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func courseDetailList(accessToken:String,id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accessToken,"course_id":id]
        let courseDetailsListUrl = NSURL(string: webServiceUrls.courseDetailsListUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: courseDetailsListUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func courseRegistration(accesToken:String,course_id:String,child_id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"course_id":course_id,"child_id":child_id];
        let courseRegisterUrl = NSURL(string: webServiceUrls.courseRegisterUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: courseRegisterUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    
    //  Changes by Praveen  //

    
    
    
    public class func BadgeListApi(accesToken:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken];
        let courseRegisterUrl = NSURL(string: webServiceUrls.courseRegisterUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: courseRegisterUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func ChildrensListApi(accesToken:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken];
        let childrenListUrl = NSURL(string: webServiceUrls.childrenListUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: childrenListUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func NotifyLocationApi(accesToken:String,location:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"location":location];
        let notifyLocationUrl = NSURL(string: webServiceUrls.notifyLocationUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: notifyLocationUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func MyCoursesApi(accesToken:String,child_id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"child_id":child_id];
        let myCoursesUrl = NSURL(string: webServiceUrls.myCoursesUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: myCoursesUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func MyActivitiesApi(accesToken:String,child_id:String,course_id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"child_id":child_id,"course_id":course_id];
        let myActivitiesUrl = NSURL(string: webServiceUrls.myActivitiesUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: myActivitiesUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func ActivityDetailApi(accesToken:String,child_id:String,activity_id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"child_id":child_id,"activity_id":activity_id];
        let activityDetailUrl = NSURL(string: webServiceUrls.activityDetailUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: activityDetailUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func ProfileApi(accesToken:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken];
        let profileUrl = NSURL(string: webServiceUrls.profileUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: profileUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func SubmitActivityApi(accesToken:String,activity_id:String,child_id:String,description:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"activity_id":activity_id,"child_id":child_id,"description":description];
        let submitActivityUrl = NSURL(string: webServiceUrls.submitActivityUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: submitActivityUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    
    public class func CoachListApi(accesToken:String,child_id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"child_id":child_id];
        let chatCoachListUrl = NSURL(string: webServiceUrls.chatCoachListUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: chatCoachListUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func ChatListApi(accesToken:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken];
        let chatUrl = NSURL(string: webServiceUrls.chatUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: chatUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    public class func CreateChatApi(accesToken:String,coach_id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"coach_id":coach_id];
        let chatCreateUrl = NSURL(string: webServiceUrls.chatCreateUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: chatCreateUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func ChatHistoryApi(accesToken:String,chat_id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"chat_id":chat_id];
        let chatHistoryUrl = NSURL(string: webServiceUrls.chatHistoryUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: chatHistoryUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func ChatMessageApi(accesToken:String,chat_id:String,chat_msg:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"chat_id":chat_id,"chat_msg":chat_msg];
        let chatMessageUrl = NSURL(string: webServiceUrls.chatMessageUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: chatMessageUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func ChatSearchApi(accesToken:String,search:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"search":search];
        let chatSearchUrl = NSURL(string: webServiceUrls.chatSearchUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: chatSearchUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func DeleteActivityMediaApi(accesToken:String,media_id:String,onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary:[String:String] = ["":""]
        parameterDictionary = ["accesToken":accesToken,"media_id":media_id];
        let deleteActivityMediaUrl = NSURL(string: webServiceUrls.deleteActivityMediaUrl)!
        WebServiceModel.makePostApiCallWithParameters( parameter: parameterDictionary, withUrl: deleteActivityMediaUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
    public class func AddChildApi(accesToken:String,childModelList:[[String : AnyObject]],onSuccess success:@escaping successClosure, onFailure failure:@escaping failureClosure, duringProgress progress:progressClosure?){
        var parameterDictionary = [String:AnyObject]()
        //parameterDictionary = ["phone":mobile,"child":childModelList]
        parameterDictionary = ["accesToken":accesToken,"child":childModelList] as [String : AnyObject]
        let addChildUrl = NSURL(string: webServiceUrls.addChildUrl)!
        WebServiceModel.makePostApiCallWithParameterss( parameter: parameterDictionary, withUrl: addChildUrl as URL, onSuccess: success, onFailure: failure, duringProgress: progress)
    }
    
}

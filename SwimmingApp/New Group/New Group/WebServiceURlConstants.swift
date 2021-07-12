//
//  WebServiceURlConstants.swift
//  SwimmingApp
//
//  Created by Monish M S on 23/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
struct webServiceUrls {
    
    static var baseURl        = "https://estrradoweb.com/swimming/api/"
    // static var baseURl     = "https://ibrbazaar.com/api/"
    // LIVE
    
    static let loginUrl           = webServiceUrls.baseURl+"login"
    static let otpVerificationUrl = webServiceUrls.baseURl+"auth/otp"
    static let versionUrl = webServiceUrls.baseURl+"version"
    static let registrationUrl = webServiceUrls.baseURl+"register"
    static let resendOtpUrl = webServiceUrls.baseURl+"auth/resendOtp"
    static let addUserTypeUrl = webServiceUrls.baseURl+"addUserType"
    static let relationshipListUrl = webServiceUrls.baseURl+"relationships"
    static let addNewChildUrl = webServiceUrls.baseURl+"addNewChild"
    static let courseLocationsUrl = webServiceUrls.baseURl+"course/locations"
    static let courseListUrl = webServiceUrls.baseURl+"location/course/list"
    static let courseDetailsListUrl = webServiceUrls.baseURl+"course/detail"
    static let courseRegisterUrl = webServiceUrls.baseURl+"course/register"
    
    //  Changes by Praveen 
    static let coursebadgeListUrl = webServiceUrls.baseURl+"course/badgeList"
    static let childrenListUrl = webServiceUrls.baseURl+"childrenList"
    static let notifyLocationUrl = webServiceUrls.baseURl+"course/location/notify"
    static let myCoursesUrl = webServiceUrls.baseURl+"course/myCourses"
    static let myActivitiesUrl = webServiceUrls.baseURl+"course/myActivities"
    static let activityDetailUrl = webServiceUrls.baseURl+"course/activity/detail"
    static let addChildUrl = webServiceUrls.baseURl+"addChild"
    static let profileUrl = webServiceUrls.baseURl+"profile"
    static let submitActivityMediaUrl = webServiceUrls.baseURl+"course/activity/media/submit"
    static let submitActivityUrl = webServiceUrls.baseURl+"course/activity/submit"
    static let chatCoachListUrl = webServiceUrls.baseURl+"chat/coachList"
    static let chatUrl = webServiceUrls.baseURl+"chat"
    static let chatCreateUrl = webServiceUrls.baseURl+"chat/create"
    static let chatHistoryUrl = webServiceUrls.baseURl+"chat/chatHistory"
    static let chatMessageUrl = webServiceUrls.baseURl+"chat/message"
    static let chatSearchUrl = webServiceUrls.baseURl+"chat/search"
    static let profileUpdateUrl = webServiceUrls.baseURl+"profile/update"
    static let deleteActivityMediaUrl = webServiceUrls.baseURl+"course/activity/media/delete"


}

public typealias  successClosure  = (_ result: Dictionary<String, AnyObject>) -> Void
public typealias  failureClosure  = (_ error:NSError)->Void
public typealias  progressClosure = (_ progress:Float)->Void

struct ConstantsInUI {
    static let noInternet = "No Internet Connection"
    static let noDataFound = "No Data Found"
    static let serverConnectionFail = "Could not connect to server"
}

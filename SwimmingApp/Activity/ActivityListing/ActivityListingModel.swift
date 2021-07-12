//
//  ActivityListingModel.swift
//  SwimmingApp
//
//  Created by MAC on 15/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import Foundation

struct activity_listModel:Codable
{
    var milestoneData : milestoneModel?
    var activities : activitiesModel?
    var userData : userDataModel?

}
struct milestoneModel:Codable
{
    var all:Int?
    var complete:Int?
    var names:String?

}
struct activitiesModel:Codable
{
    var upcoming:[upcomingModel]
    var inprogress:[inprogressModel]
    var complete:[completeModel]
    var rejected:[rejectedModel]

}
struct upcomingModel:Codable
{
    var id:Int?
    var reg_course_id:Int?
    var course_id:Int?
    var ms_id:Int?
    var activity_id:Int?
    var curr_status:Int?
    var badge_id:Int?
    var status:Int?
    var activity_code:String?
    var activity_name:String?
    var activity_desc:String?
    var media:[mediaModels]

}
struct inprogressModel:Codable
{
    var id:Int?
    var reg_course_id:Int?
    var course_id:Int?
    var ms_id:Int?
    var activity_id:Int?
    var curr_status:Int?
    var badge_id:Int?
    var status:Int?
    var activity_code:String?
    var activity_name:String?
    var activity_desc:String?
    var media:[mediaModels]

}
struct completeModel:Codable
{
    var id:Int?
    var reg_course_id:Int?
    var course_id:Int?
    var ms_id:Int?
    var activity_id:Int?
    var curr_status:Int?
    var badge_id:Int?
    var status:Int?
    var activity_code:String?
    var activity_name:String?
    var activity_desc:String?
    var media:[mediaModels]

}
struct rejectedModel:Codable
{
    var id:Int?
    var reg_course_id:Int?
    var course_id:Int?
    var ms_id:Int?
    var activity_id:Int?
    var curr_status:Int?
    var badge_id:Int?
    var status:Int?
    var activity_code:String?
    var activity_name:String?
    var activity_desc:String?
    var media:[mediaModels]

}
struct mediaModels:Codable
{
    var id:Int?
    var activity_id:Int?
    var description:String?
    var file:String?
    var type:String?
    var active:Int?
    var status:Int?

}

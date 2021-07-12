//
//  ActivityDetailsModel.swift
//  SwimmingApp
//
//  Created by MAC on 16/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import Foundation
struct Activity_DetailModel:Codable
{
    var detail : detailModel?
    var submited : [submitedModel]?

}

struct detailModel:Codable
{
    var id:Int?
    var activity_code:String?
    var ms_id:Int?
    var course_id:Int?
    var activity_name:String?
    var activity_desc:String?
    var active:Int?
    var created_at:String?
    var modified_at:String?
    var status:Int?
    var media:[mediaModelss]

}

struct submitedModel:Codable
{
    var id:Int?
    var student_id:Int?
    var reg_course_id:Int?
    var reg_activity_id:Int?
    var description:String?
    var submited_at:String?
    var coach_review:String?
    var act_status:Int?
    var badge_id:Int?
    var status:Int?
    var media:[mediaModelss]
    var badge:Int?

}

struct mediaModelss:Codable
{
    var id:Int?
    var activity_id:Int?
    var description:String?
    var file:String?
    var type:String?
    var active:Int?
    var status:Int?

}

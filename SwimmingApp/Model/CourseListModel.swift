//
//  CourseListModel.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
struct CourseListModel:Codable {
    var course_list : [CourseModel]
    var location : LocationDataModel?
}
struct CourseModel:Codable {
    var id:Int
    var course_code:String?
    var course_name:String?
    var course_desc:String?
    var location:Int?
    var coach:Int?
    var start_date:String?
    var end_date:String?
    var closing_date:String?
    var active:Int?
    var created_at:String?
    var modified_at:String?
    var status:Int?
    var locName:String?
    var CoachName:String?
    var registered:Int?
    var milestones:Int
    var avtGroups:Int?
    var activities:Int
    var media:mediaModel?
}
struct mediaModel:Codable {
    var file:String?
    var type:String?
}
struct LocationDataModel:Codable {
    var description:String?
    var id:Int?
    var name:String?
    var state_id:Int?
    var status:Int?
}

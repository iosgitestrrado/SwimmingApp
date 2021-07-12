//
//  Course_List_Model.swift
//  SwimmingApp
//
//  Created by MAC on 15/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import Foundation

struct course_listModel:Codable
{
    var course_list : [courseModelData]
    var userData : userDataModel?
}
struct courseModelData:Codable
{
    var id:Int
    var student_id:Int?
    var course_id:Int?
    var coach_id:Int?
    var complete_percent:Int?
    var reg_status:Int?
    var active:Int?
    var registered_at:String?
    var status:Int?
    var course_code:String?
    var course_name:String?
    var location:String?
    var coach:String?
    var student:String?
    var milestoneData:milestoneDataModel?
    

}
struct milestoneDataModel:Codable
{
    var all:Int?
    var complete:Int?
    var names:String?

}

struct userDataModel:Codable
{
    var push_notify:Int
    var chat_notify:Int?
    
}

//
//  ProfileModel.swift
//  SwimmingApp
//
//  Created by MAC on 13/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import Foundation

struct ProfileModel:Codable
{
    var childrens : [childrensModel]
    var profile : profileDataModel?
}
struct childrensModel:Codable
{
    var id:Int
    var email:String?
    var phone:Int?
    var user_type:Int?
    var is_login:Int?
    var is_parent:Int?
    var active:Int?
    var active_from:String?
    var active_link:String?
    var last_login:String?
    var parent:Int?
    var relation:Int?
    var created_at:String?
    var updated_at:String?
    var push_notify:Int?
    var chat_notify:Int?
    var deviceToken:String
    var os:String?
    var status:Int?
    var user_id:Int?
    var name:String?
    var avthar:String?
    var relName:String?
    var registered:Int?
    var approved:Int
    

    var course:course?
}
struct course:Codable
{
    var courses:Int?
    var comp_activity:Int?
    var pend_activity:Int?

}

struct profileDataModel:Codable
{
    var id:Int
    var email:String?
    var phone:Int?
    var user_type:Int?
    var is_login:Int?
    var is_parent:Int?
    var active:Int?
//    var active_from:String?
//    var active_link:String?
//    var last_login:String?
    var parent:Int?
    var relation:Int?
    var created_at:String?
    var updated_at:String?
    var push_notify:Int?
    var chat_notify:Int?
    var deviceToken:String
    var os:String?
    var status:Int?
    var user_id:Int?
    var name:String?
    var avthar:String?
    var relName:String?
    var registered:Int?
    var approved:Int
    var course:course?

}

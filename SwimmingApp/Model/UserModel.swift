//
//  UserModel.swift
//  SwimmingApp
//
//  Created by Monish M S on 25/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation

struct userDetailsModel:Codable {
    var userDetails : UserModel
}

struct UserModel:Codable{
    var access_token:String?
    var active:Int?
    var active_from:String?
    var address1:String?
    var address2:String?
    var chat_notify:Int?
    var city:String?
    var company_logo:String?
    var country:String?
    var deviceToken:String?
    var dob:String?
    var email:String?
    var email_verified_at:String?
    var id:Int?
    var is_login:Int?
    var is_parent:Int?
    var name:String?
    var os:String?
    var parent:Int?
    var phone:Int?
    var push_notify:Int?
    var relation:String?
    var remember_token:String?
    var state:String?
    var status:Int?
    var updated_at:String?
    var user_avthar:String?
    var user_id:Int?
    var user_type:Int?
    var zip:String?

}

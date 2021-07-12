//
//  ChatHistoryModel.swift
//  SwimmingApp
//
//  Created by MAC on 17/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import Foundation
struct ChatHistoryModel:Codable
{
    var chat_id:Int?
    var chat_data:chat_dataModel?
    var chat_messages:[chat_messagesModel]

}

struct chat_dataModel:Codable
{
    var chat_id : Int?
    var name : Int?
    var avthar : String?

}

struct chat_messagesModel:Codable
{
    var me : Int?
    var msg_id : Int?
    var user_id : Int?
    var chat_id : Int?
    var from : String?
    var message : String?
    var date : String?
    var time : String?



}

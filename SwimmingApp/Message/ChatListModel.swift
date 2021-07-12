//
//  ChatListModel.swift
//  SwimmingApp
//
//  Created by MAC on 14/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import Foundation
struct ChatListModel:Codable{
    var chat_list:[ChatModel]?
}

struct ChatModel:Codable {
    var chat_id : Int
    var name : String?
    var avthar : String?
    var unread : Int?
    var chat_msg : String?
    var date : String?

}

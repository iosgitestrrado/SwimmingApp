//
//  CoachListModel.swift
//  SwimmingApp
//
//  Created by MAC on 15/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import Foundation
struct coachListModel:Codable
{
    var coach_list:[coach_listModel]?
    
}

struct coach_listModel:Codable
{
    var id : Int
    var phone : Int
    var name : String?
    var avthar : String?

}

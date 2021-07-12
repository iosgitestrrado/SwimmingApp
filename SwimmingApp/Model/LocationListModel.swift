//
//  LocationListModel.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
struct LocationListModel:Codable{
    var location_list:[LocationModel]?
}

struct LocationModel:Codable {
    var id : Int
    var locName : String?
}

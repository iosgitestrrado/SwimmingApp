//
//  RelationshipModel.swift
//  SwimmingApp
//
//  Created by Monish M S on 24/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation

struct RelationshipModel:Codable{
    
    var relationships : [relationshipsModel]?
    
}
struct relationshipsModel:Codable {
    var id : Int
    var relation : String?
    var description : String?
    var status : Int?
}
struct childModel{
    var name : String
    var phone : String
    var email : String
    var relation : String
    
    var dictionaryRepresentation: [String: AnyObject] {
        return [
            "name" : name as AnyObject  ,
            "phone" : phone as AnyObject ,
            "email" : email as AnyObject ,
            "relation": relation as AnyObject 
        ]
    }
}

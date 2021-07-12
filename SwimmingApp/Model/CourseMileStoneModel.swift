//
//  CourseMileStoneModel.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
struct CourseMileStoneModel :Codable{
    var course:CourseDataModel?
    var mStone:[mstoneModel]?
}
struct CourseDataModel:Codable {
    let id : Int?
    let course_code : String?
    let course_name : String?
    let course_desc : String?
    let location : Int?
    let coach : Int?
    let start_date : String?
    let end_date : String?
    let closing_date : String?
    let active : Int?
    let created_at : String?
    let modified_at : String?
    let status : Int?
    let locName : String?
    let coachName : String?
    let registered : Int?
    let media : [MediaDataModel]?
}
struct MediaDataModel:Codable{
    let id : Int?
    let activity_id : Int?
    let description : String?
    let file : String?
    let type : String?
    let status : Int?
}
struct mstoneModel:Codable{
    let id : Int?
    let course_id : Int?
    let ms_name : String?
    let ms_desc : String?
    let active : Int?
    let status : Int?
    let avtGroups : [AvtGroupsModel]?
    let activities : [ActivitiesModel]?
}
struct AvtGroupsModel:Codable {
    let id : Int?
    let course_id : Int?
    let ms_id : Int?
    let group_name : String?
    let activity_ids : String?
    let active : Int?
    let created_at : String?
    let modified_at : String?
    let status : Int?
    let activities : [ActivitiesModel]?
}
struct ActivitiesModel:Codable {
    let id : Int?
    let activity_code : String?
    let ms_id : Int?
    let course_id : Int?
    let activity_name : String?
    let activity_desc : String?
    let active : Int?
    let created_at : String?
    let modified_at : String?
    let status : Int?
    let media : [MediaDataModel]?
}

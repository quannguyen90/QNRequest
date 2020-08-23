//
//  IPUser.swift
//  Warehouse
//
//  Created by quan nguyen on 11/15/19.
//  Copyright © 2019 quan nguyen. All rights reserved.
//

import UIKit

/* "_id": "5e17f0718c2d9509ae3e6758",
"name":"tuyen",
"phone":"0988071291",
"city":"VNN.HANOI",
"district":"VNN.HANOI.BADINH",
"gender":1,
"birthday":"1991-7-12 00:00:00",
"skypeId":"tuyenpm",
"facebookLink":"",
"code":"NV001"*/

public class IPUser: Codable {
    
    var id: String?
    var code: String?
    var email: String?
    
    var deptCode: String?
    var deptName: String?
    
    var teamId: String?
    var teamName: String?
    
    var role: String?
    var name: String?
    var phone: String?
    var imageAvatarUrl: String?
    
    var city: String?
    var district: String?
    var gender: Int?
    var skypeId: String?
    var facebookLink: String?
    var birthday: String?
    var status: String?
    
    
    var token: String?
    var active: Int?
    var isChoose: Bool?


    private enum CodingKeys : String, CodingKey {
        case id = "_id"
        case code = "code"
        case email = "email"
        case deptCode = "deptCode"
        case deptName = "deptName"

        case teamId = "teamId"
        case teamName = "teamName"

        case role = "role"
        case name = "name"
        case token = "token"
        case phone = "phone"
        case active = "active"
        case isChoose = "isChoose"
        
        case city = "city"
        case district = "district"
        case gender = "gender"
        case skypeId = "skypeId"
        case facebookLink = "facebookLink"
        case birthday = "birthday"
        case imageAvatarUrl = "image"
        case status = "status"
    }
    
    func jsonString() throws -> String  {
        return toJSONString()
    }
    
    func toJSONString() -> String {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            return jsonString ?? ""
        }
        catch {
            return ""
        }
    }
    
    func toJSON() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        let dict = (try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)) as? [String: Any]
        return dict ?? [:]
    }
    
  
}



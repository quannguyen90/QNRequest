//
//  FABIResponse.swift
//  FabiManager
//
//  Created by quan nguyen on 10/9/19.
//  Copyright © 2019 quan nguyen. All rights reserved.
//

import Foundation

public class ApiResultPaging<T:Codable>: Codable {
    var data: [T]?
    
    private enum CodingKeys : String, CodingKey {
        case data = "data"
    }
}


public class ApiResult<T:Codable>: Codable {
    var data: T?
}

public class ApiAhamoveResult<T:Codable>: Codable {
    var features: [T]?
}


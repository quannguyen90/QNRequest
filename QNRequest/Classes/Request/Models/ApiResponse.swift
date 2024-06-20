//
//  FABIResponse.swift
//  FabiManager
//
//  Created by quan nguyen on 10/9/19.
//  Copyright © 2019 quan nguyen. All rights reserved.
//

import Foundation

public class ApiResultPaging<T:Codable>: Codable {
    public var data: [T]?
    public var numResults: Int?
    
    private enum CodingKeys : String, CodingKey {
        case data = "data"
        case numResults = "num_results"
    }
    
    public init(data: [Codable]? = nil, numResults: Int? = nil) {
        self.data = data as! [T]
        self.numResults = numResults
    }
}


public class ApiResult<T:Codable>: Codable {
    public var data: T?
    
    public init(data: Codable? = nil) {
        self.data = data as! T
    }
}

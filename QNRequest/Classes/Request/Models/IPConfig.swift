//
//  IPConfig.swift
//  iPOSBilling
//
//  Created by quan nguyen on 2/13/20.
//  Copyright © 2020 quan nguyen. All rights reserved.
//

import UIKit

public class IPConfig: Codable {
    var key: String?
    var value: String?
    
    private enum CodingKeys : String, CodingKey {
        case key = "key"
        case value = "value"
    }
}

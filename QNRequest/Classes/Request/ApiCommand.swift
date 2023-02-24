//
//  ApiCommand.swift
//  BBB
//
//  Created by quannv on 1/2/17.
//  Copyright © 2017 quannv. All rights reserved.
//

import Foundation

public protocol ApiCommand {
    func excute<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ())
}

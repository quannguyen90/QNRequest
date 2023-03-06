//
//  ApiCommand.swift
//  BBB
//
//  Created by quannv on 1/2/17.
//  Copyright © 2017 quannv. All rights reserved.
//

import Foundation

public protocol ApiCommand {
    func excuteWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ())
    func excuteWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ())
    func excute<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ())
    func excuteWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ())
}

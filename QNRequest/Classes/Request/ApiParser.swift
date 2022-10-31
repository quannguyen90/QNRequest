//
//  ApiParser.swift
//  Ethereum
//
//  Created by Quan.nv on 8/2/18.
//  Copyright © 2018 Foodbook.vn. All rights reserved.
//

import UIKit
import Alamofire

public let NOTIFICATION_SESSION_EXPIRED = "NOTIFICATION_SESSION_EXPIRED"
public class ApiParser: NSObject {
    
    public class func parserResponseObject<T:Codable>(response: DataResponse<Any>, success:(T) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError(message: ERROR_MESSAGE_HTTP, code: ERROR_CODE_HTTP))
            return
        }
        
        if response.response?.statusCode == 401 {
            fail(ErrorApp.httpError(message: ERROR_MESSAGE_SESSION_EXPIRED, code: ERROR_CODE_SESSION_EXPIRED))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            return
        }
        
        if let JSON = response.result.value as? [String: Any] {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            if error.getCode() == ErrorApp.sessionExpired(message: nil).getCode()  {
                fail(ErrorApp.httpError(message: error.getMessage(), code: error.getCode()))
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }
    
    public class func parserResponse<T:Codable>(response: DataResponse<Any>, success:(ApiResult<T>) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError(message: ERROR_MESSAGE_HTTP, code: ERROR_CODE_HTTP))
            return
        }
        
        if response.response?.statusCode == 401 {
            fail(ErrorApp.httpError(message: ERROR_MESSAGE_SESSION_EXPIRED, code: ERROR_CODE_SESSION_EXPIRED))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            return
        }

        if let JSON = response.result.value as? [String: Any] {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(ApiResult<T>.self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            if error.getCode() == ErrorApp.sessionExpired(message: nil).getCode()  {
                fail(ErrorApp.httpError(message: error.getMessage(), code: error.getCode()))
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }
    
    public class func parserResponseList<T:Codable>(response: DataResponse<Any>, success:(_ listItem: [T]) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError(message: ERROR_MESSAGE_HTTP, code: ERROR_CODE_HTTP))
            return
        }
        
        if response.response?.statusCode == 401 {
            fail(ErrorApp.httpError(message: ERROR_MESSAGE_SESSION_EXPIRED, code: ERROR_CODE_SESSION_EXPIRED))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            return
        }

        if let JSON = response.result.value as? [String: Any] {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode([T].self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            if error.getCode() == ErrorApp.sessionExpired(message: nil).getCode()  {
                fail(ErrorApp.httpError(message: error.getMessage(), code: error.getCode()))
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }
    
    public class func parserResponseListPaging<T:Codable>(response: DataResponse<Any>, success:(ApiResultPaging<T>) -> (), fail: (ErrorApp) -> ()) {
        guard response.result.isSuccess else {
            fail(ErrorApp.httpError(message: ERROR_MESSAGE_HTTP, code: ERROR_CODE_HTTP))
            return
        }
        
        if response.response?.statusCode == 401 {
            fail(ErrorApp.httpError(message: ERROR_MESSAGE_SESSION_EXPIRED, code: ERROR_CODE_SESSION_EXPIRED))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            return
        }

        if let JSON = response.result.value as? [String: Any] {
            guard let error = ErrorApp.parserError(errorData: JSON) else {
                guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                    fail(ErrorApp.parserData)
                    return
                }
                
                guard let result = try? JSONDecoder().decode(ApiResultPaging<T>.self, from: data) else {
                    fail(ErrorApp.parserData)
                    return
                }
                success(result)
                return
            }
            
            if error.getCode() == ErrorApp.sessionExpired(message: nil).getCode()  {
                fail(ErrorApp.httpError(message: error.getMessage(), code: error.getCode()))
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            }
            
            fail(error)
        } else {
            fail(ErrorApp.parserData)
        }
    }

}


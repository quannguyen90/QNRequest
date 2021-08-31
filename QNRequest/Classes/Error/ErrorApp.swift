//
//  ErrorApp.swift
//  Ethereum
//
//  Created by APPLE on 8/3/18.
//  Copyright © 2018 Foodbook.vn. All rights reserved.
//

import UIKit

let ERROR_CODE_DEFAULT = 1000
let ERROR_MESSAGE_DEFAULT = NSLocalizedString("Có lỗi xảy ra, xin vui lòng kiểm tra lại", comment: "")

let ERROR_CODE_HTTP = 1001
let ERROR_MESSAGE_HTTP = NSLocalizedString("Lỗi kết nối, xin vui lòng kiểm tra lại kết nối của bạn và thử lại", comment: "")

let ERROR_CODE_LOGIN_FAILED = 1002
let ERROR_MESSAGE_LOGIN_FAILED = NSLocalizedString("Tài khoản hoặc mật khẩu không đúng", comment: "")

let ERROR_CODE_PARSER_DATA = 1003
let ERROR_MESSAGE_PARSER_DATA = NSLocalizedString("Có lỗi xảy ra, xin vui lòng kiểm tra lại", comment: "")

let ERROR_CODE_SESSION_EXPIRED = 1406
let ERROR_MESSAGE_SESSION_EXPIRED = NSLocalizedString("Phiên làm việc của bạn đã hết hạn, xin vui lòng đăng nhập lại", comment: "")

public enum ErrorApp: Error {
    
    case httpError(message: String?, code: Int)
    case defaultError(message: String?)
    case loginFailed(message: String?)
    case parserData
    case sessionExpired(message: String?)
    case errorData(message: String?, code: Int)
    
    public func isHttpError() -> Bool {
        switch self {
        case .defaultError:
            return false
            
        case .httpError(message: _, code: let _):
            return true
            
        case .loginFailed:
            return false
    
        case .parserData:
            return false
            
        case .sessionExpired:
            return false
        case .errorData(message: _, code: let _):
            return false
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .defaultError:
            return ERROR_CODE_DEFAULT
            
        case .httpError(message: _, code: let code):
            return code
            
        case .loginFailed:
            return ERROR_CODE_LOGIN_FAILED
    
        case .parserData:
            return ERROR_CODE_PARSER_DATA
            
        case .sessionExpired:
            return ERROR_CODE_SESSION_EXPIRED
        case .errorData(message: _, code: let code):
            return code
        }
    }
    
    public func getMessage() -> String {
        switch self {
        case .defaultError(message: let message):
            return message ??  ERROR_MESSAGE_DEFAULT
            
        case .httpError(message: let message, code: let _):
            return message ?? ERROR_MESSAGE_HTTP
            
        case .loginFailed(message: let message):
                return message ?? ERROR_MESSAGE_LOGIN_FAILED
            
        case .parserData:
            return ERROR_MESSAGE_PARSER_DATA
            
        case .sessionExpired(message: let message):
            return message ??  ERROR_MESSAGE_SESSION_EXPIRED

        case .errorData(message: let mes, code: _):
            return mes ??  ERROR_MESSAGE_SESSION_EXPIRED
        }
    }
    
    public static func parserError(errorData: [String: Any]) -> ErrorApp? {
        
        guard let data = errorData["error"] as? [String: Any] else {
            return nil
        }
 
        let errorMessage = data["message"] as? String
        let errorCode = data["code"] as? Int
        if errorCode == ERROR_CODE_SESSION_EXPIRED {
            return ErrorApp.sessionExpired(message: errorMessage)
        }
        
        if let code = errorCode {
            return ErrorApp.errorData(message: errorMessage, code: code)
        }

        return ErrorApp.defaultError(message: errorMessage)

    }
}

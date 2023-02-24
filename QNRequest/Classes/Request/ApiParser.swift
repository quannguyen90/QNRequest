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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_SESSION_EXPIRED), object: nil)
            return
        }

        if let JSON = response.result.value {
            if let dict = JSON as? [String: Any], let error = ErrorApp.parserError(errorData: dict) {
                fail(error)
                return
            }

            guard let data = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted) else {
                fail(ErrorApp.parserData)
                return
            }

            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                success(object)
            } catch let error as DecodingError {
                var errorMessage = ""
                switch error {
                case .typeMismatch(let key, let value):
                    errorMessage = "error \(key), value: \(value)"
                case .valueNotFound(let key, let value):
                    errorMessage = "error \(key), value \(value)"
                case .keyNotFound(let key, let value):
                    errorMessage = "error \(key), value \(value)"
                case .dataCorrupted(let key):
                    errorMessage = "error \(key)"
                default:
                    errorMessage = "ERROR: \(error.localizedDescription)"
                }

                print("Alamofire: Parsing Error = ", errorMessage , error.localizedDescription)
                print("Alamofire: Parsing DATA: \(String(decoding: data, as: UTF8.self))")
                if errorMessage != "" {
                    let mesg = ERROR_MESSAGE_DEFAULT + "(" + errorMessage + ")"
                    fail(ErrorApp.defaultError(message: mesg))
                } else {
                    fail(ErrorApp.parserData)
                }
            } catch {
                fail(ErrorApp.parserData)
            }

        } else {
            fail(ErrorApp.parserData)
        }
        
    }
}


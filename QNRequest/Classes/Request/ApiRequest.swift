//
//  ApiRequest.swift
//  BBB
//
//  Created by quannv on 1/2/17.
//  Copyright © 2017 quannv. All rights reserved.
//

import UIKit
import Alamofire


public enum ApiRequestType {
    case post
    case get
    case upload
    case put
}

public class ApiRequest: ApiCommand {
    
    var type: ApiRequestType = .get
    public var params: [String: Any] = [:]
    public var header: [String: String] = AppApiConstant.getAuthHeader()
    public var urlRequest = ""
    var image: UIImage?

    
    public init(urlRequest: String, type: ApiRequestType) {
        self.urlRequest = urlRequest
        self.type = type
    }
    
   public  func getParam() -> [String: Any] {
        return params
    }
    
    // MARK: response List Object paging
   public func excuteWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
               debugPrint("---------------- request ---------------")
               debugPrint("url: ", urlRequest)
               debugPrint("param: ", self.params)
               debugPrint("header: ", self.header)
               debugPrint("Type: ", self.type)

               switch type {
               case .get:
                   GETWithResponseListPaging(success: success, fail: fail)
                   
               case .post:
                   POSTWithResponseListPaging(success: success, fail: fail)
                   
               case .upload:
                   uploadImageWithResponseListPaging(image: image!, success: success, fail: fail)
                   
               case .put:
                   PUTWithResponseListPaging(success: success, fail: fail)

                   break
               }
    }
    
    func PUTWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POSTWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {

        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    func GETWithResponseListPaging<T:Codable>(success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        header["Content-Type"] = nil
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseListPaging(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
        
    func uploadImageWithResponseListPaging<T:Codable>(image: UIImage, success: @escaping (ApiResultPaging<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        guard let imageData = UIImagePNGRepresentation(image) else {return}
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            debugPrint("fffffff")
            let fileName = "image_\(Date().timeIntervalSince1970).png"
            let name = "image_data"
            let mimeType = "png"
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
                },
                         usingThreshold:UInt64.init(),
                         to:urlRequest,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                
                                upload.responseString(completionHandler: { (response) in
                                    print("responseString: \(response)")
                                })
                                
                                upload.responseJSON { response in
                                    ApiParser.parserResponseListPaging(response: response,
                                                            success: success,
                                                            fail: fail)
                                }
                            case .failure(let encodingError):
                                fail(ErrorApp.httpError)
                                print("uploadError: " + encodingError.localizedDescription)
                            }
        })
    }

    // MARK: response List Object
    public func excuteWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
               debugPrint("---------------- request ---------------")
               debugPrint("url: ", urlRequest)
               debugPrint("param: ", self.params)
               debugPrint("header: ", self.header)
               debugPrint("Type: ", self.type)

               switch type {
               case .get:
                   GETWithResponseList(success: success, fail: fail)
                   
               case .post:
                   POSTWithResponseList(success: success, fail: fail)
                   
               case .upload:
                   uploadImageWithResponseList(image: image!, success: success, fail: fail)
                   
               case .put:
                   PUTWithResponseList(success: success, fail: fail)

                   break
               }
    }
    
    func PUTWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseList(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POSTWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {

        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseList(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    func GETWithResponseList<T:Codable>(success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseList(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
        
    func uploadImageWithResponseList<T:Codable>(image: UIImage, success: @escaping (_ listItem: [T]) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            fail(ErrorApp.defaultError(message: nil))
            return
        }
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            debugPrint("fffffff")
            let fileName = "image.png"
            let name = "image_data"
            let mimeType = "png"
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
                },
                         usingThreshold:UInt64.init(),
                         to:urlRequest,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                
                                upload.responseString(completionHandler: { (response) in
                                    print("responseString: \(response)")
                                })
                                
                                upload.responseJSON { response in
                                    ApiParser.parserResponseList(response: response,
                                                            success: success,
                                                            fail: fail)
                                }
                            case .failure(let encodingError):
                                fail(ErrorApp.httpError)
                                print("uploadError: " + encodingError.localizedDescription)
                            }
        })
    }
    
    //MARK: - Response Object containt Data
    public func excute<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
        debugPrint("---------------- request ---------------")
        debugPrint("url: ", urlRequest)
        debugPrint("param: ", self.params)
        debugPrint("header: ", self.header)
        debugPrint("Type: ", self.type)

        switch type {
        case .get:
            GET(success: success, fail: fail)
            
        case .post:
            POST(success: success, fail: fail)
            
        case .upload:
            uploadImage(image: image!, success: success, fail: fail)
            
        case .put:
            PUT(success: success, fail: fail)

            break
        }
    }
    
    func PUT<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POST<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {

        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    func GET<T:Codable>(success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponse(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
        
    func uploadImage<T:Codable>(image: UIImage, success: @escaping (ApiResult<T>) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            fail(ErrorApp.defaultError(message: nil))
            return
        }
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            debugPrint("fffffff")
            let fileName = "image.png"
            let name = "image_data"
            let mimeType = "png"
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
                },
                         usingThreshold:UInt64.init(),
                         to:urlRequest,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                
                                upload.responseString(completionHandler: { (response) in
                                    print("responseString: \(response)")
                                })
                                
                                upload.responseJSON { response in
                                    ApiParser.parserResponse(response: response,
                                                            success: success,
                                                            fail: fail)
                                }
                            case .failure(let encodingError):
                                fail(ErrorApp.httpError)
                                print("uploadError: " + encodingError.localizedDescription)
                            }
        })
    }
    
    
    //MARK: - Response Object
    public func excuteWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
        debugPrint("---------------- request ---------------")
        debugPrint("url: ", urlRequest)
        debugPrint("param: ", self.params)
        debugPrint("header: ", self.header)
        debugPrint("Type: ", self.type)

        switch type {
        case .get:
            GETWithObject(success: success, fail: fail)
            
        case .post:
            POSTWithObject(success: success, fail: fail)
            
        case .upload:
            uploadImage(image: image!, success: success, fail: fail)
            
        case .put:
            PUTWithObject(success: success, fail: fail)

            break
        }
    }
    
    func PUTWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .put,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseObject(response: response,
                                     success: success,
                                     fail: fail)
        }
    }
    
    func POSTWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {

        let request = Alamofire.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: JSONStringArrayEncoding.init(array: []),
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseObject(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
    
    func GETWithObject<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        let request = Alamofire.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: header)
        
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseObject(response: response,
                                    success: success,
                                    fail: fail)
        }
    }
        
    func uploadImage<T:Codable>(image: UIImage, success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            return
        }
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            debugPrint("fffffff")
            let fileName = "image.png"
            let name = "image_data"
            let mimeType = "png"
            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
                },
                         usingThreshold:UInt64.init(),
                         to:urlRequest,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                
                                upload.responseString(completionHandler: { (response) in
                                    print("responseString: \(response)")
                                })
                                
                                upload.responseJSON { response in
                                    ApiParser.parserResponseObject(response: response,
                                                            success: success,
                                                            fail: fail)
                                }
                            case .failure(let encodingError):
                                fail(ErrorApp.httpError)
                                print("uploadError: " + encodingError.localizedDescription)
                            }
        })
    }
    
    
    
    func processResponse(response: DataResponse<Any>, success: ([String : Any]) -> (), fail: (ErrorApp) -> ()) {
        
    }
}

public struct JSONStringArrayEncoding: ParameterEncoding {
    private let array: [String]
    
    public init(array: [String]) {
        self.array = array
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        let data = try JSONSerialization.data(withJSONObject: parameters ?? [:], options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}




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
    case del
}

open class ApiRequest: NSObject, ApiCommand {
        
    public override init() {
        super.init()
    }
    
    var type: ApiRequestType = .get
    public var params: [String: Any] = [:]
    public var header: [String: String] = [:]
    public var urlRequest = ""
    public var image: UIImage?
    public var imageParameterName: String?
    public var imageName: String?

    func getParameterEncoding() -> ParameterEncoding {
        if type == .get {
            return URLEncoding.default
        }
        
        if header["Content-Type"] == "application/json" {
            return JSONStringArrayEncoding.init(array: [])
        }
        return URLEncoding.default
    }
    
     public init(urlRequest: String, type: ApiRequestType) {
        self.urlRequest = urlRequest
        self.type = type
    }
    
   open func getParam() -> [String: Any] {
        return params
    }
    
    //MARK: - Response Object containt Data
    public func excute<T:Codable>(success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        self.params = getParam()
        debugPrint("---------------- request ---------------")
        debugPrint("url: ", urlRequest)
        debugPrint("param: ", self.params)
        debugPrint("header: ", self.header)
        debugPrint("Type: ", self.type)
        
        if type == .upload {
            uploadImage(image: image!, success: success, fail: fail)
            return
        }
        
        var method: HTTPMethod = .get
        switch type {
        case .post:
            method = .post
        case .get:
            method = .get
        case .upload:
            method = .post
        case .put:
            method = .put
        case .del:
            method = .delete
        }

        let request = Alamofire.request(urlRequest,
                                        method: method,
                                        parameters: params,
                                        encoding: getParameterEncoding(),
                                        headers: header)
        request.responseJSON { (response) in
            debugPrint("response: ", response)
            ApiParser.parserResponseObject(response: response, success: success, fail: fail)
        }
        
    }
    
        
    func uploadImage<T:Codable>(image: UIImage, success: @escaping (T) -> (), fail: @escaping (ErrorApp) -> ()) {
        
        guard let imageData = image.pngData() else {
            fail(ErrorApp.defaultError(message: nil))
            return
        }
        
        let name = imageParameterName ?? "image_data"
        Alamofire.upload(multipartFormData:{ multipartFormData in
            debugPrint("fffffff")
            let fileName = self.imageName ?? "image_\(Date().timeIntervalSince1970).png"
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
                                upload.responseJSON { response in
                                    ApiParser.parserResponseObject(response: response,
                                                            success: success,
                                                            fail: fail)
                                }
                            case .failure(let encodingError):
                                fail(ErrorApp.httpError(message: ERROR_MESSAGE_HTTP, code: ERROR_CODE_HTTP))
                                print("uploadError: " + encodingError.localizedDescription)
                            }
        })
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

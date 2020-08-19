//
//  ViewController.swift
//  QNRequest
//
//  Created by quannv on 08/18/2020.
//  Copyright (c) 2020 quannv. All rights reserved.
//

import UIKit
import QNRequest

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchConfig(_ sender: Any) {
        ApiOperations.getConfig(success: { (res) in
            print(res)
        }) { (error) in
            print("error: ", error.getMessage())
        }
    }
    
    @IBAction func onTouchLogin(_ sender: Any) {
    }
}

// MARK: - ApiOperation
extension ApiOperations {
    static func login(_ email: String,
                              password: String,
                              success: @escaping (_ userInfo: ApiResult<IPUser>) -> (),
                              fail: @escaping (ErrorApp) -> ()) {
        let url = AppApiConstant.getUrlRequest(apiType: .auth, apiName: "login", version: "v1")
        let api = ApiRequest(urlRequest: url, type: .post)
        api.params["email"] = email
        api.params["password"] = password
        api.header["Content-Type"] = "application/x-www-form-urlencoded"
        api.excute(success: success, fail: fail)
    }
    
    static func getConfig(
           success: @escaping (_ userInfo: ApiResultPaging<IPConfig>) -> (),
           fail: @escaping (ErrorApp) -> ()) {
           
           let url = AppApiConstant.getUrlRequest(apiType: .common, apiName: "config", version: "v1")
           let api = ApiRequest(urlRequest: url, type: .get)
           api.excuteWithResponseListPaging(success: success, fail: fail)
       }

}

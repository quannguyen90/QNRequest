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
    @IBAction func onTouchGetList(_ sender: Any) {
        ApiOperations.getListItem(success: { (res) in
            print(res.data)
        }) { (error) in
            print("error: ", error.getMessage())
        }
    }
    
    @IBAction func onTouchGetId(_ sender: Any) {
        ApiOperations.getID(success: { (res) in
            print(res.data)
        }) { (error) in
            print("error: ", error.getMessage())
        }
    }
    @IBAction func getItem(_ sender: Any) {
        ApiOperations.getItem(success: { (res) in
            print(res.data)
        }) { (error) in
            print("error: ", error.getMessage())
        }
    }
    
    @IBAction func getDataList(_ sender: Any) {
        ApiOperations.getListItemArray(success: { (res) in
            print(res)
        }) { (error) in
            print("error: ", error.getMessage())
        }
    }

}

struct Data: Codable {
    var item_id: String
    var price: Double
    var qty: Double
}

// MARK: - ApiOperation
class ApiOperations {

    static func getListItem(
        success: @escaping (_ userInfo: ApiResultPaging<Data>) -> (),
        fail: @escaping (ErrorApp) -> ()) {
            let url = "https://b6f46830-5a2f-4c1c-97b8-0c9911f65390.mock.pstmn.io/get_list_item"
            let api = ApiRequest(urlRequest: url, type: .get)
            api.excute(success: success, fail: fail)
    }
    
    static func getID(
        success: @escaping (_ userInfo: ApiResult<String>) -> (),
        fail: @escaping (ErrorApp) -> ()) {
            let url = "https://e3628465-1934-491d-b90b-ef66f7d1a21a.mock.pstmn.io/get_id"
            let api = ApiRequest(urlRequest: url, type: .get)
            api.excute(success: success, fail: fail)
    }
    
    static func getItem(
        success: @escaping (_ userInfo: ApiResult<Data>) -> (),
        fail: @escaping (ErrorApp) -> ()) {
            let url = "https://e3628465-1934-491d-b90b-ef66f7d1a21a.mock.pstmn.io/get_item"
            let api = ApiRequest(urlRequest: url, type: .get)
            api.excute(success: success, fail: fail)
    }
    
    static func getListItemArray(
        success: @escaping (_ userInfo: [Data]) -> (),
        fail: @escaping (ErrorApp) -> ()) {
            let url = "https://e3628465-1934-491d-b90b-ef66f7d1a21a.mock.pstmn.io/response_list"
            let api = ApiRequest(urlRequest: url, type: .get)
            api.excute(success: success, fail: fail)
    }
    
}

//
//  ViewController.swift
//  QNRequest
//
//  Created by quannv on 08/18/2020.
//  Copyright (c) 2020 quannv. All rights reserved.
//

import UIKit
import QNRequest

// MARK: - Webservice api comminucation with server
enum ApiName: String {
    //App
    case register = "user"
    case loginFacebook = "login_facebook"
    case loginGoogle = "login_google"
    case loginByPhone = "login"
    case setPassword = "set_password"
    case forgotPassword = "forgot_password"
    case vat = "vat"
    case logout = "logout"
    case checkVoucher = "check_voucher"
    case address = "user_address"
    case appConfig = "setting/app_config"

    // merchant
    case getBrands = "brands"
    case getStoreCategories = "get_store_categories"
    case store = "get_store"
    case items = "items/get_items"
    case comment = "comments"
    case sendComment = "comment"
    case checkInExtraInfo = "checkin_extra_info"
    case checkIn = "checkin"
    case article = "article"
    case mapUserWallet = "login_wallet"
    case paserQrcode = "parser_qrcode"

    // wallet
    case getPosWallet = "checkpos"
    case walletSendTransaction = "send_point_transaction"
    case getBalance = "get_point_balance"
    case generateWalletTransactionToken = "generate_wallet_transaction_token"
    case listWallet = "list_wallet"

    // Notify
    case setNotifyToken = "set_notify_token"
    case getNotifyToken = "notify_user"
    case getNotifyDetail = "notify"
    case requestService = "request_service"

    //Order
    case order = "order"
    case getCurrentOrderTable = "current_table_order"
    case deliveryOrder = "delivery_order"
    case orderOnline = "order_online"
    case historyOrder = "order_history"
    case bookingOnline = "booking_online"
    case listOrderProcessing = "list_order_processing"
    case shipFee = "get_estimate_fee"

    // Foodbook
    case getQRCodeObject = "qr/get_qrcode"
    // transaction
    case getTransactionById = "check"
    case getHistory = "list"
    
    // User
    case checkUser = "checkuser"
    case generateSMSOtp = "generate_sms_otp"
    case verifySMSOtp = "verify_sms_otp"

    // Other
    case checkInFoodbook = "foodbook/checkin"
    case search = "search"
    case feedback = "feedback"
    case voucher = "voucher"
    case paymentMethod = "payment_methods"
}

enum ApiHeaderName: String {
    case accessToken = "accessToken"
    case userToken = "token"
}

enum ApiType: String {
    case user = "user"
    case report = "report"
    case catalogues = "catalogues"
    case none = ""
    case auth = "auth"
    case salerApp = "salerapp"
    case common = "common"
    case partner = "partner"
    case ipos = "ipos"
    case tool = "tool"
}

struct AppApiConstant {

    static var BASE_URL: String {
        get {
            let http = Bundle.main.infoDictionary!["HTTP_PROTOCOL"] as! String
            let url = Bundle.main.infoDictionary!["BASE_URL_API_ENDPOINT"] as! String
            return "\(http)://\(url)"
        }
    }
    
    static var ACCESS_TOKEN: String {
        get {
            let url = Bundle.main.infoDictionary!["ACCESS_TOKEN"] as! String
            return url
        }
    }
    
    static var SERVICE_PATH: String {
          get {
              let url = Bundle.main.infoDictionary!["SERVICE_PATH"] as! String
              return url
          }
    }
    

    static func getUrlRequest(apiType: ApiType, apiName: String, version: String) -> String {
        if apiType == .none {
            return BASE_URL + "/api/" + apiName
        }
        return BASE_URL + "/api/"  + apiType.rawValue + "/" + apiName
    }
    
    static func getAuthHeader() -> [String: String] {
        var header = [String: String]()
        header["Content-Type"] = "application/json"
        header[ApiHeaderName.accessToken.rawValue] = ACCESS_TOKEN
//        if let userToken = LocalData.local.getToken() {
//            header[ApiHeaderName.userToken.rawValue] = userToken
//        }
        return header
    }
}




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
class ApiOperations {
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

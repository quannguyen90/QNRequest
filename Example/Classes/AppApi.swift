//
//  AppApi.swift
//  QuickOrder
//
//  Created by MAC MINI  on 8/4/17.
//  Copyright © 2017 MAC MINI . All rights reserved.
//

import Foundation

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
    case accessToken = "access_token"
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
    
//http://testdw.ipos.vn/api/v1/login
    static func getUrlRequest(apiType: ApiType, apiName: String, version: String) -> String {
        if apiType == .none {
            return BASE_URL + "/api/" + "/" + apiName
        }
        return BASE_URL + "/api/"  + apiType.rawValue + "/" + apiName
    }
    
    static func getAuthHeader() -> [String: String] {
        var header = [String: String]()
        header["Content-Type"] = "application/json"
        header[ApiHeaderName.accessToken.rawValue] = ACCESS_TOKEN

        return header
    }
}



//
//  ContentView.swift
//  Widgets
//
//  Created by Webcash on 2022/12/13.
//

import UIKit
import SwiftUI
import ActivityKit
import WidgetKit

struct ContentView: View {
        
    let date = Date()
    @State var timeRemaining : Int = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var status: String = "test"
    @State private var refreshText = "QR <-> Barcode 전환 및 위젯, D.I 새로고침"
    
    @State private var token: String = ""
    
    
    @State var img = UIImage(named: "img_zeropay.png")!
    
    static var TRX_PWD = "61855b30564e62e821aa66adbd118b4b"
    
    static var userAgent = "Mozilla/5.0 (%@; U; CPU %@ %@ like Mac OS X; ko-kr) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148;nma-plf=IOS;nma-bizplay20=Y;nma-app-ver=1.6.4;nma-plf-ver=16.3.1;nma-model=iPhone;nma-app-id=com.webcash.bizzeropay;nma-app-cd=1a42751d95908c4856d0daf5b3ee7f14;nma-dev-id=4E3BF60C-ACF3-41AE-92C9-6DB0A0053D22;nma-netnm=LG U+;nma-phoneno=;nma-adr-id=;"
    
    var body: some View {
        VStack {
            CustomDynamicProgressView()
            Button(status) {
                // 로그인 토큰 발급 COM_000012
                if status == "로그인 토큰 발급" {
                    self.requestCOM_000012()
                } else if status == "로그인" {
                    self.requestLGN_000001()
                } else if status == "검증" {
                    self.requestCOM_000001()
                } else if status == "코드 발급" {
                    status = ""
                    self.requestZERO_000002()
                } else if status == "test" {
                    
                    UserDefaults.shared.set(true, forKey: "IS_QR")
                    let qrImageData = UIImage(named: "qr")!.jpegData(compressionQuality: 1.0)
                    UserDefaults.shared.set(qrImageData, forKey: "QR_IMAGE_DATA")
                    let barcodeImageData = UIImage(named: "barcode")!.jpegData(compressionQuality: 1.0)
                    UserDefaults.shared.set(barcodeImageData, forKey: "BARCODE_IMAGE_DATA")
                    
                    self.img = UIImage(data: qrImageData!)!.resize(newWidth: 100)
                    
                }
                
            }
            Image(uiImage: self.img)
            Button(refreshText) {
                let isQR = UserDefaults.shared.bool(forKey: "IS_QR")
                UserDefaults.shared.set(!isQR, forKey: "IS_QR")
                var imageData = Data()
                if !isQR {
                    imageData = UserDefaults.shared.data(forKey: "QR_IMAGE_DATA")!
                    self.img = UIImage(data: imageData)!.resize(newWidth: 100)
                } else {
                    imageData = UserDefaults.shared.data(forKey: "BARCODE_IMAGE_DATA")!
                    self.img = UIImage(data: imageData)!.resize(newWidth: 200)
                }
                
                SmartWidgetManager.shared.reloadAllWidgets()
                SmartLiveManager.shared.update(state: DynamicIslandWidgetAttributes.State(nowState: "Update", stateImg: "", time: 60))
            }
            Button("Start Dynamic Island") {
                SmartLiveManager.shared.start()
            }
            Button("Stop Dynamic Island") {
                SmartLiveManager.shared.stop()
            }
        }
    }
    
    func requestCOM_000012() {
        let requestBody = COM_000012.Request()
        
        Network.shared.fetch(url: "http://dev.biz-zero.bizplay.co.kr/COM_000012.jct", body: requestBody, responseType: COM_000012.Response.self) { result in
            switch result {
            case .failure(let error):
                print(#function + " \(error)에러요")
            case .success(let responseData):
                print(responseData.LGN_TOKEN)
                
                DispatchQueue.main.async {
                    self.status = "로그인"
                    self.token = responseData.LGN_TOKEN
                }
            }
        }
    }
    
    func requestLGN_000001() {
        let requestBody = LGN_000001.Request(LGN_TOKEN: token)
        Network.shared.fetch(url: "http://dev.biz-zero.bizplay.co.kr/LGN_000001.jct", body: requestBody, responseType: LGN_000001.Response.self) { result in
            switch result {
            case .failure(let error):
                print(#function + " \(error) 에러남")
            case .success(let responseData):
                DispatchQueue.main.async {
                    self.status = "검증"
                }
            }
        }
    }
    
    
    // http://dev.biz-zero.bizplay.co.kr/ZERO_000002.jct
    func requestZERO_000002() {
        Network.shared.fetch(url: "http://dev.biz-zero.bizplay.co.kr/ZERO_000002.jct", body: ZERO_000002.Request(TRX_PWD_YN: ContentView.TRX_PWD), responseType: ZERO_000002.Response.self) { result in
            switch result {
            case .failure(let error):
                print(#function + " \(error) 에러남")
            case .success(let responseObj):
                print(responseObj)
                DispatchQueue.main.async {
                    self.status = "BARCODE = \(responseObj.BAR_CODE)\nQRCODE = \(responseObj.QR_CODE)\n"
                    let isQR = UserDefaults.shared.bool(forKey: "IS_QR")
                    
                    // 데이터 저장
                    setData: do {
                        var imageData = CodeGenerator.generateCodeFromString(str: responseObj.QR_CODE, withType: .QR)!
                        UserDefaults.shared.set(imageData, forKey: "QR_IMAGE_DATA")
                        imageData = CodeGenerator.generateCodeFromString(str: responseObj.BAR_CODE, withType: .BARCODE)!
                        UserDefaults.shared.set(imageData, forKey: "BARCODE_IMAGE_DATA")
                    }
                    
                    if isQR {
                        let imageData = UserDefaults.shared.data(forKey: "QR_IMAGE_DATA")!
                        self.img = UIImage(data: imageData)!.resize(newWidth: 100)
                    } else {
                        let imageData = UserDefaults.shared.data(forKey: "BARCODE_IMAGE_DATA")!
                        self.img = UIImage(data: imageData)!.resize(newWidth: 200)
                    }
                    
                    self.refreshText = "위젯 새로고침 & QR, Barcode 전환"
                    SmartWidgetManager.shared.reloadAllWidgets()
                }
            }
        }
    }
    
    func requestCOM_000001() {
        Network.shared.fetch(url: "http://dev.biz-zero.bizplay.co.kr/COM_000001.jct", body: COM_000001.Request(), responseType: COM_000001.Response.self) { result in
            switch result {
            case .failure(let error):
                print(#function + " \(error) 에러남")
            case .success(let responseObj):
                print(responseObj)
                DispatchQueue.main.async {
                    self.status = "코드 발급"
                }
            }
        }
    }
    
    private func queryString<T:Encodable>(body:T) -> String {
        let request = body
        guard let str = request.asJSONString() else {
            return ""
        }
        return str
    }
}

///http://dev.biz-zero.bizplay.co.kr/COM_000012.jct
struct COM_000012 {
    struct Request: Encodable {
        let MEMB_CD = "c247ec92f34a7e864e256c477b5368894cfc0f000e030b8c91fa693084762eb4"
    }
    
    struct Response: Decodable {
        let LGN_TOKEN: String
    }
}

///http://dev.biz-zero.bizplay.co.kr/LGN_000001.jct
struct LGN_000001 {
    struct Request: Encodable {
        let MEMB_CD: String = "c247ec92f34a7e864e256c477b5368894cfc0f000e030b8c91fa693084762eb4"
        let PWD: String = ""
        let PUSH_TCK: String = "29be01053f4aec0cb66e5e3a1875056971e007482a40909483d829c869237994"
        let LGN_TOKEN: String
    }
    
    struct Response: Decodable {
        
    }
}

///http://dev.biz-zero.bizplay.co.kr/ZERO_000002.jct
struct ZERO_000002 {
    struct Request: Encodable {
        let USE_TP          : String = "PRVT"
        let CARD_NO         : String = "48802852401011"
        let TRX_PWD_YN      : String
        let TGT_YN          : String = ""
        let TGT_ORDER_DT    : String = ""
        let MNY_YN          : String = "N"
        let MNY_CHRG_ACCT_NO: String = ""
        let TGT_ORDER_ID    : String = ""
        let MNY_CHRG_BANK_CD: String = ""
        let BANK_CD         : String = "003"
    }
    
    struct Response: Decodable {
        let BAR_CODE: String
        let QR_CODE : String
    }
}

///https://zero.appplay.co.kr/COM_000001.jct
struct COM_000001 {
    struct Request: Encodable {
        let TRX_PWD = ""
        let BIO_USE_YN = ContentView.TRX_PWD
    }
    
    struct Response: Decodable {
        let ERROR_YN: String
        let ERROR_MSG: String
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

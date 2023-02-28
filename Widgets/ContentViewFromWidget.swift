//
//  ContentViewFromWidget.swift
//  Widgets
//
//  Created by Webcash on 2023/02/21.
//

import Foundation
import SwiftUI

struct ContentViewFromWidget: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Text("위젯을 통해 들어온 화면")
            
            let userDefaults = UserDefaults.shared
            
            let isQRCode = userDefaults.bool(forKey: "IS_QRCODE")
            
            let uiImage = getQRorBarcodeImage(codeType: isQRCode ? .QR : .BARCODE)
            let codeImage = Image(uiImage: uiImage)
            
            if isQRCode {
                codeImage
                    .frame(width: 200, height: 200)
            } else {
                codeImage
                    .frame(width: 200, height: 100)
            }
        }
    }
    
    func getQRorBarcodeImage(codeType: CodeType) -> UIImage {
        let userDefaults = UserDefaults.shared
        var data = Data()
        if userDefaults.bool(forKey: "IS_QRCODE") {
            data = userDefaults.data(forKey: "QR_IMAGE_DATA") ?? Data()
        } else {
            data = userDefaults.data(forKey: "BARCODE_IMAGE_DATA") ?? Data()
        }
        guard let uiImage = UIImage(data: data) else { return UIImage(named: "image_1_1")! }
        return uiImage
    }
    
}

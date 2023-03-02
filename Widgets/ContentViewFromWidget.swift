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
            
            let isQR = userDefaults.bool(forKey: "IS_QR")
            
            if isQR {
                let img = UIImage(data: userDefaults.data(forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 200)
                Image(uiImage: img)
            } else {
                let img = UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 200)
                Image(uiImage: img)
            }
        }
    }
    
}

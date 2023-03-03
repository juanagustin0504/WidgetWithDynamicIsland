//
//  ContentViewFromDynamicIsland.swift
//  Widgets
//
//  Created by Webcash on 2023/02/21.
//

import Foundation
import SwiftUI

struct ContentViewFromDynamicIsland: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Dynamic Island를 통해 들어온 화면")
            
            let userDefaults = UserDefaults.shared
            let isQR = userDefaults.bool(forKey: "IS_QR")
            if isQR {
                Image(uiImage: UIImage(data: userDefaults.data(forKey: "QR_IMAGE_DATA")!)!.resize(newWidth: 200))
            } else {
                Image(uiImage: UIImage(data: userDefaults.data(forKey: "BARCODE_IMAGE_DATA")!)!.resize(newWidth: 200))
            }
        }
    }
}

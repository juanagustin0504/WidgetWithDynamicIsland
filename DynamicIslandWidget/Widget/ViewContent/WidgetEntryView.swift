//
//  WidgetEntryView.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import UIKit
import SwiftUI
import WidgetKit

struct WidgetEntryView: View {
    let entry: WidgetEntry
    
    @Environment(\.widgetFamily) var family
    
    var dynamicSize: Float {
        switch family {
        case .systemSmall:
            return 150
        case .systemMedium:
            if UserDefaults.shared.bool(forKey: "IS_QR") {
                return 100
            }
            return 200
        default:
            return 300
        }
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            let type = UserDefaults.shared.bool(forKey: "IS_QR") ? "QR" : "BARCODE"
            let url = URL(string: "widget://\(type)")!
            Link(destination: url) {
                WidgetView(img: entry.imgList[0].resize(newWidth: CGFloat(dynamicSize)))
            }
        }
    }
}

struct WidgetView: View {
    let img: UIImage
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(uiImage: img)
        }
    }
}

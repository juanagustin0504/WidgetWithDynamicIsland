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
    
    var maxCount: Int {
        switch family {
        case .systemMedium:
            return 2
        default:
            representation()
            return 5
        }
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            let image = entry.imgList[0]
            WidgetView(img: image)
            Divider()
            let isQR = UserDefaults.shared.bool(forKey: "IS_QR")
            Text("HELLO\(isQR ? "1" : "2")")
        }
    }
    
    func representation() {
        UserDefaults.standard.dictionaryRepresentation().forEach { key, value in
            UserDefaults.shared.set(value, forKey: key)
        }
    }
}

struct WidgetView: View {
//    let pr: PullRequest.Response
    let img: UIImage
    
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(uiImage: img)
        }
//        VStack(alignment: .leading) {
//            Text(pr.title)
//                .font(.system(size: 18, weight: .semibold))
//                .foregroundColor(.black)
//
//            Spacer()
//                .frame(height: 4)
//
//            HStack {
//                Image(systemName: "star")
//
//                Divider()
//
//                Text(pr.date)
//                    .font(.system(size: 14, weight: .regular))
//                    .foregroundColor(.gray)
//            }.frame(height: 20)
//        }
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
//        DynamicIslandWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), texts: ["Hello"]))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        WidgetEntryView(entry: WidgetEntry(date: Date(), pr: [], imgList: []))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

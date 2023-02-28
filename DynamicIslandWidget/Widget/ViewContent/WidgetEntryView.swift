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
    
    @ViewBuilder
    var body: some View {
        VStack {
            WidgetView(img: entry.imgList[0])
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

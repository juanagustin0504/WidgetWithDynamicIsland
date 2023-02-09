//  DynamicIslandWidgetLiveActivity.swift
//  DynamicIslandWidget
//
//  Created by Webcash on 2022/12/13.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            ZStack {
//                randomColor.opacity(0.7)
                Color(.gray).opacity(0.1)
                LazyVStack { // Widget은 스크롤이 안되므로, List지원 x (대신 VStack 사용)
                    Text("Lock Screen Widget")
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    Image(systemName: "heart")
                    Image(systemName: "star")
//                    let imageData = UserDefaults.standard.data(forKey: "qr_image_data")
//                    let uiimage = UIImage(data: imageData!)!
//                    let testImage = UIImage(named: "img_zeropay")!
//                    Image(uiImage: testImage)
//                            .resizable()
//                            .frame(width: 100, height: 100)
                }.padding()
            }
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "star.fill")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                    Image(systemName: "heart")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
//                let imageData = UserDefaults.standard.data(forKey: "qr_image_data")
//                let uiimage = UIImage(data: imageData!)!
//                let testImage = UIImage(named: "img_zeropay")!
//                Image(uiImage: testImage)
//                    .resizable()
//                    .frame(width: 25, height: 25)
                
                Text("♡")
            } compactTrailing: {
                Image(systemName: "heart")
            } minimal: {
                VStack {
                    Image(systemName: "heart.fill")
                    Image(systemName: "heart")
//                    let imageData = UserDefaults.standard.data(forKey: "qr_image_data")
//                    let uiimage = UIImage(data: imageData!)!
//                    let testImage = UIImage(named: "img_zeropay")!
//                    Image(uiImage: testImage)
//                        .resizable()
//                        .frame(width: 50, height: 50)
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.cyan)
        }
    }
}

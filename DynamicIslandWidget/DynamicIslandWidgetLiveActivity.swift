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
                    Image("image_1_1")
                }.padding()
            }
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Button("Leading") {
                        print("Leading Clicked!")
                    }
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
                Text("♡")
            } compactTrailing: {
                Image(systemName: "heart")
            } minimal: {
                VStack {
                    Image(systemName: "heart.fill")
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

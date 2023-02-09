//
//  ContentView.swift
//  Widgets
//
//  Created by Webcash on 2022/12/13.
//

import UIKit
import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Start") {
                
//                let _ = SharedFunction.shared.setUserDefaultsValue("♡", forKey: "heart")
                
                let dynamicIslandWidgetAttributes = DynamicIslandWidgetAttributes(name: "test")
                let contentState = DynamicIslandWidgetAttributes.ContentState(value: 7)
                
                do {
                    let activity = try Activity<DynamicIslandWidgetAttributes>.request(
                        attributes: dynamicIslandWidgetAttributes,
                        contentState: contentState
                    )
                    print(activity)
                } catch {
                    print(error)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

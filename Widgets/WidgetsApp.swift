//
//  WidgetsApp.swift
//  Widgets
//
//  Created by Webcash on 2022/12/13.
//

import SwiftUI

@main
struct WidgetsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .onOpenURL { url in
                        print("url : \(url)")
                        if url.description.contains("widget") {
                            NavigationLink {
                                ContentViewFromWidget()
                            } label: {
                                Text("위젯")
                            }

                        }
                    }
            }
            
        }
    }
}

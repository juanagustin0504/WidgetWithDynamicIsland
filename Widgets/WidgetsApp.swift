//
//  WidgetsApp.swift
//  Widgets
//
//  Created by Webcash on 2022/12/13.
//

import SwiftUI

@main
struct WidgetsApp: App {
    @State var stack: [String] = []
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $stack) {
                ContentView()
                    .onOpenURL { url in
                        print("url : \(url.description)")
                        stack.append(url.description)
                    }
                    .navigationDestination(for: String.self) { str in
                        if str.contains("QR") || str.contains("BARCODE") {
                            ContentViewFromWidget()
                        } else {
                            ContentViewFromDynamicIsland()
                        }
                    }
            }
        }
    }
}

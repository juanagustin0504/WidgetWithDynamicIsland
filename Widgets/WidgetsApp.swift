//
//  WidgetsApp.swift
//  Widgets
//
//  Created by Webcash on 2022/12/13.
//

import SwiftUI
import BackgroundTasks

@main
struct WidgetsApp: App {
    @State var stack: [String] = []
    @Environment(\.scenePhase) private var phase
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
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .background: scheduleAppRefresh()
            default: break
            }
        }
        .backgroundTask(.appRefresh("myapprefresh")) { sender in
            print("sender ::::::: \(sender)\n")
            SmartLiveManager.shared.update(state: DynamicIslandWidgetAttributes.ContentState(nowState: "Update", stateImg: "star", time: 1))
        }
    }
    
    func scheduleAppRefresh() {
        
        let request = BGAppRefreshTaskRequest(identifier: "myapprefresh")
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

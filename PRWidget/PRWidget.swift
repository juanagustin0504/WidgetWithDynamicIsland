//
//  PRWidget.swift
//  PRWidget
//
//  Created by Webcash on 2023/02/09.
//

import WidgetKit
import SwiftUI

struct PRWidget: Widget {
    let kind: String = "CommitListWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PRProvider()) { entry in
            PRWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Commit List Widget")
        .description("Git Commit 내역을 볼 수 있는 위젯")
    }
}

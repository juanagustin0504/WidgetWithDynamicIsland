//
//  SmartWidget.swift
//  Widgets
//
//  Created by Webcash on 2023/01/11.
//

import SwiftUI
import WidgetKit

struct SmartWidget: Widget {
    static let kind: String = "SmartWidgetSample"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: SmartWidget.kind, provider: WidgetProvider()) { timelineEntry in
            WidgetEntryView(entry: timelineEntry)
        }
        .configurationDisplayName("Smart Widget")
        .description("Smart Widget Sample.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

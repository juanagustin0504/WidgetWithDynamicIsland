//
//  PREnrty.swift
//  Widgets
//
//  Created by Webcash on 2023/02/09.
//

import WidgetKit

struct PREntry: TimelineEntry {
    var date: Date = Date()
    let prList: [GitModel.Response.GitData]
}

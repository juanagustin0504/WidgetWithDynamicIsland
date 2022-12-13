//
//  DynamicIslandWidgetBundle.swift
//  DynamicIslandWidget
//
//  Created by Webcash on 2022/12/13.
//

import WidgetKit
import SwiftUI

@main
struct DynamicIslandWidgetBundle: WidgetBundle {
    var body: some Widget {
        DynamicIslandWidget()
        DynamicIslandWidgetLiveActivity()
    }
}

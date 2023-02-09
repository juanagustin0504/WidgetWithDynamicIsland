//
//  PREntryView.swift
//  Widgets
//
//  Created by Webcash on 2023/02/09.
//

import WidgetKit
import SwiftUI

struct PREntryView: View {
    let entry: PREntry
    
    @Environment(\.widgetFamily) var family
    
    var maxCount: Int {
        switch family {
        case .systemMedium:
            return 2
        default:
            return 5
        }
    }
    
    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<min(maxCount, entry.prList.count), id: \.self) { index in
                let pr = entry.prList[index]
                let url = URL(string: "widget://pr?url=\(pr.commit.url)")!
                Link(destination: url) {
                    PRView(pr: pr)
                    Divider()
                }
            }
        }
        .padding(.all, 16)
    }
}

struct PRView: View {
    let pr: GitModel.Response.GitData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pr.commit.message)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
                .frame(height: 4)
            
            HStack {
                Text(pr.commit.author.name)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
                
                Divider()
                
                Text(pr.commit.author.date)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }.frame(height: 20)
        }
    }
}


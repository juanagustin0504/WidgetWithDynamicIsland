//
//  DynamicIslandWidget.swift
//  DynamicIslandWidget
//
//  Created by Webcash on 2022/12/13.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), texts: ["EMPTY"])
    }

//    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration, texts: [])
//        completion(entry)
//    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        getTexts { texts in
            let entry = SimpleEntry(date: Date(), configuration: configuration, texts: texts)
            completion(entry)
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        getTexts { texts in
            let currentDate = Date()
            let entry = SimpleEntry(date: currentDate, configuration: configuration, texts: texts)
            let nextRefresh = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
            let timeline = Timeline(entries: [entry], policy: .after(nextRefresh))
            completion(timeline)
        }
        
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration, texts: [])
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
    }
    
    
    private func getTexts(completion: @escaping ([String]) -> ()) {
        // https://github.com/wh-iterabb-it/meowfacts
        guard
            let url = URL(string: "https://meowfacts.herokuapp.com/?count=1")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let textModel = try? JSONDecoder().decode(TextModel.self, from: data)
            else { return }
            completion(textModel.datas)
        }.resume()
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let texts: [String]
}

struct TextModel: Codable {
    enum CodingKeys : String, CodingKey {
        case datas = "data"
    }
    let datas: [String]
}

struct DynamicIslandWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct MyWidgetEntryView : View {
    var entry: Provider.Entry
    
    private var randomColor: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    
    @State var buttonText: String = ""
    
    var body: some View {
        ZStack {
            randomColor.opacity(0.7)
            ForEach(entry.texts, id: \.hashValue) { text in
                LazyVStack { // Widget은 스크롤이 안되므로, List지원 x (대신 VStack 사용)
                    Text(text)
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    Divider()
                    Image("image_1_1")
                    Divider()
                    Button(self.buttonText) {
                        
                    }
                }
            }
        }
    }
}

struct DynamicIslandWidget: Widget {
    let kind: String = "DynamicIslandWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("위젯 예제")
        .description("랜덤 텍스트를 불러오는 위젯 예제입니다")
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            DynamicIslandWidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
    }
}

struct DynamicIslandWidget_Previews: PreviewProvider {
    static var previews: some View {
        DynamicIslandWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), texts: ["Hello"]))
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}

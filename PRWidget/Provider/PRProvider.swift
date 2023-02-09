//
//  PRProvider.swift
//  Widgets
//
//  Created by Webcash on 2023/02/09.
//

import Foundation
import WidgetKit

struct PRProvider: TimelineProvider {
    typealias Entry = PREntry
    typealias Git = GitModel.Response.GitData
    
    func placeholder(in context: Context) -> PREntry {
        PREntry(date: Date(), prList: [])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PREntry) -> Void) {
        // Snapshot data
        let pr1 = Git(commit: Git.Commit(author: Git.Commit.Author(name: "moon-john", email: "moon-john@webcash.co.kr", date: "2023-02-09"), message: "Commit Message", url: ""))
        let entry = Entry(prList: [pr1])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PREntry>) -> Void) {
        let currentDate = Date()
        // 30분마다 refresh 하겠음
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        
        let git_url = URL(string: "https://api.github.com/juanagustin0504/WidgetWithDynamicIsland/commits")!
        URLSession.shared.dataTask(with: URLRequest(url: git_url)) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            guard let responseObject = try? JSONDecoder().decode(Git.self, from: data) else {
                
                let prList = Git(commit: Git.Commit(author:
                                        Git.Commit.Author(name: "데이터",
                                                          email: "가져오기",
                                                          date: "실패"),
                                                    message: "데이터 변환에 실패하였습니다.",
                                                    url: ""))
                let entry = Entry(date: currentDate,
                                  prList: [prList])
                let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
                completion(timeline)
                return
            }
            
            let entry = Entry(date: currentDate, prList: [responseObject])
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }.resume()
    }
    
}

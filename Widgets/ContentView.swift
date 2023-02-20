//
//  ContentView.swift
//  Widgets
//
//  Created by Webcash on 2022/12/13.
//

import UIKit
import SwiftUI
import ActivityKit
import WidgetKit

struct ContentView: View {
    
    typealias Git = GitResponse
    
    @State private var git: [Git] = []
    @State private var author: String = "Start"
    
    var body: some View {
        VStack {
            Button("위젯 새로고침") {
                WidgetCenter.shared.reloadAllTimelines()
            }
            Button(author) {
                
//                let _ = SharedFunction.shared.setUserDefaultsValue("♡", forKey: "heart")
                
                let url = URL(string: "https://api.github.com/repos/juanagustin0504/WidgetWithDynamicIsland/commits")!

                let request = URLRequest(url: url)

                URLSession.shared.dataTask(with: request) { (data, _, _) in
                    guard let data = data else {
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601

                    guard let responseObject = try? decoder.decode([GitResponse].self, from: data) else {
                        print("Hello")
                        let prList = Git(commit: Git.Commit(author:
                                                Git.Commit.Author(name: "데이터",
                                                                  email: "실패",
                                                                  date: "가져오기"),
                                                            message: "데이터 변환에 실패하였습니다.",
                                                            url: "실패"))
                        print(prList)

                        return
                    }

                    print(responseObject)
                    self.git = responseObject
                    self.author = responseObject[0].commit.author.name
                }.resume()
                
//                let network = Network()
//
//                let urlString = "https://api.github.com/repos/juanagustin0504/WidgetWithDynamicIsland/commits"
//                network.fetch(url: urlString) { result in
//                    switch result {
//                    case .success(let responseObj):
//                        guard let resObj = responseObj as? [GitResponse] else { return }
//                        print(resObj)
//
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
                
                
                let dynamicIslandWidgetAttributes = DynamicIslandWidgetAttributes(name: "test")
                let contentState = DynamicIslandWidgetAttributes.ContentState(value: 7)
                
                do {
                    let activity = try Activity<DynamicIslandWidgetAttributes>.request(
                        attributes: dynamicIslandWidgetAttributes,
                        contentState: contentState
                    )
                    print(activity)
                } catch {
                    print(error)
                }
            }
            VStack {
                ForEach(0..<git.count, id: \.self) { i in
                    Text(git[i].commit.message)
                }
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

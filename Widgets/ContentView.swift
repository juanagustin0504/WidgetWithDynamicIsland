//
//  ContentView.swift
//  Widgets
//
//  Created by Webcash on 2022/12/13.
//

import UIKit
import SwiftUI
import ActivityKit

struct ContentView: View {
    
    typealias Git = GitModel.Response.GitData
    
    var body: some View {
        VStack {
            Button("Start") {
                
//                let _ = SharedFunction.shared.setUserDefaultsValue("♡", forKey: "heart")
                
                let url = URL(string: "https://api.github.com/repos/juanagustin0504/WidgetWithDynamicIsland/commits")!
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let data = data else {
                        return
                    }
                    
                    guard let responseObject = try? JSONDecoder().decode(Git.self, from: data) else {
                        print("Hello")
                        let prList = Git(commit: Git.Commit(author:
                                                Git.Commit.Author(name: "데이터",
                                                                  email: "실패",
                                                                  date: "가져오기"),
                                                            message: "데이터 변환에 실패하였습니다.",
                                                            url: "실패"))
                        
                        return
                    }
                    
                    print(responseObject)
                    
                }.resume()
                
                
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
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

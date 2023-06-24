//
//  ContentView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct ContentView: View {
    let fileManager = ImageFileManager.shared
    let dbHelper = DBHelper.shared
    let model = Model.instance
    @State var selectedTab = 0
    
    
    var body: some View {
        TabView {
            
            HeckView()
                .tabItem {
                    Image(systemName: "exclamationmark.bubble.fill")
                    Text("Heck")
                }
            NiceView()
                .tabItem {
                    Image(systemName: "checkmark.bubble.fill")
                    Text("Nice")
                }
            IssueView()
                .tabItem {
                    Image(systemName: "questionmark.bubble.fill")
                    Text("Issue")
                }
        }
        .onAppear {
            dbHelper.createTable()
            let dbData = dbHelper.readData()
            dbData.map { data in
                if data.groupType == "Heck" {
                    model.heckList.append(
                        ListItem(
                            title: data.title,
                            image: fileManager.getSavedImage(named: "\(data.imageName)"),
                            description: data.description,
                            group: .Heck,
                            isFavorite: data.isFavorite == 0 ? false : true,
                            id: Int(data.id),
                            uid: data.uid
                        )
                    )
                } else if data.groupType == "Nice" {
                    model.niceList.append(
                        ListItem(
                            title: data.title,
                            image: fileManager.getSavedImage(named: "\(data.imageName)"),
                            description: data.description,
                            group: .Nice,
                            isFavorite: data.isFavorite == 0 ? false : true,
                            id: Int(data.id),
                            uid: data.uid
                        )
                    )
                } else if data.groupType == "Issue" {
                    model.issueList.append(
                        ListItem(
                            title: data.title,
                            image: fileManager.getSavedImage(named: "\(data.imageName)"),
                            description: data.description,
                            group: .Issue,
                            isFavorite: data.isFavorite == 0 ? false : true,
                            id: Int(data.id),
                            uid: data.uid
                        )
                    )
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

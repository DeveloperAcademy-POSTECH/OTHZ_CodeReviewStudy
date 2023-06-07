//
//  ContentView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct ContentView: View {
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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

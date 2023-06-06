//
//  ContentView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Heck")
                .tabItem {
                    Image(systemName: "exclamationmark.bubble.fill")
                    Text("Heck")
                }
            Text("Nice")
                .tabItem {
                    Image(systemName: "checkmark.bubble.fill")
                    Text("Nice")
                }
            Text("Issue")
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

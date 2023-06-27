//
//  FavoritesView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/16.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var listModel = ListModel.shared
    var groupType: GroupType = .heck
    let columns = [ GridItem(.adaptive(minimum: 170)) ]
    @State var gridList = ListModel.shared.heckList
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: columns) {
                ForEach($gridList, id: \.self) { $item in
                    if item.isFavorite == true {
                        NavigationLink {
                            ListItemView(item: $item)
                        } label: {
                            VStack(alignment: .leading) {
                                Image(uiImage: item.image ?? UIImage(named: "addItemDefault")!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 170, height: 170)
                                    .cornerRadius(10)
                                Text(item.title)
                                    .font(Font.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color.textBlack)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if groupType == .heck {
                gridList = ListModel.shared.heckList
            } else if groupType == .issue {
                gridList = ListModel.shared.issueList
            } else if groupType == .nice {
                gridList = ListModel.shared.niceList
            }
        }
        .navigationTitle("Favorites")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

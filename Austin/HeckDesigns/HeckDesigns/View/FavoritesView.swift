//
//  FavoritesView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/16.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var model = Model.instance
    var groupType: GroupType = .Heck
    let columns = [ GridItem(.adaptive(minimum: 170)) ]
    @State var gridList = Model.instance.heckList
    
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
            if groupType == .Heck {
                gridList = model.heckList
            } else if groupType == .Issue {
                gridList = model.issueList
            } else if groupType == .Nice {
                gridList = model.niceList
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

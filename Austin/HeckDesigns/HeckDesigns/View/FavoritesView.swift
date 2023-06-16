//
//  FavoritesView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/16.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var model = Model.instance
    let columns = [ GridItem(.adaptive(minimum: 170)) ]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: columns) {
                ForEach($model.heckList, id: \.self) { $item in
                    if item.isFavorite == true {
                        NavigationLink {
                            ListItemView(item: $item)
                        } label: {
                            VStack(alignment: .leading) {
                                Image(uiImage: item.image)
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
        .navigationTitle("Favorites")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

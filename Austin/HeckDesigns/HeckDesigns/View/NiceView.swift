//
//  NiceView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct NiceView: View {
    @State private var showAddModal = false
    @ObservedObject private var listModel = ListModel.shared
    
    private let columns = [GridItem(.adaptive(minimum: 170))]

    var body: some View {
        NavigationStack {
            ScrollView {
                FavoriteSampleView(groupType: .nice)
                
                LazyVGrid(columns: columns) {
                    ForEach($listModel.niceList, id: \.self) { $item in
                        NavigationLink {
                            ListItemView(item: $item)
                        } label: {
                            VStack(alignment: .leading) {
                                ZStack {
                                    Image(uiImage: item.image ?? UIImage(named: "addItemDefault")!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170, height: 170)
                                        .cornerRadius(10)
                                    if item.isFavorite == true {
                                        VStack {
                                            Spacer()
                                                .frame(height: 140)
                                            HStack {
                                                Spacer()
                                                    .frame(width: 140)
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(Color.white)
                                                    .opacity(0.9)
                                            }
                                        }
                                    }
                                }
                                Text(item.title)
                                    .font(Font.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color.textBlack)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddModal = true
                    } label: {
                        Label("Edit", systemImage: "plus")
                            .navButton()
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showAddModal) {
                AddItemView()
            }
            .navigationTitle("Nice")
        }
    }
}

struct NiceView_Previews: PreviewProvider {
    static var previews: some View {
        NiceView()
    }
}

//
//  HeckView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI


struct HeckView: View {
    @State private var showAddModal = false
    @ObservedObject private var model = ListModel.shared
    private let dbHelper = DBHelper.shared
    private let columns = [ GridItem(.adaptive(minimum: 170)) ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FavoriteSampleView(groupType: .heck)
                Button {
                    dbHelper.dropTable(tableName: "heckTable")
                } label: {
                    Text("drop table")
                }

                LazyVGrid(columns: columns) {
                    ForEach($model.heckList, id: \.self) { $item in
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
            .navigationTitle("Hecks")
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
            
        }
    }
}


struct HeckView_Previews: PreviewProvider {
    static var previews: some View {
        HeckView()
    }
}

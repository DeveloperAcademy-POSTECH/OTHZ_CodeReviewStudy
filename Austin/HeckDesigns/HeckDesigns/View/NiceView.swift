//
//  NiceView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct NiceView: View {
    @State var showAddModal = false
    @ObservedObject var model = Model.instance
    
    let columns = [
            GridItem(.adaptive(minimum: 170))
        ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach($model.niceList, id: \.self) { $item in
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
                AddItemView(selectedType: .Nice)
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

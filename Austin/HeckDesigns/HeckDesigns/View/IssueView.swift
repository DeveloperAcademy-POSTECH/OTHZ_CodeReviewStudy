//
//  IssueView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct IssueView: View {
    @State private var showAddModal = false
    @ObservedObject private var listModel = ListModel.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FavoriteSampleView(groupType: .issue)
                VStack {
                    ForEach($listModel.issueList, id: \.self) { $item in
                        NavigationLink {
                            ListItemView(item: $item)
                        } label: {
                            HStack (alignment: .top) {
                                Image(uiImage: item.image ?? UIImage(named: "addItemDefault")!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 170, height: 170)
                                    .cornerRadius(10)
                                Spacer()
                                    .frame(width: 15)
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .smallTitle()
                                        .foregroundColor(Color.textBlack)
                                    Divider()
                                    Text(item.description)
                                        .description()
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(5)
                                    
                                }
                            }
                        }
                    }
                }
                .padding()
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
            .navigationTitle("Issue")
        }
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        IssueView()
    }
}

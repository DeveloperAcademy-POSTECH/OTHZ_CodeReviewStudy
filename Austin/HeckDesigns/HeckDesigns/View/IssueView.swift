//
//  IssueView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct IssueView: View {
    @State var showAddModal = false
    @ObservedObject var model = Model.instance
//    let columns = [GridItem(.adaptive(minimum: 170))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach($model.issueList, id: \.self) { $item in
                        NavigationLink {
                            ListItemView(item: $item)
                        } label: {
                            HStack (alignment: .top) {
                                Image(uiImage: item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 170, height: 170)
                                    .cornerRadius(10)
                                Spacer()
                                    .frame(width: 20)
                                VStack {
                                    Text(item.title)
                                        .font(Font.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color.textBlack)
                                }
                                Spacer()       
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
                AddItemView(selectedType: .Issue)
            }
            .navigationTitle("Nice")
        }
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        IssueView()
    }
}

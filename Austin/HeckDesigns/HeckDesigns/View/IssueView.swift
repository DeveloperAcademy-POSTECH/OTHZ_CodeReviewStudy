//
//  IssueView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct IssueView: View {
    @ObservedObject var model = Model.instance
//    let columns = [GridItem(.adaptive(minimum: 170))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(model.issueList, id: \.self) { item in
                        NavigationLink {
                            ListItemView(item: item)
                        } label: {
                            HStack (alignment: .top) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 170, height: 170)
                                    .cornerRadius(10)
                                Spacer()
                                    .frame(width: 20)
                                VStack {
                                    Text(item.title)
                                        .font(Font.system(size: 20, weight: .bold))
                                        .foregroundColor(Color.black)
                                    
                                }
                                Spacer()
                                    
                            }
                        }
                    }
                }
                .padding()
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

//
//  HeckDetailView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import SwiftUI

struct HeckDetailView: View {
    var item: HeckItem
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image(item.imageName)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .detailViewImage()
            }
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .title()
                Divider()
                Spacer()
                    .frame(height: 20)
                ScrollView {
                    VStack {
                        Text(item.description)
                            .description()
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(item.title)
    }
}

struct HeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeckDetailView(item: HeckItem(title: "감성과 안전사이", imageName: "heck0", description: "안전은 어디에 있는가, 감성적인 분위기를 위해 너무 눈에 띄지 않는 문구는 열받게 한다 정말"))
    }
}

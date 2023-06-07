//
//  HeckView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct HeckItem: Hashable {
    var title: String
    var imageName: String
    var description: String = ""
    var id: Int
}

struct HeckView: View {
    @State var listSize = 4
    @State var heckList = [
        HeckItem(title: "감성과 안전사이", imageName: "heck0", id: 0),
        HeckItem(title: "아 뭘 사랑하냐고", imageName: "heck1", id: 1),
        HeckItem(title: "따뜻한 콜드브루", imageName: "heck2", id: 2),
        HeckItem(title: "취소할 권리", imageName: "heck3", id: 3),
        HeckItem(title: "선을 넘은 자", imageName: "heck4", id: 4),
        HeckItem(title: "손목 지압용 책상", imageName: "heck5", id: 5),
    ]
    let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(heckList, id: \.self) { item in
                        VStack(alignment: .leading) {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 170, height: 170)
                                .cornerRadius(10)
                            Text(item.title)
                                .font(Font.system(size: 20, weight: .bold))
                        }
                    }
                }
            }
            .navigationTitle("Colors")
        }
    }
}

struct HeckView_Previews: PreviewProvider {
    static var previews: some View {
        HeckView()
    }
}

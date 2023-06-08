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
    var id = UUID()
}

struct HeckView: View {
    @State var listSize = 4
    @State var heckList = [
        HeckItem(title: "감성과 안전사이", imageName: "heck0"),
        HeckItem(title: "아 뭘 사랑하냐고", imageName: "heck1"),
        HeckItem(title: "따뜻한 콜드브루", imageName: "heck2"),
        HeckItem(title: "취소할 권리", imageName: "heck3"),
        HeckItem(title: "선을 넘은 자", imageName: "heck4"),
        HeckItem(title: "손목 지압용 책상", imageName: "heck5"),
    ]
    let columns = [
            GridItem(.adaptive(minimum: 170))
        ]
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    
                    ForEach(heckList, id: \.self) { item in
                        NavigationLink {
                            HeckDetailView(item: item)
                        } label: {
                            VStack(alignment: .leading) {
                                Image(item.imageName)
                                    .resizable()
                                    .frame(width: 170, height: 170)
                                    .cornerRadius(10)
                                Text(item.title)
                                    .font(Font.system(size: 20, weight: .bold))
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Hecks")
        }
    }
}

struct HeckView_Previews: PreviewProvider {
    static var previews: some View {
        HeckView()
    }
}

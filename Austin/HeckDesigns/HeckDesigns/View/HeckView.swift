//
//  HeckView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI



struct HeckView: View {

    @ObservedObject var model = Model.instance
    
    let columns = [
            GridItem(.adaptive(minimum: 170))
        ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    
                    ForEach(model.heckList, id: \.self) { item in
                        NavigationLink {
                            ListItemView(item: item)
                        } label: {
                            VStack(alignment: .leading) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFill()
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

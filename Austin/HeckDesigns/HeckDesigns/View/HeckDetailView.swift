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
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.system(.title))
                .fontWeight(.bold)
            
            Image(item.imageName)
                .resizable()
                .frame(width: .infinity)
                .scaledToFit()
        }
        .padding()
    }
}

//struct HeckDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeckDetailView()
//    }
//}

//
//  HeckView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/06.
//

import SwiftUI

struct HeckView: View {
    @State var listSize = 4
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Image("heck0")
                            .resizable()
                            .frame(width: 170, height: 170)
                            .cornerRadius(10)
                        Text("감성과 안전 사이")
                            .font(Font.system(size: 20, weight: .bold))
                    }
                    VStack(alignment: .leading) {
                        Image("heck1")
                            .resizable()
                            .frame(width: 170, height: 170)
                            .cornerRadius(10)
                        Text("아 뭘 사랑하냐고")
                            .font(Font.system(size: 20, weight: .bold))
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        Image("heck2")
                            .resizable()
                            .frame(width: 170, height: 170)
                            .cornerRadius(10)
                        Text("따뜻한 콜드브루란..")
                            .font(Font.system(size: 20, weight: .bold))
                    }
                    VStack(alignment: .leading) {
                        Image("heck1")
                            .resizable()
                            .frame(width: 170, height: 170)
                            .cornerRadius(10)
                        Text("아 뭘 사랑하냐고")
                            .font(Font.system(size: 20, weight: .bold))
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

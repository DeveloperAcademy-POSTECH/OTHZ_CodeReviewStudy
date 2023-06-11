//
//  Model.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import Foundation


struct HeckItem: Hashable {
    var title: String
    var imageName: String
    var description: String = ""
    var id = UUID()
}

class HeckModel: ObservableObject {
    static let instance = HeckModel()
    private init(){}
    
    @Published var heckList = [
        HeckItem(title: "감성과 안전사이", imageName: "heck0", description: "안전은 어디에 있는가, 감성적인 분위기를 위해 너무 눈에 띄지 않는 문구는 열받게 한다 정말"),
        HeckItem(title: "아 뭘 사랑하냐고", imageName: "heck1"),
        HeckItem(title: "따뜻한 콜드브루", imageName: "heck2", description: "따듯하게 콜드브루를 마실 수도 있다. 하지만 차가운 콜드브루는 왜 없는 것인가."),
        HeckItem(title: "취소할 권리", imageName: "heck3"),
        HeckItem(title: "선을 넘은 자", imageName: "heck4"),
        HeckItem(title: "손목 지압용 책상", imageName: "heck5"),
    ]
}

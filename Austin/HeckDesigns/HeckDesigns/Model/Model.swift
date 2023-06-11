//
//  Model.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import Foundation

enum HeckGroup: String {
    case Heck
    case Nice
    case Issue
}

struct HeckItem: Hashable {
    var title: String
    var imageName: String
    var description: String = ""
    var group: HeckGroup
    var id = UUID()
}

class HeckModel: ObservableObject {
    static let instance = HeckModel()
    private init(){}
    
    @Published var heckList = [
        HeckItem(
            title: "감성과 안전사이",
            imageName: "heck0",
            description: "안전은 어디에 있는가, 감성적인 분위기를 위해 너무 눈에 띄지 않는 문구는 열받게 한다 정말",
            group: .Heck
        ),
        HeckItem(
            title: "아 뭘 사랑하냐고",
            imageName: "heck1",
            description: "뜬금없는 당신의 사랑고백. 공공장소에서 맥락 없는 사랑고백 성공 확률에 대한 구글링 한번만 했었다면...",
            group: .Heck
        ),
        HeckItem(
            title: "따뜻한 콜드브루",
            imageName: "heck2",
            description: "따듯하게 콜드브루를 마실 수도 있다. 하지만 차가운 콜드브루는 왜 없는 것인가.",
            group: .Heck
        ),
        HeckItem(
            title: "취소할 권리",
            imageName: "heck3",
            description: "너는 고르기 전에는 나갈 수 없다. 당신이 비록 고객이라 할지라도.",
            group: .Heck
        ),
        HeckItem(
            title: "선을 넘은 자",
            imageName: "heck4",
            description: "넘지 말아야할 선을 넘으면 불편하다. 넘지 말야야 하는 것은 넘지 말자",
            group: .Heck
        ),
        HeckItem(
            title: "손목 지압용 책상",
            imageName: "heck5",
            description: "공부보다는 감성이 먼저입니다. 하지만 감성마저 챙기지 못한...",
            group: .Heck
        ),
    ]
}

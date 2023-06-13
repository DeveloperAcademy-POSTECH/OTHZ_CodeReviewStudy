//
//  Model.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import Foundation

enum GroupType: String {
    case Heck
    case Nice
    case Issue
}

struct ListItem: Hashable {
    var title: String
    var imageName: String
    var description: String = ""
    var group: GroupType
    var id = UUID()
}

class Model: ObservableObject {
    static let instance = Model()
    private init(){}
    
    @Published var heckList = [
        ListItem(
            title: "감성과 안전사이",
            imageName: "heck0",
            description: "안전은 어디에 있는가, 감성적인 분위기를 위해 너무 눈에 띄지 않는 문구는 열받게 한다 정말",
            group: .Heck
        ),
        ListItem(
            title: "아 뭘 사랑하냐고",
            imageName: "heck1",
            description: "뜬금없는 당신의 사랑고백. 공공장소에서 맥락 없는 사랑고백 성공 확률에 대한 구글링 한번만 했었다면...",
            group: .Heck
        ),
        ListItem(
            title: "따뜻한 콜드브루",
            imageName: "heck2",
            description: "따듯하게 콜드브루를 마실 수도 있다. 하지만 차가운 콜드브루는 왜 없는 것인가.",
            group: .Heck
        ),
        ListItem(
            title: "취소할 권리",
            imageName: "heck3",
            description: "너는 고르기 전에는 나갈 수 없다. 당신이 비록 고객이라 할지라도.",
            group: .Heck
        ),
        ListItem(
            title: "선을 넘은 자",
            imageName: "heck4",
            description: "넘지 말아야할 선을 넘으면 불편하다. 넘지 말야야 하는 것은 넘지 말자",
            group: .Heck
        ),
        ListItem(
            title: "손목 지압용 책상",
            imageName: "heck5",
            description: "공부보다는 감성이 먼저입니다. 하지만 감성마저 챙기지 못한...",
            group: .Heck
        ),
    ]
    
    @Published var niceList = [
        ListItem(
            title: "다정한 기다림",
            imageName: "nice0",
            description: "흰 화면을 10초동안 보는 것은 정말 마음을 어렵게 한다. 스켈레톤 UI는 1초 이상의 기다림에 대해 로딩에 대한 친절한 안내를 제공해준다.",
            group: .Nice
        ),
        ListItem(
            title: "완벽한 구매 경험",
            imageName: "nice1",
            description: "유니클로의 결제 프로세스는 아름답다. 바구나에 담은 제품을 그저 Container에 올려두기만하면 제품을 자동으로 스캔해서 바로 결제가 진행된다. 점원을 만나지 않고 스캔도 없이 쉽고 빠르게 옷을 구입할 수 있는 기분좋은 구매 경험이었다.",
            group: .Nice
        ),
    ]
    
    @Published var issueList = [
        ListItem(
            title: "베라 매장용 컵",
            imageName: "issue0",
            description: "매장용 컵에 위와 같이 매장용 컵에 대한 안내를 붙였다. 확실한 방법이긴하나 투썸과 같이 자체 컵에 프린팅을 하는 방법도 있을 것 같은데 과연 매장용 컵 표시에 대한 최선의 솔루션이었을까?",
            group: .Issue
        ),
    ]
}

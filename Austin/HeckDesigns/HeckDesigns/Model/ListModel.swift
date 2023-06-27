//
//  Model.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import SwiftUI

enum GroupType: String {
    case heck
    case nice
    case issue
    
    var groupName: String {
        self.rawValue.capitalized
    }
    func changeStringToGroupType(beChanged: String) -> GroupType {
        if beChanged == "heck" {
            return .heck
        } else if beChanged == "nice" {
            return .nice
        } else {
            return .issue
        }
    }
}

struct ListItem: Hashable {
    var title: String
    var image: UIImage? = UIImage(named: "addItemDefault")
    var description: String = ""
    var group: GroupType
    var isFavorite = false
    var id: Int
    var uid: String
}

class ListModel: ObservableObject {
    static let shared = ListModel()
    private init(){}
    
    @Published var heckList = [
        ListItem(
            title: "감성과 안전사이",
            image: UIImage(named: "heck0")!,
            description: "안전은 어디에 있는가, 감성적인 분위기를 위해 너무 눈에 띄지 않는 문구는 열받게 한다 정말",
            group: .heck,
            isFavorite: true,
            id: 0,
            uid: "124"
        ),
//        ListItem(
//            title: "아 뭘 사랑하냐고",
//            image: UIImage(named: "heck1")!,
//            description: "뜬금없는 당신의 사랑고백. 공공장소에서 맥락 없는 사랑고백 성공 확률에 대한 구글링 한번만 했었다면...",
//            group: .Heck,
//            id: 1
//        ),
//        ListItem(
//            title: "따뜻한 콜드브루",
//            image: UIImage(named: "heck2")!,
//            description: "따듯하게 콜드브루를 마실 수도 있다. 하지만 차가운 콜드브루는 왜 없는 것인가.",
//            group: .Heck,
//            isFavorite: true,
//            id: 2
//        ),
//        ListItem(
//            title: "취소할 권리",
//            image: UIImage(named: "heck3")!,
//            description: "너는 고르기 전에는 나갈 수 없다. 당신이 비록 고객이라 할지라도.",
//            group: .Heck,
//            id: 3
//        ),
//        ListItem(
//            title: "선을 넘은 자",
//            image: UIImage(named: "heck4")!,
//            description: "넘지 말아야할 선을 넘으면 불편하다. 넘지 말야야 하는 것은 넘지 말자",
//            group: .Heck,
//            id: 4
//        ),
//        ListItem(
//            title: "손목 지압용 책상",
//            image: UIImage(named: "heck5")!,
//            description: "공부보다는 감성이 먼저입니다. 하지만 감성마저 챙기지 못한...",
//            group: .Heck,
//            id: 5
//        ),
//        ListItem(
//            title: "기회 단 ?번뿐",
//            image: UIImage(named: "heck6")!,
//            description: "그린카에서 인증을 하는데 몇번 인증을 할 수 있는지 알려주지 않고 인증 횟수가 초과되었다고 말해준다. 얼마 후에 다시 인증을 할 수 있는지도 안알려줘서 그린카 앱을 삭제하고 싶어진다. 어째서 이런 사용성을 만든 것일까?",
//            group: .Heck,
//            id: 6
//        ),
//        ListItem(
//            title: "인생은 실전이다",
//            image: UIImage(named: "heck7")!,
//            description: "그린카에서 비밀번호를 재설정해야 했다. 하지만 재설정 오류라고 뜨면서 다시 처음부터 사용자 인증 페이지로 이동하게 되었다. 비밀번호 재설정이 틀렸다고 로그인페이지로 이동하는 사용성은 태어나서 처음이다. 그린카는 서비스를 하고 싶은걸까. 아님 UX 디자이너가 그린카를 망하게 하고 싶은걸까.",
//            group: .Heck,
//            id: 7
//        ),
    ]
    
    @Published var niceList = [
        ListItem(
            title: "다정한 기다림",
            image: UIImage(named: "nice0")!,
            description: "흰 화면을 10초동안 보는 것은 정말 마음을 어렵게 한다. 스켈레톤 UI는 1초 이상의 기다림에 대해 로딩에 대한 친절한 안내를 제공해준다.",
            group: .nice,
            isFavorite: true,
            id: 0,
            uid: "53151"
        ),
//        ListItem(
//            title: "완벽한 구매 경험",
//            image: UIImage(named: "nice1")!,
//            description: "유니클로의 결제 프로세스는 아름답다. 바구나에 담은 제품을 그저 Container에 올려두기만하면 제품을 자동으로 스캔해서 바로 결제가 진행된다. 점원을 만나지 않고 스캔도 없이 쉽고 빠르게 옷을 구입할 수 있는 기분좋은 구매 경험이었다.",
//            group: .Nice,
//            id: 1
//        ),
//        ListItem(
//            title: "지도는 네이버",
//            image: UIImage(named: "nice2")!,
//            description: "머리를 하기 위해 집 근처에 헤어샵을 네이버로 예약했다. 네이버 지도에 내가 예약한 헤어샵 위치에 예약한 날짜와 시간을 알려주었다. 네이버는 예약 당일에 푸시로 예약 내용을  알려주는데 이렇게 위치에 따라 예약한 시간을 알려줌으로 여러 예약과 일정이 있을 경우 더 쉽게 계획을 세울 수 있다는 점에서 좋은 사용성 경험을 제공해준다.",
//            group: .Nice,
//            isFavorite: true,
//            id: 2
//        ),
    ]
    
    @Published var issueList = [
        ListItem(
            title: "베라 매장용 컵",
            image: UIImage(named: "issue0")!,
            description: "매장용 컵에 위와 같이 매장용 컵에 대한 안내를 붙였다. 확실한 방법이긴하나 투썸과 같이 자체 컵에 프린팅을 하는 방법도 있을 것 같은데 과연 매장용 컵 표시에 대한 최선의 솔루션이었을까?",
            group: .issue,
            isFavorite: true,
            id: 3,
            uid: "53151"
        ),
    ]
}

enum Gender {
    case male
    case female
}

struct Person {
    var name: String
    var age: Int
    var gender: Gender
    init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
}

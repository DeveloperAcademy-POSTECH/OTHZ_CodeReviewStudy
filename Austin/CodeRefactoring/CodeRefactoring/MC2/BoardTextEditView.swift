//
//  BoardTextEditView.swift
//  CodeRefactoring
//
//  Created by Seungui Moon on 2023/05/30.
//

import SwiftUI

struct FontName : Hashable {
    var korName: String
    var engName: String
}

struct BoardTextEditView: View {
    
    @Environment(\.displayScale) var displayScale
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var data: TutorialBoardElement
    @EnvironmentObject var FUUID: FocusUUID
    
    let fontList = ["JalnanOTF", "Pilseung Gothic Regular"]
    let fontArr: [FontName] = [
        FontName(
            korName: "필승 고딕",
            engName: "Pilseung Gothic Regular"),
        FontName(
            korName: "여기어때",
            engName: "JalnanOTF"),
        FontName(
            korName: "흘돋체",
            engName: "GabiaHeuldot"),
        FontName(
            korName: "더잠실",
            engName: "The Jamsil OTF 4 Medium"),
    ]
    
    let colorArr: [Color] = ColorPreset.colorPallete
    
    @State var colorNum = 0
    @State private var fullText: String = ""
    @State var fontSize: Double = 20.0
    @State var fontColor: Color = .black
    @State var selectedFont = "Pilseung Gothic Regular"
    @State var renderedImage: UIImage?
    

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $fullText)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                    .multilineTextAlignment(.leading)
                    .foregroundColor(fontColor)
                    .font(Font.custom(selectedFont,  size: fontSize))
                    .lineSpacing(5)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("cancel")
                                .onTapGesture {
                                    /// BoardEditView로 이동
                                    dismiss()
                                }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Text(.init(systemName: "checkmark"))
                                .onTapGesture {
                                    /// 이미지 렌더
                                    self.renderImage(text: fullText)
                                    guard let generatedImage = renderedImage else{
                                        return
                                    }
                                    /// BoardEditView로 renderImage 전달
                                    data.viewArr.append(BoardElement.init(imagePosition: CGPoint(x:UserDefaults.standard.double(forKey: "TutorialBoardWidthCenter") , y: UserDefaults.standard.double(forKey: "TutorialBoardHeightCenter")), imageWidth: (generatedImage.size.width > generatedImage.size.height) ?  200 : (generatedImage.size.width / generatedImage.size.height * 200), imageHeight: (generatedImage.size.width > generatedImage.size.height) ? (generatedImage.size.height / generatedImage.size.width * 200) : 200, angle: .degrees(0), angleSum: 0, picture: Image(uiImage: generatedImage)))
                                    /// 보드 뷰로 이동
                                    FUUID.focusUUID = data.viewArr.last!.id
                                    dismiss()
                                }
                        }
                        
                    }
                    .foregroundColor(.green)

                /// font 선택
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(fontArr, id: \.self) { fontItem in
                            VStack {
                                Text(fontItem.korName)
                                    .font(Font.custom(fontItem.engName,  size: 20))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 60)
                            .background(selectedFont == fontItem.engName ? .brown : .white)
                            .foregroundColor(selectedFont == fontItem.engName ? .white : .black)
                            .cornerRadius(CGFloat(10))
                            .onTapGesture {
                                selectedFont = fontItem.engName
                            }
                        }
                    }
                }
                
                
                /// fontColor 선택
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack {
                        ForEach(0..<colorArr.count, id: \.self) { colorIndex in
                            Circle()
                                .frame(width: colorNum == colorIndex ? 40 : 30)
                                .foregroundColor(colorArr[colorIndex])
                                .onTapGesture {
                                    fontColor = colorArr[colorIndex]
                                    withAnimation(.easeInOut(duration: 0.36)) {
                                        colorNum = colorIndex
                                    }
                                }
                        }
                    }
                }
                
                /// fontSize 선택
                HStack {
                    Text("a")
                    Slider(value: $fontSize, in: 10...50, step: 1)
                    Text("A")
                }
            
            }
            .padding()
        }
    }
}

/// Text to Image
struct RenderView: View {
    let text: String
    let fontType: String
    let color: Color

    var body: some View {
        Text(text)
            .font(Font.custom(fontType,  size: 200))
            .foregroundColor(color)
    }
}

extension BoardTextEditView {

    @MainActor func renderImage(text: String = ""){
        let renderer = ImageRenderer(
            content: RenderView(
                text: text,
                fontType: self.selectedFont,
                color: self.fontColor
            )
        )
        
        renderer.scale = displayScale
        if let uiImage = renderer.uiImage {
            renderedImage = uiImage
        }
    }
}

struct TutorialTextEditView_Previews: PreviewProvider {
    static var previews: some View {
        BoardTextEditView()
    }
}


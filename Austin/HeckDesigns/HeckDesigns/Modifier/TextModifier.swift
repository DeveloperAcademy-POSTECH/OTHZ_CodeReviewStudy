//
//  TextModifier.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/11.
//

import SwiftUI

struct TitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title))
            .fontWeight(.semibold)
            .foregroundColor(Color.textBlack)
    }
}

struct DescriptionTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Apple SD Gothic Neo", size: 16))
            .fontWeight(.medium)
            .foregroundColor(Color.textBlack)
            .lineSpacing(6)
    }
}


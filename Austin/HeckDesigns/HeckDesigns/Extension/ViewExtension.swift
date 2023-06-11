//
//  ViewExtension.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/11.
//

import SwiftUI

extension View {
    func detailViewImage() -> some View{
        modifier(ImageDetailViewModifier())
    }
    
    func title() -> some View {
        modifier(TitleTextModifier())
    }
    
    func description() -> some View {
        modifier(DescriptionTextModifier())
    }
}


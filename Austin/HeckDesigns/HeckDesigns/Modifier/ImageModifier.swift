//
//  ImageDetailMainView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/11.
//

import SwiftUI

struct ImageDetailViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .cornerRadius(10)
            .shadow(radius: 4)
            .padding()
    }
}

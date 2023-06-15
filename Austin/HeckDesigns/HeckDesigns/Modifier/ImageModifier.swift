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
            .padding(.top, 10)
            .shadow(radius: 4)
            
            
    }
}

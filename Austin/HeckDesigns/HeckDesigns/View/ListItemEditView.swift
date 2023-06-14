//
//  ListItemEditView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/13.
//

import SwiftUI

struct ListItemEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var item: ListItem
    
    
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image(uiImage: item.image)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .detailViewImage()
            }
            
            VStack(alignment: .leading) {
                TextField("제목",text: $item.title)
                    .title()
                Divider()
                Spacer()
                    .frame(height: 20)
                ScrollView {
                    VStack {
                        TextField("설명",text: $item.description, axis: .vertical)
                            .description()
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(item.group.rawValue)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .navButton()
                        .foregroundColor(Color.red)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .navButton()
                }
            }
        }
    }
}

//
//  HeckDetailView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/08.
//

import SwiftUI

struct ListItemView: View {
    enum Field: Hashable {
        case title, description
    }
    @State var isEdit = false
    @Binding var item: ListItem
    @State var title = ""
    @State var description = ""
    @FocusState private var focusField: Field?
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image(uiImage: item.image)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .detailViewImage()
            }
            
            
            VStack(alignment: .leading) {
                if isEdit == true {
                    TextField("제목", text: $title, axis: .vertical)
                        .title()
                        .padding(.bottom, 9)
                        .focused($focusField, equals: .title)
                        .submitLabel(.next)
                        
                } else {
                    Text(title)
                        .title()
                }
                
                Divider()
                Spacer()
                    .frame(height: 20)
                ScrollView {
                    VStack {
                        if isEdit == true {
                            TextField("설명", text: $description, axis: .vertical)
                                .description()
                                .focused($focusField, equals: .description)
                        } else {
                            Text(description)
                                .description()
                        }
                    }
                }
                if isEdit == true {
                    Button {
                        
                    } label: {
                        Text("delete")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.bgGrayLight)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(item.group.rawValue)
        .toolbar {
            if isEdit == true {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.title = item.title
                        self.description = item.description
                        isEdit = false
                    } label: {
                        Text("Cancel")
                            .navButton()
                            .foregroundColor(Color.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        item.title = self.title
                        item.description = self.description
                        isEdit = false
                    } label: {
                        Text("Done")
                            .navButton()
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.title = item.title
                        self.description = item.description
                        self.isEdit = true
                    } label: {
                        Text("Edit")
                            .navButton()
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(isEdit ? true : false)
        .onAppear {
            self.title = item.title
            self.description = item.description
            focusField = .title
        }
    }
}

struct ListItemViewForPrev: View {
    @State var item = ListItem(
        title: "감성과 안전사이",
        image: UIImage(named: "heck0")!,
        description: "안전은 어디에 있는가, 감성적인 분위기를 위해 너무 눈에 띄지 않는 문구는 열받게 한다 정말",
        group: .Heck
    )
    
    var body: some View {
            ListItemView(item: $item)
    }
}



struct ListItemView_Previews: PreviewProvider {

    static var previews: some View {
        ListItemViewForPrev()
    }
}

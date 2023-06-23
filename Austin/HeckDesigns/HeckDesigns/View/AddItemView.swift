//
//  AddItemView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/12.
//

import SwiftUI

struct AddItemView: View {
    let fileManager = ImageFileManager.shared
    let dbHelper = DBHelper.shared
    var groupTypes: [GroupType] = [.Heck, .Nice, .Issue]
    var model = Model.instance
    
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var description = ""
    @State var selectedType: GroupType = .Heck
    @State var selectedImage = UIImage(named: "addItemDefault")!
    @State var isSelecting = false
    @State var isLoading = false
    @State var newId = 0
    
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .onTapGesture {
                        isSelecting = true
                    }
                
                HStack {
                    Text("분류")
                        .font(.custom("Apple SD Gothic Neo", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color.textBlack)
                        .lineSpacing(6)
                    Spacer()
                        .frame(width: 10)
                    Picker("category", selection: $selectedType) {
                        ForEach(groupTypes, id: \.self) { type in
                            Text("\(type.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                
                
                Divider()
                HStack {
                    Text("제목")
                        .font(.custom("Apple SD Gothic Neo", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color.textBlack)
                        .lineSpacing(6)
                    Spacer()
                        .frame(width: 20)
                    TextField("제목", text: $title)
                        .padding(10)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(5)
                }
                Divider()
                HStack {
                    Text("설명")
                        .font(.custom("Apple SD Gothic Neo", size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color.textBlack)
                        .lineSpacing(6)
                    Spacer()
                        .frame(width: 20)
                    TextField("설명", text: $description)
                        .padding(10)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(5)
                }
                Divider()
            }
            .padding()
            .navigationBarItems(leading:
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("취소")
                        .foregroundColor(.red)
                }
            )
            .navigationBarItems(trailing: Button("추가", action: {
                addNewItemToModel(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: selectedType,
                    id: newId)
                
                addNewItemToDB(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: selectedType,
                    id: newId)
                
                presentationMode.wrappedValue.dismiss()
            }))
            .navigationBarTitle("새로운 아이템", displayMode: .inline)
            .sheet(isPresented: $isSelecting) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .onAppear {
                newId = model.heckList.count + model.niceList.count + model.issueList.count + 1
            }
        }
    }
}

extension AddItemView {
    
    func addNewItemToModel(title: String,
                           image: UIImage,
                           description: String,
                           group: GroupType,
                           id: Int) {
        if selectedType == .Heck {
            model.heckList.append(
                ListItem(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: .Heck,
                    id: newId
                )
            )
        } else if selectedType == .Issue {
            model.issueList.append(
                ListItem(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: .Heck,
                    id: newId
                )
            )
        }  else if selectedType == .Nice {
            model.niceList.append(
                ListItem(
                    title: title,
                    image: selectedImage,
                    description: description,
                    group: .Heck,
                    id: newId
                )
            )
        }
    }
    func addNewItemToDB(title: String,
                        image: UIImage,
                        description: String,
                        group: GroupType,
                        id: Int){
        fileManager.saveImage(image: self.selectedImage, name: "item\(newId)", onSuccess: { res in
            if res == true {
                print("write success")
            } else {
                print("write fail")
            }
            isLoading = false
        })
        
        dbHelper.insertData(
            title: title,
            description: description,
            group: selectedType,
            imageName: "item\(newId)")
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}

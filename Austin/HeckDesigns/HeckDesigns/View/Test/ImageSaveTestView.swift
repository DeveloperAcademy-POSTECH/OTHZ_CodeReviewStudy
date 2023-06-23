//
//  ImageSaveTestView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/21.
//

import SwiftUI

struct ImageSaveTestView: View {
    let fileManager = ImageFileManager.shared
    @State var isSelecting = false
    @State var isLoading = false
    @State var image = UIImage(named: "heck0")!
    @State var dbImage : UIImage?
    
    
    var body: some View {
        VStack {
            Button {
                self.isSelecting = true
            } label: {
                Text("select image")
            }
            Image(uiImage: self.image)
                .resizable()
                .frame(width: .infinity)
                .frame(height: 300)
                .scaledToFit()
            Text(isLoading == true ? "Loading..." : "")
            Button {
                isLoading = true
                fileManager.saveImage(image: self.image, name: "heck12", onSuccess: { res in
                    if res == true {
                        print("write success")
                    } else {
                        print("write fail")
                    }
                    isLoading = false
                })
            } label: {
                Text("write to db")
            }
            Button {
                isLoading = true
                self.dbImage = fileManager.getSavedImage(named: "heck12")
            } label: {
                Text("get image")
            }
            if dbImage != nil {
                Image(uiImage: dbImage!)
            }
        }
        .sheet(isPresented: $isSelecting) {
            ImagePicker(selectedImage: $image)
        }
    }
}

struct ImageSaveTestView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSaveTestView()
    }
}

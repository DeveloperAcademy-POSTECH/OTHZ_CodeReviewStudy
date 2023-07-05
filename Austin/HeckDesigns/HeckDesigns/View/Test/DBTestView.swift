//
//  DBTestView.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/20.
//

import SwiftUI

struct DBTestView: View {
    @State var showAddModal = false
    @ObservedObject var model = ListModel.shared
    @State var heckList: [ListItem] = []
    private let dbHelper = DBHelper.shared
    
    var body: some View {
        VStack {
            ForEach(heckList, id: \.self) { item in
                VStack {
                    Text(item.title)
                    Text(item.description)
                    Text(item.group.rawValue)
                    Image(uiImage: item.image!)
                }
            }
            Button {
                dbHelper.createTable()
            } label: {
                Text("create")
            }
            Button {
                dbHelper.dropTable(tableName: "heckTable")
                heckList = []
            } label: {
                Text("drop")
            }

        }
        .onAppear {
            dbHelper.createTable()
            let dbdata = dbHelper.readData()
            print(dbdata)
        }
    }
}

struct DBTestView_Previews: PreviewProvider {
    static var previews: some View {
        DBTestView()
    }
}

extension DBTestView {
    func changeList(dbResult: [DBModel]) {
        let res: [ListItem] = []
        self.heckList = res
    }
}

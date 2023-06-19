//
//  DBHelper.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/19.
//

import SwiftUI
import SQLite3

class DBHelper {
    
    static let shared = DBHelper()
    
    //db를 가리키는 포인터
    var db : OpaquePointer?
    // db 이름은 항상 "db이름.sqlite" 형식으로 해주기
    let databaseName = "mysql.sqlite"
    
    init() {
        self.db = createDB()
    }
    deinit {
        sqlite3_close(db)
    }
}

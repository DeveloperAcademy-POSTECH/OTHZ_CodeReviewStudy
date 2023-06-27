//
//  DBHelper.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/19.
//

import SwiftUI
import SQLite3

struct DBModel: Codable, Hashable {
    var id: Int32
    var title: String
    var description: String
    var groupType: String
    var isFavorite: Bool
    var imageName: String
    var uid: String
}


class DBHelper : HeckDesignTableProtocol {
    
    static let shared = DBHelper()
    
    var db : OpaquePointer?
    let databaseName = "mydb.sqlite"
    
    init() {
        self.db = createDB()
    }
    deinit {
        sqlite3_close(db)
    }
    
    /// DB 생성
    private func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        do {
            let dbPath: String = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ).appendingPathComponent(databaseName).path
            
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("Successfully created DB. Path: \(dbPath)")
                return db
            }
        } catch {
            print("Error while creating Database -\(error.localizedDescription)")
        }
        return nil
    }
    
    /// table 이 없는 경우에 table 생성
    func createTable(){
        let query = """
           CREATE TABLE IF NOT EXISTS heckTable(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT,
           description TEXT,
           group_type TEXT,
           is_favorite TEXT,
           image_name TEXT,
           uid TEXT
           ) ;
           """
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating table has been succesfully done. db: \(String(describing: self.db))")
                
            }
            else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\nsqlte3_step failure while creating table: \(errorMessage)")
            }
        }
        else {
            let errorMessage = String(cString: sqlite3_errmsg(self.db))
            print("\nsqlite3_prepare failure while creating table: \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
    }
    
    /// 새로운 ListItem 추가
    func insertData(title: String, description: String, isFavorite: Bool = false,group: GroupType, imageName: String, uid: String) {
       let insertQuery = """
        insert into heckTable (
        `id`,
        title,
        description,
        group_type,
        is_favorite,
        image_name,
        uid
        ) values (?, ?, ?, ?, ?, ?, ?);
        """
       var statement: OpaquePointer? = nil
       
       if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
           sqlite3_bind_text(statement, 2, title, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
           sqlite3_bind_text(statement, 3, description, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
           sqlite3_bind_text(statement, 4, group.rawValue, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
           sqlite3_bind_int(statement, 5, Int32(isFavorite ? 1 : 0))
           sqlite3_bind_text(statement, 6, imageName, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
           sqlite3_bind_text(statement, 7, uid, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
       }
       else {
           print("sqlite binding failure")
       }
       
       if sqlite3_step(statement) == SQLITE_DONE {
           print("sqlite insertion success")
       }
       else {
           let errMSG = String(cString: sqlite3_errmsg(db))
           print("sqlite step failure \(errMSG)")
       }
    }

    /// DB에서 데이터를 읽어와서 DBMode 배열 리턴
    func readData() -> [DBModel] {
        let query: String = "select * from heckTable;"
        var statement: OpaquePointer? = nil
        var result: [DBModel] = []

        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int(statement, 0)
            let title = String(cString: sqlite3_column_text(statement, 1))
            let description = String(cString: sqlite3_column_text(statement, 2))
            let groupType = String(cString: sqlite3_column_text(statement, 3))
            let isFavorite = sqlite3_column_int(statement, 4)
            let imageName = String(cString: sqlite3_column_text(statement, 5))
            let uid = String(cString: sqlite3_column_text(statement, 6))
            
            result.append(DBModel(
                id: id,
                title: title,
                description: description,
                groupType: groupType,
                isFavorite: !(isFavorite == 0),
                imageName: imageName,
                uid: uid
            ))
        }
        sqlite3_finalize(statement)
        
        return result
    }
    
    /// 기존의 ListItem 데이터 변경
    func updateData(
        id: Int,
        title: String,
        description: String,
        groupType: GroupType,
        isFavorite: Bool,
        imageName: String
    ) {
        var statement: OpaquePointer?
        let queryString = """
            UPDATE heckTable SET title = '\(title)',
            description = '\(description)',
            group_type = '\(groupType.rawValue)',
            is_favorite = \(isFavorite ? 1 : 0),
            image_name = '\(imageName)' WHERE id == \(id)
        """
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        print("Update has been successfully done")
    }
    
    /// id 값으로 ListItem 제거
    func deleteData(id: Int) {
            let queryString = "DELETE from heckTable WHERE id == \(id);"
            var statement: OpaquePointer?
            
            if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
                onSQLErrorPrintErrorMessage(db)
                return
            }
            

            if sqlite3_step(statement) != SQLITE_DONE {
                onSQLErrorPrintErrorMessage(db)
                return
            }
            
            print("delete has been successfully done")
        }
    
    /// 테이블 삭제
    func dropTable(tableName: String) {
        let queryString = "DROP TABLE \(tableName)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        print("drop table has been successfully done")
    }
    
    
    private func onSQLErrorPrintErrorMessage(_ db: OpaquePointer?) {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Error preparing update: \(errorMessage)")
        return
    }
}

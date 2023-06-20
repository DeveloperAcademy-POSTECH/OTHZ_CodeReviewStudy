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
    var isFavorite: Int32
    var imageName: String
}


class DBHelper : HeckDesignTableProtocol {
    
    static let shared = DBHelper()
    
    //db를 가리키는 포인터
    var db : OpaquePointer?
    // db 이름은 항상 "db이름.sqlite" 형식으로 해주기
    let databaseName = "mydb.sqlite"
    
    init() {
        self.db = createDB()
    }
    deinit {
        sqlite3_close(db)
    }
    
    //db를 성공적으로 생성할 경우 생성한 DB 포인터를 반환한다.
    //OpaquePointer는 sqlite 전용 포인터이다.
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
    
    func createTable(){
        // 아래 query의 뜻.
        // mytable이라는 table을 생성한다. 필드는
        // id(int, auto-increment primary key)
        // my_name(String not null)
        // my_age(Int)
        // 로 구성한다.
        // auto-increment 속성은 INTEGER에만 가능하다.
        let query = """
           CREATE TABLE IF NOT EXISTS heckTable(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT,
           description TEXT,
           group_type TEXT,
           is_favorite TEXT,
           image_name TEXT
           ) ;
           """
//        `isF` INTEGER NOT NULL,
        var statement: OpaquePointer? = nil
        //prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            //step은 쿼리를 실행하는 단계
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
        
        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제.
    }
    
    func insertData(title: String, description: String, isFavorite: Int = 0,group: GroupType, imageName: String) {
       // id 는 Auto increment 속성을 갖고 있기에 빼줌.
       let insertQuery = """
        insert into heckTable (
        `id`,
        title,
        description,
        group_type,
        is_favorite,
        image_name
        ) values (?, ?, ?, ?, ?, ?);
        """
       var statement: OpaquePointer? = nil
       
       if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
           //sqlite3_bind_text의 두 번째 인자는 values(?, ?, ?) 에서 몇 번째 ?에 넣을거냐를 지정합니다.
           //세 번째 인자는 들어갈 값이 되겠습니다.
           sqlite3_bind_text(statement, 2, title, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
           sqlite3_bind_text(statement, 3, description, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
           sqlite3_bind_text(statement, 4, group.rawValue, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
           sqlite3_bind_int(statement, 5, Int32(isFavorite))
           sqlite3_bind_text(statement, 6, imageName, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
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

    // 반환할 때 readSafety가 아닌 배열 반환하면 안됨
    func readData() -> [DBModel] {
        let query: String = "select * from heckTable;"
        var statement: OpaquePointer? = nil
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        // Nil을 인식하지 못하는 것으로..
        var result: [DBModel] = []

        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            //반드시 아래와 같이 사용
            let id = sqlite3_column_int(statement, 0) // 결과의 0번째 테이블 값
            let title = String(cString: sqlite3_column_text(statement, 1)) // 결과의 1번째 테이블 값.
            let description = String(cString: sqlite3_column_text(statement, 2)) // 결과의 1번째 테이블 값.
            let groupType = String(cString: sqlite3_column_text(statement, 3)) // 결과의 1번째 테이블 값.
            let isFavorite = sqlite3_column_int(statement, 4) // 결과의 2번째 테이블 값.
            let imageName = String(cString: sqlite3_column_text(statement, 5)) // 결과의 1번째 테이블 값.
            
            result.append(DBModel(
                id: id,
                title: title,
                description: description,
                groupType: groupType,
                isFavorite: isFavorite,
                imageName: imageName
            ))
        }
        sqlite3_finalize(statement)
        
        return result
    }
    
    func updateData(
        id: Int,
        title: String,
        description: String,
        groupType: GroupType,
        isFavorite: Bool,
        imageName: String
    ) {
        var statement: OpaquePointer?
        // 등호 기호는 =이 아니라 ==이다.
        // string 부분은 작은 따옴표 두 개로 감싸줘야 한다.
        let queryString = """
            UPDATE heckTable SET title = '\(title)',
            description = '\(description)',
            groupType = '\(groupType.rawValue)',
            isFavorite = \(isFavorite == true ? 0 : 1),
            imageName = '\(imageName)' WHERE id == \(id)
        """
        
        // 쿼리 준비.
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        print("Update has been successfully done")
    }
    
    //id 값에 따라 삭제
    func deleteData(id: Int) {
            let queryString = "DELETE FROM heckTable WHERE id == \(id)"
            var statement: OpaquePointer?
            
            if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
                onSQLErrorPrintErrorMessage(db)
                return
            }
            
            // 쿼리 실행.
            if sqlite3_step(statement) != SQLITE_DONE {
                onSQLErrorPrintErrorMessage(db)
                return
            }
            
            print("delete has been successfully done")
        }
    
    //테이블 삭제
    func dropTable(tableName: String) {
        let queryString = "DROP TABLE \(tableName)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        // 쿼리 실행.
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

//
//  DBUsecase.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol DBUsecaseable {
    static func build() -> FMDatabase?
}

final class DBUsecase: DBUsecaseable {

    static var db:FMDatabase?

    static func build() -> FMDatabase? {

        if db == nil {
            db = FMDatabase(path: path())
            createTable()
        }
        return db
    }

    static fileprivate func createTable() {

        let sql = "CREATE TABLE IF NOT EXISTS todo (task_id INTEGER PRIMARY KEY, targetDate REAL, title TEXT, content TEXT);"

        db?.open()
        let ret = db?.executeUpdate(sql, withArgumentsIn: nil)
        if ret != nil {
            print("CREATE todo Table SUCCESS")
        }
        db?.close()
    }

    static fileprivate func path() -> String {

        let dbName = "calendar.db"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        print(paths.first?.appendingPathComponent(dbName) ?? "")
        return paths.first?.appendingPathComponent(dbName) ?? ""
    }
}

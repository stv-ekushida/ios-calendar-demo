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
    static func open()
    static func close()
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

    static func open() {
        db?.open()
    }

    static func close() {
        db?.close()
    }

    static fileprivate func createTable() {

        let sql = "CREATE TABLE IF NOT EXISTS todo (task_id INTEGER PRIMARY KEY, title TEXT);"

        open()
        let ret = db?.executeUpdate(sql, withArgumentsIn: nil)
        if ret != nil {
            print("CREATE todo Table SUCCESS")
        }
        close()
    }

    static fileprivate func path() -> String {

        let dbName = "calendar.db"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        return paths.first?.appendingPathComponent(dbName) ?? ""
    }
}

//
//  ToDoUsecase.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol ToDoDao {
    static func addTodo(todo: ToDoEntity) -> Bool
    static func updateTodo(todo: ToDoEntity) -> Bool
    static func todoList() -> [ToDoEntity]
}

final class ToDoUsecase {

    static func addTodo(todo: ToDoEntity) -> Bool{

        let sql = "INSERT INTO todo (targetDate, title) VALUES (?, ?);"
        let db = DBUsecase.build()
        var result = false

        db?.open()
        db?.beginTransaction()

        do {
            let targetDate = todo.targetDate?.yyyymndd().timeIntervalSince1970 ?? 0
            try db?.executeUpdate(sql, values: [targetDate, todo.title])
            db?.commit()
            result = true
        } catch{
            db?.rollback()
            fatalError("TODO Table Insert ERROR : \(todo.taskId)")
        }
        db?.close()
        return result
    }

    static func updateTodo(todo: ToDoEntity) -> Bool {

        let sql = "UPDATE todo SET targetDate = :TARGET_DATE, title = :TITLE WHERE task_id = :ID;"
        let db = DBUsecase.build()
        var result = false

        db?.open()
        db?.beginTransaction()

        let targetDate = todo.targetDate?.yyyymndd().timeIntervalSince1970 ?? 0

        let sqlResult = db?.executeUpdate(sql,
                              withParameterDictionary: ["TARGET_DATE": targetDate,
                                                        "TITLE":todo.title,
                                                        "ID": todo.taskId])
        if sqlResult! {
            db?.commit()
            result = true
        } else {
            db?.rollback()
            fatalError("TODO Table Insert ERROR : \(todo.taskId)")
        }
        db?.close()
        return result
    }

    static func todoList() -> [ToDoEntity] {

        let sql = "SELECT task_id, targetDate, title FROM todo ORDER BY task_id;"
        let db = DBUsecase.build()
        db?.open()

        let sqlResult = db?.executeQuery(sql, withArgumentsIn: nil)
        var todos: [ToDoEntity] = []

        while (sqlResult?.next())! {

            let taskId = sqlResult?.int(forColumn: "task_id") ?? 0
            let targetDate = sqlResult?.double(forColumn: "targetDate") ?? 0
            let title = sqlResult?.string(forColumn: "title") ?? ""

            var todo = ToDoEntity()
            todo.taskId = Int(taskId)
            todo.targetDate = Date(timeIntervalSince1970: targetDate)
            todo.title = title
            todos.append(todo)
        }

        db?.close()
        return todos
    }

    static func findTodoAt(yyyymd: String) -> ToDoEntity? {

        let sql = "SELECT task_id, targetDate, title FROM todo WHERE targetDate = :TARGET_DATE;"
        let db = DBUsecase.build()
        db?.open()

        let targetDateUnixTime = yyyymd.str2Date(format: "yyyy-MM-dd")?.yyyymndd().timeIntervalSince1970 ?? 0
        let sqlResult = db?.executeQuery(sql, withParameterDictionary: ["TARGET_DATE": targetDateUnixTime])

        var todos: [ToDoEntity] = []

        while (sqlResult?.next())! {

            let taskId = sqlResult?.int(forColumn: "task_id") ?? 0
            let targetDate = sqlResult?.double(forColumn: "targetDate") ?? 0
            let title = sqlResult?.string(forColumn: "title") ?? ""

            var todo = ToDoEntity()
            todo.taskId = Int(taskId)
            todo.targetDate = Date(timeIntervalSince1970: targetDate)
            todo.title = title
            todos.append(todo)
        }

        db?.close()

        guard todos.count != 0 else {
            return nil
        }
        return todos.first
    }


    static func deleteToDoAll() {

        let sql = "DELETE FROM todo;"
        let db = DBUsecase.build()
        db?.open()
        _ = db?.executeUpdate(sql, withArgumentsIn: nil)
        db?.close()
    }
}

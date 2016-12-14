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

        let sql = "INSERT INTO todo (targetDate, title, created, is_done) VALUES (?, ?, ?, ?);"
        let db = DBUsecase.build()
        var result = false

        db?.open()
        db?.beginTransaction()

        do {
            let targetDate = todo.targetDate?.yyyymndd().timeIntervalSince1970 ?? 0
            let created = Date().yyyymndd().timeIntervalSince1970 
            
            try db?.executeUpdate(sql, values: [targetDate, todo.title, created, false])
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

        let sql = "UPDATE todo SET targetDate = :TARGET_DATE, title = :TITLE, id_done = :IS_DONE WHERE task_id = :ID;"
        let db = DBUsecase.build()
        var result = false

        db?.open()
        db?.beginTransaction()

        let targetDate = todo.targetDate?.yyyymndd().timeIntervalSince1970 ?? 0

        let sqlResult = db?.executeUpdate(sql,
                              withParameterDictionary: ["TARGET_DATE": targetDate,
                                                        "TITLE":todo.title,
                                                        "ID": todo.taskId,
                                                        "IS_DONE": todo.isDone])
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

        let sql = "SELECT task_id, targetDate, title, is_done FROM todo ORDER BY task_id, created;"
        let db = DBUsecase.build()
        db?.open()

        let sqlResult = db?.executeQuery(sql, withArgumentsIn: nil)
        var todos: [ToDoEntity] = []

        while (sqlResult?.next())! {

            let taskId = sqlResult?.int(forColumn: "task_id") ?? 0
            let targetDate = sqlResult?.double(forColumn: "targetDate") ?? 0
            let title = sqlResult?.string(forColumn: "title") ?? ""
            let isDone = sqlResult?.bool(forColumn: "is_done") ?? false

            var todo = ToDoEntity()
            todo.taskId = Int(taskId)
            todo.targetDate = Date(timeIntervalSince1970: targetDate)
            todo.title = title
            todo.isDone = isDone
            todos.append(todo)
        }

        db?.close()
        return todos
    }

    static func findTodoAt(yyyymd: String) -> ToDoEntity? {

        let sql = "SELECT task_id, targetDate, title, is_done FROM todo WHERE targetDate = :TARGET_DATE;"
        let db = DBUsecase.build()
        db?.open()

        let targetDateUnixTime = yyyymd.str2Date(format: "yyyy-MM-dd")?.yyyymndd().timeIntervalSince1970 ?? 0
        let sqlResult = db?.executeQuery(sql, withParameterDictionary: ["TARGET_DATE": targetDateUnixTime])

        var todos: [ToDoEntity] = []

        while (sqlResult?.next())! {

            let taskId = sqlResult?.int(forColumn: "task_id") ?? 0
            let targetDate = sqlResult?.double(forColumn: "targetDate") ?? 0
            let title = sqlResult?.string(forColumn: "title") ?? ""
            let isDone = sqlResult?.bool(forColumn: "is_done") ?? false

            var todo = ToDoEntity()
            todo.taskId = Int(taskId)
            todo.targetDate = Date(timeIntervalSince1970: targetDate)
            todo.title = title
            todo.isDone = isDone
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

//
//  ToDoUsecase.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol ToDoDao {
    static func addTodo(todo: ToDoEntity)
    static func updateTodo(todo: ToDoEntity)
    static func todoList() -> [ToDoEntity]
}

final class ToDoUsecase {

    static func addTodo(todo: ToDoEntity) {

        let sql = "INSERT INTO todo (targetDate, title, content) VALUES (?, ?, ?);"
        let db = DBUsecase.build()

        db?.open()
        db?.beginTransaction()

        do {
            try db?.executeUpdate(sql, values: [todo.targetDate!, todo.title])
            db?.commit()

        } catch{
            db?.rollback()
            fatalError("TODO Table Insert ERROR : \(todo.taskId)")
        }
        db?.close()
    }

    static func updateTodo(todo: ToDoEntity) {

        let sql = "UPDATE todo SET targetDate = :TARGET_DATE, title = :TITLE, content = :CONTENT WHERE task_id = :ID;"
        let db = DBUsecase.build()

        db?.open()
        db?.beginTransaction()

        let targetDate = todo.targetDate?.timeIntervalSince1970 ?? 0

        let result = db?.executeUpdate(sql,
                              withParameterDictionary: ["TARGET_DATE": targetDate,
                                                        "TITLE":todo.title,
                                                        "CONTENT" : todo.content,
                                                        "ID": todo.taskId])
        if result! {
            db?.commit()
        } else {
            db?.rollback()
            fatalError("TODO Table Insert ERROR : \(todo.taskId)")
        }
        db?.close()
    }

    static func todoList() -> [ToDoEntity] {

        let sql = "SELECT targetDate, title, content FROM todo ORDER BY task_id;"
        let db = DBUsecase.build()
        db?.open()

        let results = db?.executeQuery(sql, withArgumentsIn: nil)
        var todos: [ToDoEntity] = []

        while (results?.next())! {

            let targetDate = results?.double(forColumn: "targetDate") ?? 0
            let title = results?.string(forColumn: "title") ?? ""
            let content = results?.string(forColumn: "content") ?? ""

            var todo = ToDoEntity()
            todo.targetDate = Date(timeIntervalSince1970: targetDate)
            todo.title = title
            todo.content = content
            todos.append(todo)
        }

        db?.close()
        return todos
    }
}

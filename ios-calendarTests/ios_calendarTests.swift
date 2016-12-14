//
//  ios_calendarTests.swift
//  ios-calendarTests
//
//  Created by Eiji Kushida on 2016/12/13.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_calendar

class ios_calendarTests: XCTestCase {

    var db: FMDatabase?

    override func setUp() {
        super.setUp()
        db = DBUsecase.build()
    }
    
    override func tearDown() {
        super.tearDown()
        ToDoUsecase.deleteToDoAll()
    }

    func testCreateDB() {
        XCTAssertNotNil(db)
    }

    func testInsertToDo() {

        //test data
        let result = ToDoUsecase.addTodo(todo: setupToDoItem(dateString: "2016-12-14 13:00:00 +09:00",
                                                             title: "タイトル",
                                                             content: "内容"))
        XCTAssertTrue(result)

        let results = ToDoUsecase.todoList()

        XCTAssertEqual(results.count, 1)

        XCTAssertNotNil(results.first)

        XCTAssertEqual(results.first?.title, "タイトル")
        XCTAssertEqual(results.first?.content, "内容")
        XCTAssertEqual(results.first?.targetDate?.date2String(format: "yyyy-MM-dd"), "2016-12-14")
    }

    func testInsertToDoMulti() {

        var result = ToDoUsecase.addTodo(todo: setupToDoItem(dateString: "2016-12-14 13:00:00 +09:00",
                                                             title: "タイトル1",
                                                             content: "内容1"))

        XCTAssertTrue(result)

        result = ToDoUsecase.addTodo(todo: setupToDoItem(dateString: "2016-12-15 12:00:00 +09:00",
                                                             title: "タイトル2",
                                                             content: "内容2"))

        XCTAssertTrue(result)

        let todos = ToDoUsecase.todoList()

        XCTAssertEqual(todos.count, 2)

        XCTAssertNotNil(todos.first)
        XCTAssertNotNil(todos.last)

        XCTAssertEqual(todos.first?.title, "タイトル1")
        XCTAssertEqual(todos.first?.content, "内容1")
        XCTAssertEqual(todos.first?.targetDate?.date2String(format: "yyyy-MM-dd"), "2016-12-14")
    }

    func testUpdateAtToDo() {

        //登録
        let todo = setupToDoItem(dateString: "2016-12-14 13:00:00 +09:00",
                                 title: "タイトル1",
                                 content: "内容1")

        var result = ToDoUsecase.addTodo(todo: todo)

        //更新情報をつくる
        var todos = ToDoUsecase.todoList()
        var updateTodo = todos.first
        updateTodo?.title = "タイトル1更新"
        updateTodo?.content = "内容1更新"

        //更新
        result = ToDoUsecase.updateTodo(todo: updateTodo!)
        XCTAssertTrue(result)


        XCTAssertEqual(todos.count, 1)
        todos = ToDoUsecase.todoList()
        XCTAssertNotNil(todos.first)

        if let unwapTodo = todos.first {

            XCTAssertEqual(unwapTodo.title, "タイトル1更新")
            XCTAssertEqual(unwapTodo.content, "内容1更新")
            XCTAssertEqual(unwapTodo.targetDate?.date2String(format: "yyyy-MM-dd"), "2016-12-14")
        }
    }


    //Moc
    fileprivate func setupToDoItem(dateString: String, title: String, content: String) -> ToDoEntity{

        let dateString = "2016-12-14 13:00:00 +09:00"
        var todo = ToDoEntity()
        todo.title = title
        todo.content = content
        todo.targetDate = dateString.str2Date(dateString: dateString,
                                              format: "yyyy-MM-dd HH:mm:ss Z")
        return todo
    }
}

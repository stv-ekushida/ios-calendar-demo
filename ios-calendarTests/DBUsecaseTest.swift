//
//  DBUsecaseTest.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_calendar

class DBUsecaseTest: XCTestCase {

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
}

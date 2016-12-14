//
//  ToDoEntity.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

struct ToDoEntity {

    var taskId = 0
    var targetDate: Date?
    var title = ""
    var content = ""
    var created = Date()
    var modifid: Date?
    var deleteFlg = false
}

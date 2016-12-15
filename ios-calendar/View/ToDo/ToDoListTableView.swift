//
//  ToDoListTableView.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/15.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class ToDoListTableView:NSObject, UITableViewDataSource {

    var todos: [ToDoEntity] = []

    func add(todos: [ToDoEntity]) {
        self.todos = todos
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = todos[indexPath.row].title
        return cell
    }
}

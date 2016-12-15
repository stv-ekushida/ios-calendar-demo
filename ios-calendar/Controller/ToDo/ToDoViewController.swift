//
//  ToDoViewController.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class ToDoViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var addToDoTextField: UITextField!
    @IBOutlet weak var todoListTableView: UITableView!

    static var storyboardName: String {
        get {
            return String(describing: self)
        }
    }

    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    var dataSource = ToDoListTableView()
    var dateString = ""

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitle()
        setupView()
        loadTodos()
    }

    //MARK:-Actions
    @IBAction func didTapAdd(_ sender: UIBarButtonItem) {
        addToDo()
    }
        
    @IBAction func didTapBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func updateTitle() {
        
        navigationBar.topItem?.title = dateString.str2DateString(separated: .month) + "月"
            + dateString.str2DateString(separated: .day) + "日"
    }

    fileprivate func setupView() {
        todoListTableView.dataSource = dataSource
        todoListTableView.delegate = self
    }

    fileprivate func loadTodos() {
        
        let todos = ToDoUsecase.findTodoAt(yyyymd: dateString)
        dataSource.add(todos: todos)
        todoListTableView.reloadData()
    }
    
    fileprivate func addToDo() {
        
        var todo = ToDoEntity()
        todo.title = "test"
        todo.targetDate = dateString.str2Date(format: "yyyy-MM-dd")
        let result = ToDoUsecase.addTodo(todo: todo)

        if result {
            loadTodos()
        }
    }
}

extension ToDoViewController: UITableViewDelegate {
}

extension ToDoViewController: Storyboardable {}

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
    var dateString = ""

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitle()
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
    
    fileprivate func loadTodos() {
        
        let todos = ToDoUsecase.findTodoAt(yyyymd: dateString)
        
        _ = todos.map {
            print($0.title, $0.targetDate?.description)
        }
    }
    
    fileprivate func addToDo() {
        
        var todo = ToDoEntity()
        todo.title = "test"
        todo.targetDate = dateString.str2Date(format: "yyyy-MM-dd")
        _ = ToDoUsecase.addTodo(todo: todo)
    }
}

extension ToDoViewController: Storyboardable {}

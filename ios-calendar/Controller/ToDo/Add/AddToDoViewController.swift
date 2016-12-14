//
//  AddToDoViewController.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class AddToDoViewController: UIViewController {

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

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK:-Actions
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddToDoViewController: Storyboardable {}

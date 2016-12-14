//
//  Storyboardable.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol Storyboardable {
    static var storyboardName: String  { get }
    static var identifier: String { get }
}

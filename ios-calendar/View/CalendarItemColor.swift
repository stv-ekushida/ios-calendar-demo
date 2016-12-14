//
//  CalendarItemColor.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class CalendarItemColor {

    static func dayColor(index: Int) -> UIColor{

        if index % 7 == 0 {
            return UIColor.red
        } else if index % 7 == 6 {
            return UIColor.blue
        } else {
            return UIColor.black
        }
    }
}

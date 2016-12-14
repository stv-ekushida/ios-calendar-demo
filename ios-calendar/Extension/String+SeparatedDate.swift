//
//  String+SeparatedDate.swift
//  ios-calendar
//
//  Created by Kushida　Eiji on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

extension String {
    
    enum CalendarSeparate: Int {
        case year
        case month
        case day
    }

    func str2DateString(separated: CalendarSeparate) -> String{
        return self.components(separatedBy: "-")[separated.rawValue]
    }
}

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

        enum Week: Int {
            case sun
            case sat = 6
        }

        switch index % Int(CalendarUsecase.daysPerWeek) {
        case Week.sun.rawValue:
            return UIColor.red

        case Week.sat.rawValue:
            return UIColor.blue

        default:
            return UIColor.black
        }
    }

    static func targetMonthColor(selectedDate: Date, dateString: String) -> UIColor? {

        enum CalendarSeparate: Int {
            case year
            case month
            case day
        }

        let targetMonth = dateString.components(separatedBy: "-")[CalendarSeparate.month.rawValue]
        let selectedMonth = selectedDate.date2String(format: "M")
        
        return targetMonth == selectedMonth ? nil : UIColor.lightGray
    }
}

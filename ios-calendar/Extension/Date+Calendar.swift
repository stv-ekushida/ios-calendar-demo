//
//  Date+Calendar.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/13.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation

extension Date {

    func startOfMonth() -> Date? {
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour],
                                                                   from: Calendar.current.startOfDay(for: self))
        comp.day = 1
        comp.hour = 9
        return Calendar.current.date(from: comp)!
    }

    func endOfMonth() -> Date? {
        var comp: DateComponents = Calendar.current.dateComponents([.month, .month, .day, .hour],
                                                                   from: Calendar.current.startOfDay(for: self))
        comp.month = 1
        comp.day = -1
        comp.hour = 9
        return Calendar.current.date(byAdding: comp, to: self.startOfMonth()!)
    }
    
    func preMonth() -> Date {
        
        var comp = DateComponents()
        comp.month = -1
        comp.hour = 9
        return NSCalendar.current.date(byAdding: comp,to: self)!
    }
    
    func nextMonth() -> Date {
        
        var comp = DateComponents()
        comp.month = 1
        comp.hour = 9
        return NSCalendar.current.date(byAdding: comp,to: self)!
    }

    func yyyymndd() -> Date {

        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day],
                                                                   from: Calendar.current.startOfDay(for: self))
        comp.hour = 9
        return Calendar.current.date(from: comp)!
    }
}

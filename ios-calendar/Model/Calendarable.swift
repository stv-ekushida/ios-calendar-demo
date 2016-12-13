//
//  Calendarable.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/13.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol Calendarable {
    func startOfMonth() -> Date?
    func endOfMonth() -> Date?
    func numberOfDays() -> Int?
    func makeDayText(index: Int) -> String
    func date2String(date: Date, format: String) -> String
}

final class CalendarUsecase: Calendarable {

    static let daysPerWeek = CGFloat(7)
    fileprivate var targetDate = Date()

    func setup(targetDate: Date) {
        self.targetDate = targetDate
    }

    func startOfMonth() -> Date? {
        return targetDate.startOfMonth()
    }

    func endOfMonth() -> Date? {
        return targetDate.endOfMonth()
    }

    func numberOfDays() -> Int? {

        guard let startOfManth = targetDate.startOfMonth() else {
            fatalError("\(#function) : 月初めの日付が取得できませんでした")
        }
        
        let rangeOfWeeks = NSCalendar.current.range(of: .weekOfMonth,
                                 in: .month,
                                 for: startOfManth)

        guard let numberOfWeek = rangeOfWeeks?.count else{
            fatalError("\(#function) : 今月何週あるか取得できませんでした")
        }
        return numberOfWeek * Int(CalendarUsecase.daysPerWeek)
    }

    func makeDayText(index: Int) -> String {

        guard let startOfDay = startOfMonth() else {
            fatalError("\(#function) : 月初めの日付が取得できませんでした")
        }

        guard let ordinality = NSCalendar.current.ordinality(
            of: .day,
            in: .weekOfMonth,
            for: startOfDay) else {
            fatalError("\(#function) : indexPathが取得できませんでした")
        }
        
        var comp = DateComponents()
        comp.day = index - (ordinality - 1)
        
        if let date = NSCalendar.current.date(byAdding: comp,
                                              to: startOfDay) {
            return date2String(date: date, format: "d")
        } else {
            fatalError("\(#function) : 日付が取得できませんでした")
        }
    }
    
    func date2String(date: Date, format: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

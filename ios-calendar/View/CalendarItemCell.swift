//
//  Calendar.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/13.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class CalendarItemCell: UICollectionViewCell{

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var canToDoLabel: UILabel!

    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    var selectedDate: Date?
    var dateString: String = "" {
        didSet {

            dayLabel.text = dateString.str2DateString(separated: .day)

            if let color = CalendarItemColor.targetMonthColor(selectedDate: selectedDate!, dateString: dateString) {
                dayLabel.textColor = color
            } else {
                dayLabel.textColor = CalendarItemColor.dayColor(index: self.tag)
            }
        }
    }

    var hasTodo: Bool = false {
        didSet {
            canToDoLabel.isHidden = !hasTodo
        }
    }
}

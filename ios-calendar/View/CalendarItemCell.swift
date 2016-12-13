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

    static var identifier: String {
        get {
            return String(describing: self)
        }
    }

    var day: String? {

        didSet {

            if let day = day {
                dayLabel.text = day
            }
        }
    }
}

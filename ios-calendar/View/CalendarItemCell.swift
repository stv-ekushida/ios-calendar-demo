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
    var dateString: String? {
        didSet {

            if let dateString = dateString {
                self.dateString = dateString
                dayLabel.text = dateString.components(separatedBy: "-").last
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

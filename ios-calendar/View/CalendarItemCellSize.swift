//
//  CalendarItemCellSize.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/14.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class CalendarItemCellSize {

    static func build(topOf: CalendarViewController) -> CGSize {

        let screenSize = UIScreen.main.bounds
        let numberOfWeekly = CGFloat(topOf.days.count / Int(CalendarUsecase.daysPerWeek))
        let correctionSize = UIApplication.shared.statusBarFrame.height
            + (topOf.navigationController?.navigationBar.bounds.height)!
            + topOf.toolBarViewHeight.constant
            + topOf.headerViewHeight.constant

        let cellWidth = screenSize.width / CalendarUsecase.daysPerWeek
        let cellHeight = (screenSize.height - correctionSize) / numberOfWeekly
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

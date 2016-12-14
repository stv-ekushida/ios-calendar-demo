//
//  CalendarCollectionView.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/13.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class CalendarCollectionView: NSObject, UICollectionViewDataSource {

    var days: [String] = []

    func add(days: [String]) {
        self.days = days
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return days.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarItemCell.identifier,
                                                      for: indexPath) as! CalendarItemCell
        cell.tag = indexPath.row
        cell.yyyymd = days[indexPath.row]

        let canTodo = ToDoUsecase.findTodoAt(yyyymd: days[indexPath.row])
        cell.canTodo = (canTodo != nil)
        return cell
    }
}

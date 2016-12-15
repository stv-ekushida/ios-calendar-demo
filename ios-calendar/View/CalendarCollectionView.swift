//
//  CalendarCollectionView.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/13.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class CalendarCollectionView: NSObject, UICollectionViewDataSource {

    var dateStrings: [String] = []
    var selectedDate: Date?

    func add(dateStrings: [String]) {
        self.dateStrings = dateStrings
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return dateStrings.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarItemCell.identifier,
                                                      for: indexPath) as! CalendarItemCell
        cell.tag = indexPath.row
        cell.selectedDate = selectedDate
        cell.dateString = dateStrings[indexPath.row]

        let todos = ToDoUsecase.findTodoAt(yyyymd: dateStrings[indexPath.row])
        cell.hasTodo = todos.count > 0
        return cell
    }
}

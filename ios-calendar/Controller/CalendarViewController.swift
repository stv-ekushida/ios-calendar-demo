//
//  CalendarViewController.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/13.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    var days: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var selectedDay = Date() {
        didSet {
            updateViews()
            updateTitle()
        }
    }
    
    let usecase = CalendarUsecase()
    var dataSource = CalendarCollectionView()
    var cellWidth = CGFloat(0)
    var cellHeight = CGFloat(0)

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()        
        updateViews()
        updateTitle()
    }
    
    //MARK:- Actions
    @IBAction func didTapPreMonth(_ sender: UIBarButtonItem) {
        selectedDay = selectedDay.preMonth()
    }
    
    @IBAction func didTapNextMonth(_ sender: UIBarButtonItem) {
        selectedDay = selectedDay.nextMonth()
    }
    
    fileprivate func setupView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    fileprivate func updateViews() {
        
        days.removeAll()
        usecase.setup(targetDate: selectedDay)
        
        for i in 0 ..< usecase.numberOfDays()! {
            days.append(usecase.makeDayText(index: i))
        }
        dataSource.add(days: days)
    }
        
    fileprivate func updateTitle() {
        self.title = usecase.date2String(date: selectedDay, format: "Y年M月")
    }
}

//MARK:- UICollectionViewDelegate
extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension CalendarViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if cellWidth != 0 && cellHeight != 0 {
            return CGSize(width: cellWidth, height: cellHeight)
        }
        return CalendarItemCellSize.build(topOf: self)
    }
}

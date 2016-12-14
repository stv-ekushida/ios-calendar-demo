//
//  CalendarViewController.swift
//  ios-calendar
//
//  Created by Eiji Kushida on 2016/12/13.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {

    static var storyboardName: String {
        get {
            return String(describing: self)
        }
    }

    static var identifier: String {
        get {
            return String(describing: self)
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var toolBarViewHeight: NSLayoutConstraint!

    var dateStrings: [String] = [] {
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

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        dateStrings.removeAll()
        usecase.setup(targetDate: selectedDay)
        
        for i in 0 ..< usecase.numberOfDays()! {
            dateStrings.append(usecase.makeDayText(index: i))
        }
        dataSource.add(dateStrings: dateStrings)
        dataSource.selectedDate = selectedDay
    }
        
    fileprivate func updateTitle() {
        self.title = usecase.date2String(date: selectedDay, format: "Y年M月")
    }

}

//MARK:- UICollectionViewDelegate
extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        presnetAddToDoViewController(dateString: dateStrings[indexPath.row])
    }
    
    fileprivate func presnetAddToDoViewController(dateString: String) {
        
        let vc = UIStoryboard.getViewController(storyboardName: AddToDoViewController.storyboardName,
                                                identifier: AddToDoViewController.identifier) as! AddToDoViewController
        vc.dateString = dateString
        self.present(vc, animated: true, completion:  nil)
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension CalendarViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CalendarItemCellSize.build(topOf: self)
    }
}

extension CalendarViewController: Storyboardable {}

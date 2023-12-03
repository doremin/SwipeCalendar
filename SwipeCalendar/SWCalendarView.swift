//
//  SWCalendarView.swift
//  SwipeCalendar
//
//  Created by doremin on 2023/10/16.
//

import UIKit

import SnapKit

class SWCalendarView: UIView {
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  let label: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 16)
    label.textAlignment = .center
    
    return label
  }()
  
  // MARK: Properties
  private var currentMonth: Int {
    return days[13].month
  }
  
  // MARK: States
  var days: [SWDay] {
    didSet {
      DispatchQueue.main.async {
        self.label.text = "\(self.days[13].year) \(self.currentMonth)월"
      }
    }
  }
  
  // MARK: Initiallizer
  init(days: [SWDay]) {
    self.days = days
    super.init(frame: .zero)
    config()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func config() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.collectionView.backgroundColor = .white
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(SWCalendarCollectionViewCell.self, forCellWithReuseIdentifier: SWCalendarCollectionViewCell.reuseIdentifier)
    
    self.addSubview(label)
    label.text = "\(days[13].year) \(currentMonth)월"
    label.snp.makeConstraints { make in
      make.left.right.top.equalToSuperview()
      make.height.equalTo(30)
    }
    
    self.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(label.snp.bottom)
      make.left.right.bottom.equalToSuperview()
//      make.edges.equalToSuperview()
    }
    
  }
}

extension SWCalendarView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let heightCount = days.count / 7
    let height = collectionView.frame.height / CGFloat(heightCount)
    let width = collectionView.frame.width / 7
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    0
  }
}

extension SWCalendarView: UICollectionViewDelegate {
  
}

extension SWCalendarView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    days.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: SWCalendarCollectionViewCell.reuseIdentifier,
        for: indexPath) as? SWCalendarCollectionViewCell
    else {
      return UICollectionViewCell()
    }
    
    let day = days[indexPath.row]
    cell.config(title: "\(day.day)일", current: currentMonth, monthOfDay: day.month)
    
    return cell
  }
  
  
}

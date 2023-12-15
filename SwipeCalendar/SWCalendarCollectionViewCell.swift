//
//  SWCalendarCollectionViewCell.swift
//  SwipeCalendar
//
//  Created by doremin on 2023/11/30.
//

import UIKit

import SnapKit

class SWCalendarCollectionViewCell: UICollectionViewCell {
  
  static let reuseIdentifier = "SWCalendarCollectionViewCell"
  
  var title: String? {
    willSet {
      self.titleLabel.text = newValue
    }
  }
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.isAccessibilityElement = false
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.contentView.backgroundColor = .white
    self.contentView.addSubview(self.titleLabel)
    
    self.titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(5)
    }
  }
  
  func config(title: String, current: Int, monthOfDay: Int) {
    self.title = title
    
    self.titleLabel.textColor = current == monthOfDay ? .black : .gray
    self.isAccessibilityElement = true
    self.accessibilityLabel = title
  }
}

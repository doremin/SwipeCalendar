//
//  SWCalendarScrollView.swift
//  SwipeCalendar
//
//  Created by doremin on 2023/11/30.
//

import UIKit

import SnapKit

class SWCalendarScrollView: UIScrollView {
  
  let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    
    return view
  }()
  
  var calendarViews: [SWCalendarView] = []
  var now = SWDay(from: Date())
  var currentMonth: [SWDay] = []
  var nextMonth: [SWDay] = []
  var lastMonth: [SWDay] = []
  
  let calendar = SWCalendar()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    config()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func config() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.backgroundColor = .white
    self.isPagingEnabled = true
    self.delegate = self
    self.showsVerticalScrollIndicator = false
    self.showsHorizontalScrollIndicator = false
    
    generateMonths()
  }
  
  private func generateMonths() {
    guard let lastMonthDate = try? calendar.date(byAdding: .month, value: -1, to: now.date) else {
      return
    }
    
    guard let nextMonthDate = try? calendar.date(byAdding: .month, value: 1, to: now.date) else {
      return
    }
    
    currentMonth = calendar.generateDaysOfMonth(date: now.date)
    nextMonth = calendar.generateDaysOfMonth(date: nextMonthDate)
    lastMonth = calendar.generateDaysOfMonth(date: lastMonthDate)
  }
  
  private func generateLastMonth() {
    guard let lastMonthDate = try? calendar.date(byAdding: .month, value: -1, to: now.date) else {
      return
    }
    
    lastMonth = calendar.generateDaysOfMonth(date: lastMonthDate)
  }
  
  private func generateNextMonth() {
    guard let nextMonthDate = try? calendar.date(byAdding: .month, value: 1, to: now.date) else {
      return
    }
    
    nextMonth = calendar.generateDaysOfMonth(date: nextMonthDate)
  }
  
  func setupSubviews() {
    let width = frame.width
    let height = frame.height
    
    self.addSubview(contentView)
    
    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.height.equalTo(height)
      make.width.equalTo(width * 3)
    }
    
    calendarViews = [lastMonth, currentMonth, nextMonth]
      .map { SWCalendarView(days: $0) }
    
    calendarViews.enumerated()
      .forEach { index, view in
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
          make.left.equalTo(width * CGFloat(index))
          make.top.bottom.equalToSuperview()
          make.size.equalTo(CGSize(width: width, height: height))
        }
      }
    
    setContentOffset(CGPoint(x: width, y: 0), animated: false)
  }
  
  private func setupAccessibility() {
    var elements: [Any] = []
    
    let group1 = UIAccessibilityElement(accessibilityContainer: self)
    group1.accessibilityLabel = "\(calendarViews[1].label.text ?? "")"
    group1.accessibilityFrame = calendarViews[1].label.frame
    
    let group2 = UIAccessibilityElement(accessibilityContainer: self)
    group2.accessibilityLabel = "달력"
    
    elements.append(group1)
    elements.append(group2)
    
    accessibilityElements = elements
  }
}

extension SWCalendarScrollView: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    scrollView.isScrollEnabled = false
    let width = frame.width
    
    switch scrollView.contentOffset.x {
    case 0:
      now = lastMonth[10]
      nextMonth = currentMonth
      currentMonth = lastMonth
      calendarViews[1].days = currentMonth
      calendarViews[2].days = nextMonth
      generateLastMonth()
      calendarViews[0].days = lastMonth
    case width * 2:
      now = nextMonth[10]
      lastMonth = currentMonth
      currentMonth = nextMonth
      calendarViews[1].days = currentMonth
      calendarViews[0].days = lastMonth
      generateNextMonth()
      calendarViews[2].days = nextMonth
    default:
      break
    }
    
    calendarViews
      .forEach {
        $0.collectionView.reloadData()
        $0.label.text = "\($0.days[13].year)년 \($0.currentMonth)월"
      }
    setContentOffset(CGPoint(x: width, y: 0), animated: false)
    
    scrollView.isScrollEnabled = true
  }
}

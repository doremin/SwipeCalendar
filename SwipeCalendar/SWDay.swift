//
//  SWDay.swift
//  SwipeCalendar
//
//  Created by doremin on 2023/10/31.
//

import Foundation

struct SWDay {
  let year: Int
  let month: Int
  let day: Int
  
  init(
    year: Int,
    month: Int,
    day: Int)
  {
    self.year = year
    self.month = month
    self.day = day
  }
}

extension SWDay: Equatable {
  static func == (
    lhs: SWDay,
    rhs: SWDay)
  -> Bool
  {
    lhs.year == rhs.year
    && lhs.month == rhs.month
    && lhs.day == rhs.day
  }
}

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
  
  init(from: Date) {
    let calendar = Calendar.current
    
    self.year = calendar.component(.year, from: from)
    self.month = calendar.component(.month, from: from)
    self.day = calendar.component(.day, from: from)
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
  
  static func < (
    lhs: SWDay,
    rhs: SWDay)
  -> Bool
  {
    if lhs.year < rhs.year {
      return true
    } else if lhs.year > rhs.year {
      return false
    }
    
    if lhs.month < rhs.month {
      return true
    } else if lhs.month > rhs.month {
      return false
    }
    
    return lhs.day < rhs.day
  }
  
  static func > (
    lhs: SWDay,
    rhs: SWDay)
  -> Bool
  {
    if lhs.year > rhs.year {
      return true
    } else if lhs.year < rhs.year {
      return false
    }
    
    if lhs.month > rhs.month {
      return true
    } else if lhs.month < rhs.month {
      return false
    }
    
    return lhs.day > rhs.day
  }
}

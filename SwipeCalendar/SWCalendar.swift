//
//  SWCalendar.swift
//  SwipeCalendar
//
//  Created by doremin on 2023/10/16.
//

import Foundation

class SWCalendar {
  let calendar: Calendar
  
  var days = [Date]()
  
  init(calendar: Calendar = .current) {
    self.calendar = calendar
  }
  
  func generateDaysOfWeek(date: Date) -> [SWDay] {
    let weekday = calendar.component(.weekday, from: date)
    let yesterdays = (1 ..< weekday)
      .reversed()
      .compactMap { calendar.date(byAdding: .day, value: $0 * -1, to: date) }
    
    let futures = (0 ..< 8 - weekday)
      .compactMap { calendar.date(byAdding: .day, value: $0, to: date) }
    
    let daysOfWeek = (yesterdays + futures)
      .map {
        SWDay(
          year: calendar.component(.year, from: $0),
          month: calendar.component(.month, from: $0),
          day: calendar.component(.day, from: $0))
      }
    
    return daysOfWeek
  }
}

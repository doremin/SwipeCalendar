//
//  SWCalendar.swift
//  SwipeCalendar
//
//  Created by doremin on 2023/10/16.
//

import Foundation

enum SWError: Error {
  case invalidString
  case invalidDate
}

class SWCalendar {
  
  let calendar: Calendar
  
  init(calendar: Calendar = .current) {
    self.calendar = calendar
  }
  
  func date(from string: String) throws -> Date {
    guard let date = try? Date(string, strategy: .iso8601) else {
      throw SWError.invalidString
    }
    
    return date
  }
  
  /**
   parameter로 전달된 날짜가 속한 일주일을 반환하는 함수
   - Parameters:
    - date: 기준 날짜
   - Returns: 기준 날짜가 속한 일주일 날짜들 (이전달, 다음달 날짜도 포함될 수 있음)
   */
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
  
  /**
   parameter로 전달된 날짜가 속한 달을 반환하는 함수
   - Parameters:
    - date: 기준 날짜
   - Returns: 기준 날짜가 속한 일주일 날짜들 (이전달, 다음달 날짜도 포함될 수 있음)
   */
  func generateDaysOfMonth(date: Date) -> [SWDay] {
    var result: [SWDay] = []
    
    guard let lastDay = try? lastDayOfMonth(date: date) else {
      return []
    }
            
    guard var targetDay = firstDateOfMonth(date: date)
    else {
      return []
    }
    
    repeat {
      result += generateDaysOfWeek(date: targetDay)
      
      guard let nextTarget = calendar.date(byAdding: .day, value: 7, to: targetDay) else {
        return []
      }
      
      targetDay = nextTarget
    } while ((result.last ?? lastDay) < lastDay)
    
    return result
  }
  
  func firstDateOfMonth(date: Date) -> Date? {
    guard calendar.component(.day, from: date) != 1 else {
      return date
    }
    
    return calendar.nextDate(
      after: date,
      matching: DateComponents(day: 1),
      matchingPolicy: .strict,
      direction: .backward)
  }
  
  func firstDayOfMonth(date: Date) -> SWDay {
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    
    return SWDay(year: year, month: month, day: 1)
  }
  
  func lastDayOfMonth(date: Date) throws -> SWDay {
    guard let lastDay = calendar.range(of: .day, in: .month, for: date)?.count else {
      throw SWError.invalidDate
    }
    
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    
    return SWDay(year: year, month: month, day: lastDay)
  }
  
  func date(byAdding: Foundation.Calendar.Component, value: Int, to: Foundation.Date) throws -> Date {
    guard let date = calendar.date(byAdding: byAdding, value: value, to: to) else {
      throw SWError.invalidDate
    }
    
    return date
  }
}

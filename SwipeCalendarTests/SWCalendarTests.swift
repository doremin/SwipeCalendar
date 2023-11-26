//
//  SWCalendarTests.swift
//  SWCalendarTests
//
//  Created by doremin on 2023/10/16.
//

import XCTest
@testable import SwipeCalendar

final class SWCalendarTests: XCTestCase {
  
  var calendar: SWCalendar!
  var timezone: TimeZone!
  
  override func setUp() {
    // given
    calendar = SWCalendar()
  }
  
  func testCalendar_whenGenerateDaysOfWeek_generateWith231031() {
    // when
    let targetDate = try! Date("2023-10-31T00:00:00+09:00", strategy: .iso8601)
    let result = calendar.generateDaysOfWeek(date: targetDate)
    
    // then
    let expectedResult = [
      SWDay(year: 2023, month: 10, day: 29),
      SWDay(year: 2023, month: 10, day: 30),
      SWDay(year: 2023, month: 10, day: 31),
      SWDay(year: 2023, month: 11, day: 1),
      SWDay(year: 2023, month: 11, day: 2),
      SWDay(year: 2023, month: 11, day: 3),
      SWDay(year: 2023, month: 11, day: 4)
    ]
    
    XCTAssertEqual(result, expectedResult)
  }
  
  func testCalendar_whenGenerateDaysOfWeek_generateWith230901() {
    // when
    let targetDate = try! Date("2023-09-01T00:00:00+09:00", strategy: .iso8601)
    let result = calendar.generateDaysOfWeek(date: targetDate)
    
    // then
    let expectedResult = [
      SWDay(year: 2023, month: 8, day: 27),
      SWDay(year: 2023, month: 8, day: 28),
      SWDay(year: 2023, month: 8, day: 29),
      SWDay(year: 2023, month: 8, day: 30),
      SWDay(year: 2023, month: 8, day: 31),
      SWDay(year: 2023, month: 9, day: 1),
      SWDay(year: 2023, month: 9, day: 2)
    ]
    
    XCTAssertEqual(result, expectedResult)
  }
  
  func testCalendar_whenGenerateDaysOfWeek_generateWith231231() {
    // when
    let targetDate = try! Date("2023-12-31T00:00:00+09:00", strategy: .iso8601)
    let result = calendar.generateDaysOfWeek(date: targetDate)
    
    // then
    let expectedResult = [
      SWDay(year: 2023, month: 12, day: 31),
      SWDay(year: 2024, month: 1, day: 1),
      SWDay(year: 2024, month: 1, day: 2),
      SWDay(year: 2024, month: 1, day: 3),
      SWDay(year: 2024, month: 1, day: 4),
      SWDay(year: 2024, month: 1, day: 5),
      SWDay(year: 2024, month: 1, day: 6)
    ]
    
    XCTAssertEqual(result, expectedResult)
  }
}

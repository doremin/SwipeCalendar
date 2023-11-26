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
}

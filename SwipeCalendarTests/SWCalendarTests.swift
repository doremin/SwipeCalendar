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
  
  override func setUp() {
    // given
    calendar = SWCalendar()
  }
  
  // MARK: generateDaysOfWeek
  func testCalendar_whenGenerateDaysOfWeek_generateWith231031() {
    // given
    let targetDate = try! calendar.date(from: "2023-10-31T00:00:00+09:00")
    
    // when
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
    // given
    let targetDate = try! calendar.date(from: "2023-09-01T00:00:00+09:00")
    
    // when
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
    // given
    let targetDate = try! calendar.date(from: "2023-12-31T00:00:00+09:00")
    
    // when
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
  
  // MARK: firstDayOfMonth
  func testCalendar_whenFirstDayOfMonth_with231010() {
    // given
    let targetDate = try! calendar.date(from: "2023-10-10T00:00:00+09:00")
    
    // when
    let result = calendar.firstDayOfMonth(date: targetDate)
    
    // then
    let expectedResult = SWDay(year: 2023, month: 10, day: 1)
    
    XCTAssertEqual(result, expectedResult)
  }
  
  // MARK: lastDayOfMonth
  func testCalendar_whenLastDayOfMonth_with231010() {
    // given
    let targetDate = try! calendar.date(from: "2023-10-10T00:00:00+09:00")
    
    // when
    let result = try! calendar.lastDayOfMonth(date: targetDate)
    
    // then
    let expectedResult = SWDay(year: 2023, month: 10, day: 31)
    
    XCTAssertEqual(result, expectedResult)
  }
  
  // MARK: generateDaysOfMonth
  func testCalendar_whenGenerateDaysOfMonth_with231001() {
    // given
    let targetDate1 = try! calendar.date(from: "2023-10-01T00:00:00+09:00")
    let targetDate2 = try! calendar.date(from: "2023-10-09T00:00:00+09:00")
    let targetDate3 = try! calendar.date(from: "2023-10-17T00:00:00+09:00")
    let targetDate4 = try! calendar.date(from: "2023-10-25T00:00:00+09:00")
    let targetDate5 = try! calendar.date(from: "2023-10-31T00:00:00+09:00")
    
    // when
    let result1 = calendar.generateDaysOfMonth(date: targetDate1)
    let result2 = calendar.generateDaysOfMonth(date: targetDate2)
    let result3 = calendar.generateDaysOfMonth(date: targetDate3)
    let result4 = calendar.generateDaysOfMonth(date: targetDate4)
    let result5 = calendar.generateDaysOfMonth(date: targetDate5)
    
    // then
    let expectedResult = [targetDate1, targetDate2, targetDate3, targetDate4, targetDate5]
      .flatMap { calendar.generateDaysOfWeek(date: $0) }
    
    XCTAssertEqual(result1, expectedResult)
    XCTAssertEqual(result2, expectedResult)
    XCTAssertEqual(result3, expectedResult)
    XCTAssertEqual(result4, expectedResult)
    XCTAssertEqual(result5, expectedResult)
  }
  
  // MARK: firstDateOfMonth
  func testCalendar_whenFirstDateOfMonth_with231001() {
    // given
    let targetDate1 = try! calendar.date(from: "2023-10-01T00:00:00+09:00")
    let targetDate2 = try! calendar.date(from: "2023-10-31T00:00:00+09:00")
    
    // when
    let result1 = SWDay(from: calendar.firstDateOfMonth(date: targetDate1)!)
    let result2 = SWDay(from: calendar.firstDateOfMonth(date: targetDate2)!)
    
    // then
    let expectedResult = SWDay(year: 2023, month: 10, day: 1)
    
    XCTAssertEqual(result1, expectedResult)
    XCTAssertEqual(result2, expectedResult)
  }
}

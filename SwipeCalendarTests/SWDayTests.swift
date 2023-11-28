//
//  SWDayTests.swift
//  SwipeCalendarTests
//
//  Created by doremin on 2023/11/27.
//

import XCTest

@testable import SwipeCalendar

final class SWDayTests: XCTestCase {

  func testSWDay_whenLHSBigger() {
    // when
    let lhs = SWDay(year: 2023, month: 10, day: 13)
    let rhs = SWDay(year: 2023, month: 9, day: 30)
    
    // then
    XCTAssertTrue(lhs > rhs)
  }
  
  func testSWDay_whenRHSBigger() {
    // when
    let lhs = SWDay(year: 2023, month: 10, day: 31)
    let rhs = SWDay(year: 2023, month: 11, day: 4)
    
    // then
    XCTAssertTrue(lhs < rhs)
  }
}

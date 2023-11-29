//
//  SampleViewController.swift
//  SwipeCalendar
//
//  Created by doremin on 2023/10/16.
//

import UIKit

final class SampleViewController: UIViewController {
  override func loadView() {
    self.view = SWCalendarView()
    super.loadView()
  }
}

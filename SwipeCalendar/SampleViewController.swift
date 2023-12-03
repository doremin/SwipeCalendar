//
//  SampleViewController.swift
//  SwipeCalendar
//
//  Created by doremin on 2023/10/16.
//

import UIKit

final class SampleViewController: UIViewController {
  
  let a = SWCalendarScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    view.addSubview(a)
    a.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.right.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    a.setupSubviews()
  }
}

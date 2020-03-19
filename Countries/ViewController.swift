//
//  ViewController.swift
//  Countries
//
//  Created by Saryong Kang on 2020/03/13.
//  Copyright © 2020 Saryong Kang. All rights reserved.
//

import UIKit
import CocoaLumberjack
import Shared

extension PreferenceKeys {
  var boolProperty: PrefKey<Bool> {
    return .init(name: "BOOL_PROPERTY", defaultValue: true)
  }
}

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let preferences = PreferenceStorage.shared
    DDLogDebug("\(preferences.boolProperty)")
  }
}

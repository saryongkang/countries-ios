//
//  PropertyWrapperSample.swift
//  Shared
//
//  Created by Saryong Kang on 2020/03/17.
//  Copyright © 2020 Saryong Kang. All rights reserved.
//

import Foundation
import CocoaLumberjack

@propertyWrapper
struct UserDefault<Value> {
  let key: String
  let defaultValue: Value

  var wrappedValue: Value {
    get {
      return UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
    }
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}
extension UserDefault where Value == Bool {
  init(key: String) {
    self.init(key: key, defaultValue: false)
  }
}
extension UserDefault where Value: ExpressibleByIntegerLiteral {
  init(key: String) {
    self.init(key: key, defaultValue: 0)
  }
}
extension UserDefault where Value == String {
  init(key: String) {
    self.init(key: key, defaultValue: "")
  }
}

@propertyWrapper
struct Keychain {
  let key: String
  let defaultValue: String
  
  var wrappedValue: String {
    get {
      return KeychainAccess.shared.get(forAccountKey: key) ?? defaultValue
    }
    set {
      do {
        try KeychainAccess.shared.set(newValue, forAccountKey: key)
      } catch {
        DDLogError(error.localizedDescription)
      }
    }
  }
}
extension Keychain {
  init(key: String) {
    self.init(key: key, defaultValue: "")
  }
}

// 사용 예
enum GlobalSettings {
  @UserDefault(key: "TERMS_AGREED")
  static var termsAgreed: Bool
  
  @UserDefault(key: "SHOWS_TURORIAL", defaultValue: false)
  static var showsTutorial: Bool
  
  @Keychain(key: "PASSWORD")
  static var password: String
}

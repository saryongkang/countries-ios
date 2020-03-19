//
//  KeychainAccessTest.swift
//  CountriesTests
//
//  Created by Saryong Kang on 2020/03/17.
//  Copyright © 2020 Saryong Kang. All rights reserved.
//

import CocoaLumberjack
import Quick
import Nimble
@testable import Shared

private let testServiceName = "com.example.test_service"
private let testAccountKey = "test_password"

class KeychainAccessTest: QuickSpec {
  override func spec() {
    describe("KeychainAccess") {
      var keychainAccess: KeychainAccess!
      
      beforeSuite {
        DDLog.add(DDOSLogger.sharedInstance)
      }

      beforeEach {
        keychainAccess = KeychainAccess(serviceName: testServiceName)
      }
      
      afterEach {
        try? keychainAccess.removeAll()
      }
      
      describe(".get(forAccountKey:)") {
        it ("디폴트 값으로 nil을 리턴") {
          expect(keychainAccess.get(forAccountKey: testAccountKey)).to(beNil())
        }
      }

      describe(".exists(forAccountKey:)") {
        it ("디폴트 값으로 false을 리턴") {
          expect(keychainAccess.exists(forAccountKey: testAccountKey)) == false
        }
      }

      describe(".remove(forAccountKey:)") {
        it ("기존 값을 삭제") {
          try? keychainAccess.set("1234", forAccountKey: testAccountKey)
          expect {
            try keychainAccess.removeValue(forAccountKey: testAccountKey)
          }.notTo(raiseException())
          expect(keychainAccess.exists(forAccountKey: testAccountKey)) == false
        }
      }

      describe(".set(:forAccountKey)") {
        it ("기존 값이 없는 경우 추가") {
          expect {
            try keychainAccess.set("1234", forAccountKey: testAccountKey)
          }.notTo(raiseException())
          expect(keychainAccess.exists(forAccountKey: testAccountKey)) == true
          expect(keychainAccess.get(forAccountKey: testAccountKey)) == "1234"
        }
        it ("기존 값이 있는 경우 수정") {
          expect {
            try keychainAccess.set("1234", forAccountKey: testAccountKey)
          }.notTo(raiseException())
          expect {
            try keychainAccess.set("5678", forAccountKey: testAccountKey)
          }.notTo(raiseException())
          expect(keychainAccess.get(forAccountKey: testAccountKey)) == "5678"
        }
        it ("nil 입력일 경우 값을 삭제") {
          expect {
            try keychainAccess.set("1234", forAccountKey: testAccountKey)
          }.notTo(raiseException())
          expect {
            try keychainAccess.set(nil, forAccountKey: testAccountKey)
          }.notTo(raiseException())
          expect(keychainAccess.exists(forAccountKey: testAccountKey)) == false
        }
      }
      
      describe(".removeAll()") {
        it ("모든 값을 삭제") {
          let testAccountKey2 = "test_password_2"
          try? keychainAccess.set("1234", forAccountKey: testAccountKey)
          try? keychainAccess.set("5678", forAccountKey: testAccountKey2)
          expect {
            try keychainAccess.removeAll()
          }.notTo(raiseException())
          expect(keychainAccess.exists(forAccountKey: testAccountKey)) == false
          expect(keychainAccess.exists(forAccountKey: testAccountKey2)) == false
        }
      }
    }
  }
}

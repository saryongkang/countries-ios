//
//  PreferenceStorageEncryptedTest.swift
//  CountriesTests
//
//  Created by Saryong Kang on 2020/03/17.
//  Copyright © 2020 Saryong Kang. All rights reserved.
//

import CocoaLumberjack
import Quick
import Nimble
@testable import Shared

private let testSuiteName = "com.example.test_suite"
private let testServiceName = "com.example.test_service"

extension PreferenceKeys {
  var encryptedProperty: PrefKey<String> { .init(name: "ENCRYPTED_PROPERTY", defaultValue: "default", encrypted: true) }
}

class PreferenceStorageEncryptedTest: QuickSpec {
  override func spec() {
    describe("PreferenceStorage") {
      var preferenceStorage: PreferenceStorage!
      
      beforeSuite {
        DDLog.add(DDOSLogger.sharedInstance)
      }

      beforeEach {
        preferenceStorage = PreferenceStorage(suiteName: testSuiteName, serviceName: testServiceName)
      }
      
      afterEach {
        preferenceStorage.clearAll()
      }
      
      context("암호화된 값을 설정할 경우") {
        it ("올바른 디폴트 값을 리턴") {
          expect(preferenceStorage.encryptedProperty) == "default"
        }

        it ("올바른 String 값을 저장") {
          preferenceStorage.encryptedProperty = "Abracadabra"
          expect(preferenceStorage.encryptedProperty) == "Abracadabra"
        }
      }
    }
  }
}

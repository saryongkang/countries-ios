//
//  PreferenceStorageTest.swift
//  SharedTests
//
//  Created by Saryong Kang on 2020/03/13.
//  Copyright © 2020 Saryong Kang. All rights reserved.
//

import CocoaLumberjack
import Quick
import Nimble
@testable import Shared

private let testSuiteName = "com.example.test_suite"
private let testServiceName = "com.example.test_service"

extension PreferenceKeys {
  var boolPropertyDefaultTrue: PrefKey<Bool> { .init(name: "BOOL_PROPERTY_DEFAULT_TRUE", defaultValue: true) }
  var boolPropertyWithoutDefault: PrefKey<Bool> { .init(name: "BOOL_PROPERTY_NO_DEFAULT") }
  var intPropertyWithoutDefault: PrefKey<Int> { .init(name: "INT_PROPERTY_NO_DEFAULT") }
  var intPropertyWithDefault: PrefKey<Int> { .init(name: "INT_PROPERTY_WITH_DEFAULT", defaultValue: -1234) }
  var doublePropertyWithoutDefault: PrefKey<Double> { .init(name: "DOUBLE_PROPERTY_NO_DEFAULT") }
  var doublePropertyWithDefault: PrefKey<Double> { .init(name: "DOUBLE_PROPERTY_WITH_DEFAULT", defaultValue: 12345.6789) }
}

class PreferenceStorageTest: QuickSpec {
  lazy var userDefaults = UserDefaults(suiteName: testSuiteName)!

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
      
      describe(".subscript(dynamicMember:)") {
        context("디폴트 상태일 때") {
          it ("Bool 타입 키에 대해 false를 리턴") {
            expect(preferenceStorage.boolPropertyWithoutDefault) == false
          }
          it ("Int 타입 키에 대해 0을 리턴") {
            expect(preferenceStorage.intPropertyWithoutDefault) == 0
          }
          it ("Double 타입 키에 대해 0을 리턴") {
            expect(preferenceStorage.doublePropertyWithoutDefault) == Double(0)
          }
          
          it ("설정된 디폴트 Bool 값을 리턴") {
            expect(preferenceStorage.boolPropertyDefaultTrue) == true
          }
          it ("설정된 디폴트 Int 값을 리턴") {
            expect(preferenceStorage.intPropertyWithDefault) == -1234
          }
          it ("설정된 디폴트 Double 값을 리턴") {
            expect(preferenceStorage.doublePropertyWithDefault) == 12345.6789
          }
        }
        
        context("값을 설정할 경우") {
          it ("올바른 Bool 값을 저장") {
            preferenceStorage.boolPropertyDefaultTrue = true
            expect(preferenceStorage.boolPropertyDefaultTrue) == true
            expect(self.userDefaults.bool(forKey: PreferenceKeys().boolPropertyDefaultTrue.name)) == true

            preferenceStorage.boolPropertyDefaultTrue.toggle()
            expect(preferenceStorage.boolPropertyDefaultTrue) == false
          }

          it ("올바른 Int 값을 저장") {
            preferenceStorage.intPropertyWithDefault = 1234
            expect(preferenceStorage.intPropertyWithDefault) == 1234
            expect(self.userDefaults.double(forKey: PreferenceKeys().intPropertyWithDefault.name)) == 1234

            preferenceStorage.intPropertyWithDefault += 1
            expect(preferenceStorage.intPropertyWithDefault) == 1235
          }

          it ("올바른 Double 값을 저장") {
            preferenceStorage.doublePropertyWithDefault = 1234.5678
            expect(preferenceStorage.doublePropertyWithDefault) == 1234.5678
            expect(self.userDefaults.double(forKey: PreferenceKeys().doublePropertyWithDefault.name)) == 1234.5678

            preferenceStorage.doublePropertyWithDefault = -9876.54321
            expect(preferenceStorage.doublePropertyWithDefault) == -9876.54321
          }
        }
      }
    }
  }
}

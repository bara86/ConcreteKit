//
// The MIT License (MIT)
//
// Copyright (c) 2015 Lorenzo Villani
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation
import XCTest

class LocalStorageTest: XCTestCase {
    override func setUp() {
        let defaults = UserDefaults()

        defaults.set(true, forKey: "test.bool")
        defaults.set(123.0, forKey: "test.double")
        defaults.set(3.14, forKey: "test.float")
        defaults.set(123, forKey: "test.int")
        defaults.set("a string", forKey: "test.string")
        defaults.synchronize()
    }

    func testExistingDefaults() {
        XCTAssert(LocalStorage["test.bool"] == true, "test.bool is true")
        XCTAssert(LocalStorage["test.double"] == 123.0, "test.double equals 123.0 is true")
        XCTAssert(LocalStorage["test.float"] == 3.14 as Float, "test.float equals 3.14")
        XCTAssert(LocalStorage["test.int"] == 123, "test.int equals 123")
        XCTAssert(LocalStorage["test.string"] == "a string", "test.string equals \"a string\"")
    }

    func testMissingDefaults() {
        XCTAssert(LocalStorage["test.missing.bool"] == false, "test.missing.bool is true")
        XCTAssert(LocalStorage["test.missing.double"] == 0.0, "test.missing.double equals 123.0")
        XCTAssert(LocalStorage["test.missing.float"] == 0 as Float, "test.missing.float equals 3.14")
        XCTAssert(LocalStorage["test.missing.int"] == 0, "test.missing.int equals 123")
        XCTAssert(LocalStorage["test.missingstring"] == "", "test.missing.string equals \"a string\"")
    }

    func testChangedDefaults() {
        LocalStorage["test.changed.bool"] = true
        LocalStorage["test.changed.double"] = 512.0
        LocalStorage["test.changed.float"] = 1024.0
        LocalStorage["test.changed.int"] = 2048
        LocalStorage["test.changed.string"] = "another value"

        XCTAssert(LocalStorage["test.changed.bool"] == true, "test.changed.bool is true")
        XCTAssert(LocalStorage["test.changed.double"] == 512.0, "test.changed.double equals 512.0")
        XCTAssert(LocalStorage["test.changed.float"] == 1024.0 as Float, "test.changed.float equals 1024.0")
        XCTAssert(LocalStorage["test.changed.int"] == 2048, "test.changed.int equals 2048")
        XCTAssert(LocalStorage["test.changed.string"] == "another value", "test.changed.string equals \"another value\"")
    }

    func testOnce() {
        let sentinelKey = "sentinel"

        LocalStorage[sentinelKey] = true

        var callCount = 0

        // With a sentinel set to true, the function must not be called
        LocalStorage.once(sentinelKey) {
            callCount += 1
        }

        XCTAssert(callCount == 0, "The function must not be called if the sentinel value is already set")

        // The sentinel value is set to false, thus the function must be called at most once.
        LocalStorage[sentinelKey] = false

        for _ in 0 ..< 10 {
            LocalStorage.once(sentinelKey) {
                callCount += 1
            }
        }

        XCTAssert(callCount == 1, "The function must be called at most once")
    }
}

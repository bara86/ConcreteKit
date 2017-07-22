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

class NSDateExtensionTest: XCTestCase {
    func testComponents() {
        let date = Date(timeIntervalSince1970: 0)
        let components = date.components

        XCTAssertEqual(1970, components.year, "Year must be 1970")
        XCTAssertEqual(1, components.month, "Month must be January")
        XCTAssertEqual(1, components.day, "Day must be the 1st")
        XCTAssertEqual(0, components.hour, "Hour must be midnight")
        XCTAssertEqual(0, components.minute, "Minute must be zero")
        XCTAssertEqual(0, components.second, "Second must be zero")
    }

    func testAfter() {
        let date1 = Date(timeIntervalSince1970: 0)
        let date2 = Date(timeIntervalSince1970: 1)

        XCTAssertTrue(date1.after(date: date1), "date1 is after itself")
        XCTAssertTrue(date2.after(date: date1), "date2 is after date1")
        XCTAssertFalse(date1.after(date: date2), "date1 is not after date2")
    }

    func testBefore() {
        let date1 = Date(timeIntervalSince1970: 0)
        let date2 = Date(timeIntervalSince1970: 1)

        XCTAssertTrue(date1.before(date: date2), "date1 is before date2")
        XCTAssertFalse(date1.before(date: date1), "date1 is not before itself")
        XCTAssertFalse(date2.before(date: date1), "date2 is not before date1")
    }

    func testDaysUntil() {
        let date1 = Date(timeIntervalSince1970: 0)
        let date2 = Date(timeIntervalSince1970: 30)
        let date3 = Date(timeIntervalSince1970: 86400)
        let date4 = Date(timeIntervalSince1970: 86401)
        let date5 = Date(timeIntervalSince1970: 172800)

        XCTAssertEqual(0, date1.daysUntil(date1), "0 days between date1 and itself")
        XCTAssertEqual(0, date1.daysUntil(date2), "0 days between date1 and date2")
        XCTAssertEqual(1, date1.daysUntil(date3), "1 day between date1 and date3 (which is exactly 86400 seconds after date1)")
        XCTAssertEqual(1, date1.daysUntil(date4), "1 day between date1 and date4 (which is one day and one second after date1)")
        XCTAssertEqual(2, date1.daysUntil(date5), "2 days between date1 and date5 (which is exactly 2 days after date1)")
    }

    func testExtendedBy() {
        let date1 = Date(timeIntervalSince1970: 0)
        let date2 = Date(timeIntervalSince1970: 86400)

        var day = DateComponents()
        day.day = 1

        XCTAssertEqual(date2, date1.extended(by: day), "")
    }
}

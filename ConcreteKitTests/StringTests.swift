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

class StringTests: XCTestCase {
    func testLength() {
        XCTAssertEqual(0, "".length)
        XCTAssertEqual(1, "h".length)
        XCTAssertEqual(12, "hello world!".length)
    }
    
    func testLevenstheinDegenerate() {
        XCTAssertEqual(0, "".distanceTo(""), "Empty strings must have a distance of zero")
        XCTAssertEqual(0, "eq".distanceTo("eq"), "Equal strings must have a distance of zero")
        XCTAssertEqual(4, "".distanceTo("zwei"), "Empty string must have a distance equal to the other string")
        XCTAssertEqual(5, "three".distanceTo(""), "A string must have a distance to the empty string equal to its length")
    }

    func testLevenshtein() {
        XCTAssertEqual(1, "kitten".distanceTo("sitten"), "Must have a distance of one")
        XCTAssertEqual(1, "sitten".distanceTo("sittin"), "Must have a distance of one")
        XCTAssertEqual(1, "sittin".distanceTo("sitting"), "Must have a distance of one")

        // Reversed
        XCTAssertEqual(1, "sitten".distanceTo("kitten"), "Must have a distance of one")
        XCTAssertEqual(1, "sittin".distanceTo("sitten"), "Must have a distance of one")
        XCTAssertEqual(1, "sitting".distanceTo("sittin"), "Must have a distance of one")
    }

    func testLevenshteinLikeness() {
        XCTAssertEqual(Float(0.75), "bite".likenessTo("kite"), "Must have a likeness of 75%")
    }

    func testLevenshteinPerformance() {
        self.measure {
            for _ in 0...1000 {
                _ = "Performance Testing in Xcode".likenessTo("xcode")
            }
        }
    }

    func testLevenshteinPerformanceMinLikeness() {
        self.measure {
            for _ in 0...1000 {
                _ = "Performance Testing in Xcode".likenessTo("xcode", minLikeness: 0.9)
            }
        }
    }
    
    func testSubscript() {
        XCTAssertEqual("e", "hello world!"[1])
    }
}

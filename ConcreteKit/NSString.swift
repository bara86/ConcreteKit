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
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENother. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

public extension String {
    /// Subscript notation to address a single character in the string.
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }

    /// The length of this string, assuming it is encoded as UTF-8.
    public var length: Int {
        get {
            return self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        }
    }

    /// Calculates the Levenshtein distance to another string. The semantic is the same as
    /// `distanceTo' but the result is returned as a normalized value between 0.0 and 1.0.
    /// 
    /// :param: other The string we are calculating the distance to.
    public func likenessTo(other: String) -> Float {
        return 1.0 - (Float(self.distanceTo(other)) / Float(max(self.length, other.length)))
    }

    /// Calculates the Levenshtein distance to another string, assuming that both strings are
    /// encoded with UTF-8.
    ///
    /// :param: other The string we are calculating the distance to.
    public func distanceTo(other: String) -> Int {
        if self == other {
            return 0
        }

        if self.length == 0 {
            return other.length
        }

        if other.length == 0 {
            return self.length
        }

        var work0 = [Int](count: other.length + 1, repeatedValue: 0)
        var work1 = [Int](count: other.length + 1, repeatedValue: 0)

        for var i = 0; i < work0.count; i++ {
            work0[i] = i
        }

        for var i = 0; i < self.length; i++ {
            work1[0] = i + 1;

            for var j = 0; j < other.length; j++ {
                let cost = self[i] == other[j] ? 0 : 1

                work1[j + 1] = min(work1[j] + 1, work0[j + 1] + 1, work0[j] + cost)
            }

            work0 = work1
        }
        
        return work1[other.length]
    }
}
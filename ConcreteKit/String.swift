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
        return self[self.startIndex.advancedBy(i)]
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
    /// - parameter other: The string we are calculating the distance to.
    /// - parameter minLikeness: The minimum acceptable likeness, in a range between 0.0 and 1.0.
    ///         Values outside the range are interpreted as 0.0.
    public func likenessTo(other: String, minLikeness: Float = 0.0) -> Float {
        let countSelf = self.characters.count
        let countOther = other.characters.count
        let countMax = Float(max(countSelf, countOther))
        let distance: Int

        if minLikeness <= 0.0 || minLikeness > 1.0 {
            // Fast path
            distance = self.distanceTo(other)
        } else {
            distance = self.distanceTo(other, maxDistance: Int(countMax * (1.0 - minLikeness)))
        }

        return 1.0 - Float(distance) / countMax
    }

    /// Calculates the Levenshtein distance to another string.
    ///
    /// - parameter other: The string we are calculating the distance to.
    /// - parameter maxDistance: The maximum acceptable distance. Zero means no limit.
    ///
    /// - returns: The edit distance between strings. If ``maxDistance`` is not zero the returned
    ///           value is eventually clamped to the value of ``maxDistance``.
    public func distanceTo(other: String, maxDistance: Int = 0) -> Int {
        // Minor optimization, let's avoid calling count() too many times.
        let countSelf = self.characters.count
        let countOther = other.characters.count

        // If either string is of length zero, the distance is the length of the other string.
        if countSelf == 0 {
            return countOther
        } else if countOther == 0 {
            return countSelf
        }

        // The starting distance is the difference in length between the two strings.
        var distance = abs(self.length - other.length)

        // Stop early if we already reached the maximum acceptable distance.
        if maxDistance > 0 && distance >= maxDistance {
            return distance
        }

        // Save the starting position so that we can increment it later without using advance()
        // which is O(N) for Strings.
        var posSelf = self.startIndex
        var posOther = other.startIndex

        // Iterate only over the character set common to both substrings, since all subsequent
        // characters are automatically different and count as edit distance.
        for _ in 0...min(countSelf, countOther) - 1 {
            if self[posSelf] != other[posOther] {
                distance++
            }

            // Early termination in case we reach the maximum acceptable distance.
            if maxDistance > 0 && distance >= maxDistance {
                return distance
            }

            // Advance to the next character.
            posSelf = posSelf.successor()
            posOther = posOther.successor()
        }

        return distance
    }
}
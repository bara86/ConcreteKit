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

extension Int {
    /// Alias for `days'.
    var day: NSDateComponents {
        return self.days
    }

    /// Returns an NSDateComponents with the `day' component equal to self.
    var days: NSDateComponents {
        let components = NSDateComponents()

        components.day = self

        return components
    }

    /// Alias for `months'.
    var month: NSDateComponents {
        return self.months
    }

    /// Returns an NSDateComponents with the `month' component equal to self.
    var months: NSDateComponents {
        let components = NSDateComponents()

        components.month = self

        return components
    }

    /// Alias for `years'.
    var year: NSDateComponents {
        return self.years
    }

    /// Returns an NSDateComponents with the `year' component equal to self.
    var years: NSDateComponents {
        let components = NSDateComponents()

        components.year = self

        return components
    }
}
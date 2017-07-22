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

public extension Int {
    /// Alias for `seconds'.
    public var second: DateComponents {
        return self.seconds
    }

    /// Returns an NSDateComponents with the `second' component equal to self.
    public var seconds: DateComponents {
        var components = DateComponents()

        components.second = self

        return components
    }

    /// Alias for `minutes'.
    public var minute: DateComponents {
        return self.minutes
    }

    /// Returns an NSDateComponents with the `minute' component equal to self.
    public var minutes: DateComponents {
        var components = DateComponents()

        components.minute = self

        return components
    }

    /// Alias for `hours'.
    public var hour: DateComponents {
        return self.hours
    }

    /// Returns an NSDateComponents with the `hour' component equal to self.
    public var hours: DateComponents {
        var components = DateComponents()

        components.hour = self

        return components
    }

    /// Alias for `days'.
    public var day: DateComponents {
        return self.days
    }

    /// Returns an NSDateComponents with the `day' component equal to self.
    public var days: DateComponents {
        var components = DateComponents()

        components.day = self

        return components
    }

    /// Alias for `months'.
    public var month: DateComponents {
        return self.months
    }

    /// Returns an NSDateComponents with the `month' component equal to self.
    public var months: DateComponents {
        var components = DateComponents()

        components.month = self

        return components
    }

    /// Alias for `years'.
    public var year: DateComponents {
        return self.years
    }

    /// Returns an NSDateComponents with the `year' component equal to self.
    public var years: DateComponents {
        var components = DateComponents()

        components.year = self

        return components
    }
}

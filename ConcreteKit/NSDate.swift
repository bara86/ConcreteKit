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

public extension NSDate {
    /// Returns an NSDateComponents for this NSDate, with UTC locale.
    public var components: NSDateComponents {
        let flags: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]

        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone(abbreviation: "UTC")!

        return calendar.components(flags, fromDate: self)
    }

    /// Returns true if the given NSDate occurs at the same time or after self.
    ///
    /// - parameter date: The date to compare.
    public func after(date date: NSDate) -> Bool {
        let comparisonResult = self.compare(date)

        return comparisonResult == NSComparisonResult.OrderedSame
            || comparisonResult == NSComparisonResult.OrderedDescending
    }

    /// Returns true if the given NSDate occurs before self, false otherwise.
    ///
    /// - parameter date: The date to compare to.
    public func before(date date: NSDate) -> Bool {
        return self.compare(date) == NSComparisonResult.OrderedAscending
    }

    /// Returns the number of days until the given NSDate. Can be negative.
    ///
    /// - parameter date: The date to compare to.
    public func daysUntil(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self, toDate: date, options: NSCalendarOptions()).day
    }

    /// Returns a new date by adding the given NSDateComponents. Can be combined with the extension
    /// on integers for a fluent API:
    ///
    ///     let future = NSDate().extended(by: 3.days)
    ///
    /// - parameter by: The NSDateComponents to add to self.
    public func extended(by date: NSDateComponents) -> NSDate {
        let calendar = NSCalendar.currentCalendar()

        return calendar.dateByAddingComponents(date, toDate: self, options: NSCalendarOptions())!
    }
}
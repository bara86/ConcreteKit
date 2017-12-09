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

/// A global LocalStorageManager initialized with the defaults for the current user account/application.
public var LocalStorage = LocalStorageManager(defaults: UserDefaults())

/// Provides map-like access to an NSUserDefaults.
///
/// This class provides subscript access to an underlying NSUserDefaults instance in a manner
/// similar to a regular map, except the data is persisted to disk, like a regular NSUserDefaults.
public struct LocalStorageManager {
    let defaults: UserDefaults!

    /// Creates a new instance of a LocalStorageManager using the given NSUserDefaults as
    /// persistent storage.
    ///
    /// - parameter defaults: The NSUserDefaults instance to use as backing store.
    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }

    // MARK: Subscript Notation

    /// Subscript notation to set/get a boolean value.
    public subscript(defaultName: String) -> Bool {
        get {
            return defaults.bool(forKey: defaultName)
        }
        set {
            defaults.set(newValue, forKey: defaultName)
        }
    }

    /// Subscript notation to set/get a double precision floating point value.
    public subscript(defaultName: String) -> Double {
        get {
            return defaults.double(forKey: defaultName)
        }
        set {
            defaults.set(newValue, forKey: defaultName)
        }
    }

    /// Subscript notation to set/get a floating point value.
    public subscript(defaultName: String) -> Float {
        get {
            return defaults.float(forKey: defaultName)
        }
        set {
            defaults.set(newValue, forKey: defaultName)
        }
    }

    /// Subscript notation to set/get an integer value.
    public subscript(defaultName: String) -> Int {
        get {
            return defaults.integer(forKey: defaultName)
        }
        set {
            defaults.set(newValue, forKey: defaultName)
        }
    }

    /// Subscript notation to set/get a string value.
    public subscript(defaultName: String) -> String {
        get {
            if let ret = defaults.string(forKey: defaultName) {
                return ret
            } else {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: defaultName)
        }
    }

    /// Subscript notation to set/get a Date value.
    public subscript(defaultName: String) -> Date? {
        get {
            return defaults.object(forKey: defaultName) as? Date
        }
        set {
            defaults.set(newValue, forKey: defaultName)
        }
    }

    // MARK: Utility

    /// Runs the given function block exactly once.
    ///
    /// Given a sentinel key and a function block, runs the function block if, and only if, the
    /// value associated to the sentinel key evaluates to false.
    ///
    /// This allows to call the given function block exactly once in the entire lifetime of the
    /// application (since the value is persisted to disk) or until the sentinel value is reset to
    /// false.
    ///
    /// - parameter sentinel: The key to use as sentinel value.
    /// - parameter f: The function to call.
    public func once(_ sentinel: String, f: () -> ()) {
        if !self[sentinel] {
            f()

            defaults.set(true, forKey: sentinel)
        }
    }
}

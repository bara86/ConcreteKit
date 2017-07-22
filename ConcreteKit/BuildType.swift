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

// Workaround to prevent "unreachable code" errors in Xcode
internal let IsIPhoneSimulator = TARGET_IPHONE_SIMULATOR != 0

/// Kinds of builds we can detect.
public enum BuildType: CustomStringConvertible {
    case appStore
    case simulator
    case testFlightBeta
    case unknown

    public var description: String {
        switch(self) {
        case .appStore:
            return "AppStore"
        case .simulator:
            return "Simulator"
        case .testFlightBeta:
            return "TestFlightBeta"
        case .unknown:
            return "Unknown"
        }
    }
}

/// Determines where the application is running.
///
/// - returns: - ``BuildType.AppStore`` if the app is being distributed through the AppStore.
///           - ``BuildType.Simulator`` if running in the iPhone Simulator.
///           - ``BuildType.TestFlightBeta`` if the app is being distributed through TestFlight Beta.
///           - ``BuildType.Unknown`` in all other cases.
///
/// **NOTE:** AppStore reviews seem to run in an environment where ``BuildType.TestFlightBeta``
/// is returned.
public func buildType() -> BuildType {
    if IsIPhoneSimulator {
        return .simulator
    }

    if let receipt = Bundle.main.appStoreReceiptURL {
        let name = receipt.lastPathComponent

        if name == "sandboxReceipt" {
            return .testFlightBeta
        } else if name == "receipt" {
            return .appStore
        }
    }

    return .unknown
}

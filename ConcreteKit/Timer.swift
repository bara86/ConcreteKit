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

public typealias Callable = () -> ()

/// Use a Timer to schedule the execution of a function at a later point in time.
public struct Timer {
    /// Schedules the execution of the given function after the given time interval (in seconds)
    /// has elapsed.
    public static func after(_ ti: TimeInterval, f: @escaping Callable) {
        let actor = TimerActor(callable: f)

        Foundation.Timer.scheduledTimer(timeInterval: ti, target: actor, selector: #selector(TimerActor.timerFired(_:)), userInfo: nil, repeats: false)
    }
}

private class TimerActor {
    var f: Callable

    init(callable: @escaping Callable) {
        self.f = callable
    }

    @objc
    func timerFired(_: Foundation.Timer) {
        f()
    }
}

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
import UIKit

/// Resizes an ``UIScrollView`` so that the keyboard doesn't overlap with it.
///
/// This class automatically registers with ``NSNotificationCenter`` to know when the keyboard
/// appears/disappears and automatically resizes the given ``UIScrollView``. It is sufficient to
/// create an instance within an ``UIViewController`` so that an instance of this class lives as
/// long as the controller itself.
open class KeyboardAvoidingManager {
    fileprivate var scrollView: UIScrollView!

    public init(scrollView: UIScrollView) {
        self.scrollView = scrollView

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(KeyboardAvoidingManager.keyboardWasShown(_:)), name: NSNotification.Name(rawValue: "UIKeyboardDidShowNotification"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(KeyboardAvoidingManager.keyboardWillBeHidden(_:)), name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    fileprivate func keyboardWasShown(_ notification: Notification) {
        let userInfo = notification.userInfo as! [String : AnyObject]
        let size = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, size.height, 0)

        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc
    fileprivate func keyboardWillBeHidden(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

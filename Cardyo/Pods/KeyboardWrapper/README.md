# KeyboardWrapper
[![Build Status](https://travis-ci.org/zummenix/KeyboardWrapper.svg?branch=master)]
(https://travis-ci.org/zummenix/KeyboardWrapper)
[![Cocoapod](https://img.shields.io/cocoapods/v/KeyboardWrapper.svg)](https://cocoapods.org/pods/KeyboardWrapper)

A safe wrapper for UIKeyboard notifications written in Swift.

<img src="https://raw.github.com/zummenix/KeyboardWrapper/master/demo.gif" alt="Demo" width="372" height="662"/>

## Usage

- Import module
```Swift
import KeyboardWrapper
```

- Create `KeyboardWrapper` instance
```Swift
keyboardWrapper = KeyboardWrapper(delegate: self)
```

- Implement `KeyboardWrapperDelegate`
```Swift
extension ViewController: KeyboardWrapperDelegate {
    func keyboardWrapper(wrapper: KeyboardWrapper, didChangeKeyboardInfo info: KeyboardInfo) {

        if info.state == .WillShow || info.state == .Visible {
            bottomConstraint.constant = info.endFrame.size.height
        } else {
            bottomConstraint.constant = 0.0
        }

        UIView.animateWithDuration(info.animationDuration, delay: 0.0, options: info.animationOptions, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
```

## Installation

KeyboardWrapper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KeyboardWrapper', '~> 1.0.0'
```

## License

KeyboardWrapper is available under the MIT license. See the LICENSE file for more info.

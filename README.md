# GrowingTextView

[![Version](https://img.shields.io/cocoapods/v/GrowingTextView.svg?style=flat)](http://cocoapods.org/pods/GrowingTextView)
[![License](https://img.shields.io/cocoapods/l/GrowingTextView.svg?style=flat)](http://cocoapods.org/pods/GrowingTextView)
[![Platform](https://img.shields.io/cocoapods/p/GrowingTextView.svg?style=flat)](http://cocoapods.org/pods/GrowingTextView)

![ScreenShot](DEMO.gif)

## Requirements

iOS 8.0 or above

## Usage

First import the GrowingTextView framework

```swift
import GrowingTextView
```

Create an instance of GrowingTextView

```swift
let textView = GrowingTextView()
addSubview(textView)
```

## Customization

Parameter | Type | Description | Default
--- | --- | --- | ---
*maxLength* | Int | Maximum text length. Exceeded text will be trimmed. 0 means no limit. | *0*
*trimWhiteSpaceWhenEndEditing* | Bool | Maximum text length. Exceeded text will be trimmed. 0 means no limit. | *true*
*placeHolder* | String? | PlaceHolder text. | *nil*
*placeHolderColor* | UIColor? | PlaceHolder text color. | *nil*
*placeHolderLeftMargin* | CGFloat | Left margin of PlaceHolder text. | *5.0*
*maxHeight* | CGFloat | Maximum height of textview. | *0.0*

#### Examples

```swift
textView.maxLength = 140
textView.trimWhiteSpaceWhenEndEditing = false
textView.placeHolder = "Say something..."
textView.placeHolderColor = UIColor(white: 0.8, alpha: 1.0)
textView.maxHeight = 70.0
textView.backgroundColor = UIColor.whiteColor()
textView.layer.cornerRadius = 4.0
```

## Animation
To animate the height change, adopt GrowingTextViewDelegate protocol instead of UITextViewDelegate.

```swift
class ViewController: UIViewController, GrowingTextViewDelegate {
...
```

Implement textViewDidChangeHeight. Call layoutIfNeeded() inside an animation. 

```swift
func textViewDidChangeHeight(height: CGFloat) {
   UIView.animateWithDuration(0.2) { () -> Void in
       self.textView.layoutIfNeeded()
   }
}
```

In some cases, you may also need to animate it's superview, e.g. toolbar.

```swift
func textViewDidChangeHeight(height: CGFloat) {
   UIView.animateWithDuration(0.2) { () -> Void in
       self.myToolbar.layoutIfNeeded()
   }
}
```

## Installation with CocoaPods

GrowingTextView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GrowingTextView"
```

## Installation Manually

You may just copy GrowingTextView.swift into your project. That's it!

## Author

BigSmallDog, doglittlebig@gmail.com

## License

GrowingTextView is available under the MIT license. See the LICENSE file for more info.
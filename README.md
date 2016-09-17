# GrowingTextView

[![Version](https://img.shields.io/cocoapods/v/GrowingTextView.svg?style=flat)](http://cocoapods.org/pods/GrowingTextView)
[![License](https://img.shields.io/cocoapods/l/GrowingTextView.svg?style=flat)](http://cocoapods.org/pods/GrowingTextView)
[![Platform](https://img.shields.io/cocoapods/p/GrowingTextView.svg?style=flat)](http://cocoapods.org/pods/GrowingTextView)
[![Language](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](http://cocoapods.org/pods/GrowingTextView)

<img src="DEMO.gif" border=1 style="border-color:#eeeeee">

## Requirements

iOS 8.0 or above

## Installation

#### CocoaPods

GrowingTextView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

Swift 3<br>
```ruby
pod "GrowingTextView"
```

Swift 2.3<br>
```ruby
pod 'GrowingTextView', :git => 'https://github.com/KennethTsang/GrowingTextView.git', :branch => 'swift2'
```

#### Manually

Copy `GrowingTextView.swift` into your project.

## Usage

```swift
let textView = GrowingTextView()
addSubview(textView)
```

## Customization

Parameter | Type | Description | Default
--- | --- | --- | ---
*maxLength* | Int | Maximum text length. Exceeded text will be trimmed. 0 means no limit. | *0*
*trimWhiteSpaceWhenEndEditing* | Bool | Trim white space and new line characters when textview did end editing. | *true*
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
func textViewDidChangeHeight(_ height: CGFloat) {
   UIView.animate(withDuration: 0.2) {
       self.textView.layoutIfNeeded()
   }
}
```

In some cases, you may also need to animate it's superview, e.g. toolbar.

```swift
func textViewDidChangeHeight(_ height: CGFloat) {
   UIView.animate(withDuration: 0.2) {
       self.myToolbar.layoutIfNeeded()
   }
}
```

## Author

Kenneth Tsang, kenneth.tsang@me.com

## License

GrowingTextView is available under the MIT license. See the LICENSE file for more info.

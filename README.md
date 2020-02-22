# THWebview
#### Super Easy WKWebView for simple web page.

# Feature
- [x] pure swift 5.0 code
- [x] class is custom UIView and overiding Webkit
- [x] you can load Webpage or Website 
- [x] require Swift 5.0 or later

# Installation

#### CocoaPods
Simply add THWebview to your `Podfile`.

```
pod 'THWebview'
```
Enter command instruction into your terminal.

```
pod install
```

# Usage

You must create UIView and it use custom class in the storyboard after install THWebview.

![](./screenshot.png)

Then you must also import THWebview and create a IBOutlet.

![](./screenshot1.png)

The following sample code for your reference.

```swift
import UIKit
import THWebview

class ViewController: UIViewController {

    @IBOutlet weak var web: THWebview!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        web.isIndicator = true
        web.isGestureForworkBack = true
        web.loadWeb(url: "https://m.youtube.com")
    }
}
```

# License

THWebview is available under the MIT license. See the LICENSE file for more info.


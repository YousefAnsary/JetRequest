
# JetRequest
***Swift iOS Cocoapod That Simply Handles Any Network Operation for You.***
![](https://raw.githubusercontent.com/YousefAnsary/JetRequest/master/logo.png)

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

### Features

- [x] Fully Based on URLSessions and Written using Swift 4.2
- [x] Supports all Basic HTTP Methods, File Upload& Download
- [x] URL, JSON, FormData Parameter Encoding
- [x] Upload and Download Progress Tracking
- [x] Supports multipart uploading
- [x] Extends UIImageView to Set online Images Directly with caching options
- [x] Comes with a Variety of Response Handling Styles
- [ ] Supports pre-request& retry handling (soon)
- [ ] Supports RxSwift (soon)
- [ ] Supports Combine (soon)

### Requirements
- Swift 4.2+
- Xcode 11+

### Installation
**Cocoapod**

``` pod 'JetRequest' ```

**Swift Package Manager**

Soon

### Usage
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| request      | path: String, httpMethod: HTTPMethod | Request |
| request      | fullURL: String, httpMethod: HTTPMethod | Request |
| request      | URL: URL, httpMethod: HTTPMethod | Request |
| request      | requestable: JetRequestable, completion: closure  | Request |
                
----

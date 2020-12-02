
# JetRequest
***Swift iOS Cocoapod That Simply Handles Any Network Operation for You.***
![](https://raw.githubusercontent.com/YousefAnsary/JetRequest/master/logo.png?s=550)

### Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

----

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

----

### Requirements
- Swift 4.2+
- Xcode 11+

----

### Installation
**Cocoapod**

``` pod 'JetRequest', :git => 'https://github.com/YousefAnsary/JetRequest.git' ```

**Swift Package Manager**

*Soon*

----

### Usage
**Firstly before making any requests initialize the session by calling** 
<br/> <br/>
```
// preferred in appDelegate.application(didFinishLaunchingWithOptions:)
JetRequest.initSession(baseURL: "http://www.myBaseUrl.com/api/") 
```
<br/> <br/>
*or if you want your session configuration to be another type not default*
<br/> <br/>
```  JetRequest.initSession(baseURL: "apiUrl/", sessionConfiguration: URLSessionConfiguration.demandedType)  ```
<br/> <br/>

&nbsp; &nbsp; **JetRequest**
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| initSession      | baseURL: String, sessionConfiguration: URLSessionConfiguration = .default | - |
| request      | path: String, httpMethod: HTTPMethod | Request |
| request      | fullURL: String, httpMethod: HTTPMethod | Request |
| request      | URL: URL, httpMethod: HTTPMethod | Request |
| request      | requestable: JetRequestable, completion: closure | - |
| downloadFile      | url: String, headers: [String: String]?, params: [String: Any]?  | JetTask |
| uploadImage //multipart | toUrl: String, images: [Image], headers: [String: String]?, params: [String: String]? | JetTask |

----
&nbsp; &nbsp; **Request**
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| set      | headers: [String: String] | Request |
| set      | urlParams: [String: Any] | Request |
| set      | bodyParams: [String: Any?], encoding: ParametersEncoding | Request |
| fire     | completion: (Data?, URLResponse?, Error?)-> Void | - |
| fire     | completion: (Result<([String: Any?]?, Int?), JetError>)-> Void | - |
| fire     | completion: (Result<(T?, Int?), JetError>)-> Void | - |
| cancel   | - | - |

----
&nbsp; &nbsp; **JetTask**
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| fire     | completion: (Data?, URLResponse?, Error?)-> Void | - |
| trackProgress     | completion: (Progress)-> Void | - |
| cancel   | - | - |

----
&nbsp; &nbsp; **JetError**
| Variable | Type
|:------------:| :------------: |
| data | Data? |
| error | Error? |
| statusCode | Int? |

----
&nbsp; &nbsp; **JetImage**
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| downloadImage | url: String, completion: (UIImage?)-> Void | - |
| clearCache | forUrl: String | - |
| clearCache | - | - |

----
&nbsp; &nbsp; **UIIMageView Extension**
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| loadImage | fromUrl: String, defaultImage: UIImage? = nil,<br/> completion: ((success: Bool, isCached: Bool)-> Void)? = nil | - |

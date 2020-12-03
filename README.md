
# JetRequest
***Swift iOS Cocoapod That Simply Handles Any Network Operation for You.***
![](https://raw.githubusercontent.com/YousefAnsary/JetRequest/master/logo.png?s=550)

### Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)

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

----
### Examples
```
var request = JetRequest.request(path: "path", httpMethod: .get) //Or
//  var request = JetRequest.request(fullURL: "fullUrl", httpMethod: .delete) //Or
//  var request = JetRequest.request(URL: URL(string: "URL")!, httpMethod: .post)
        
request = request.set(headers: ["key": "value"])
                 .set(urlParams: ["key1": "value", "key2": 1])
                 .set(bodyParams: ["key1": "value", "key2": 1], encoding: .formData)
        
request.fire { (data: Data?, res: URLResponse?, err: Error?) in }
        
request.fire { (res: Result<([String : Any?]?, Int?), JetError>) in
        switch res {
        case .success((let dict, let statusCode)):
             print(dict)
             print(statusCode)
        case .failure(let err):
             print(err)
             // err.data (Data?)
             // err.statusCode (Int?)
             // err.error (Error?)
        }
}
        
request.fire { (res: Result<(MyDecodableModel?, Int?), JetError>) in
        switch res {
        case .success((let decodedObject, let statusCode)):
             print(decodedObject)
             print(statusCode)
        case .failure(let err):
             print(err)
             // err.data (Data?)
             // err.statusCode (Int?)
             // err.error (Error?)
        }
}
```
Or Using JetRequestable Protocol
```
struct Request: JetRequestable {
    var path: String = "path"
    var headers: [String : String]? = nil
    var httpMethod: HTTPMethod = .get
    var parameterEncoding: ParametersEncoding = .defaultEncoding
    
    // Parameters
    var param1: Int!
    var name: String!
    
    // In case of parameters variable name is different from demanded key 
    // Or you can set it to nil and do not create such a struct
    var keysContainer: KeyedParams? = Keys()
    struct Keys: KeyedParams {
        let param1 = "id"
    }   
} // End of Request Struct

let request = MyJetRequestableStruct(param1: 1, name: "")

// Then fire directly
request.fire { (data: Data?, res: URLResponse?, err: Error?) in }
request.fire { (res: Result<([String : Any?]?, Int?), JetError>) in }
request.fire { (res: Result<((MyDecodableModel?)?, Int?), JetError>) in }

// Or Through request method 
JetRequest.request(requestable: request, completion: { (data: Data?, res: URLResponse?, err: Error?) in })
JetRequest.request(requestable: request, completion: { (res: Result<([String : Any?]?, Int?), JetError>) in })
JetRequest.request(requestable: request, completion: { (res: Result<((MyDecodableModel?)?, Int?), JetError>) in })
```

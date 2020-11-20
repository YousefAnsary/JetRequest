
# JetRequest
***Swift iOS Cocoapod That Simply Handles Any Network Operation for You.***
![](https://raw.githubusercontent.com/YousefAnsary/JetRequest/master/logo.png)
<!---
![](https://img.shields.io/github/stars/pandao/editor.md.svg) ![](https://img.shields.io/github/forks/pandao/editor.md.svg) ![](https://img.shields.io/github/tag/pandao/editor.md.svg) ![](https://img.shields.io/github/release/pandao/editor.md.svg) ![](https://img.shields.io/github/issues/pandao/editor.md.svg) ![](https://img.shields.io/bower/v/editor.md.svg) --->

**Table of Contents**

[TOC]

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

### Installation
**Cocoapod**

``` pod 'JetRequest' ```

**Swift Package Manager**

Soon

####Javascript　

```javascript

```

<!---###Lists

####Unordered list (-)

- Item A
- Item B
- Item C
     
####Unordered list (*)

* Item A
* Item B
* Item C

####Unordered list (plus sign and nested)
                
+ Item A
+ Item B
    + Item B 1
    + Item B 2
    + Item B 3
+ Item C
    * Item C 1
    * Item C 2
    * Item C 3

####Ordered list
                
1. Item A
2. Item B
3. Item C
                
----
                    
###Tables
                    
First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell 

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

| Function name | Description                    |
| ------------- | ------------------------------ |
| `help()`      | Display the help window.       |
| `destroy()`   | **Destroy your computer!**     |

| Item      | Value |
| --------- | -----:|
| Computer  | $1600 |
| Phone     |   $12 |
| Pipe      |    $1 |
--->
###Usage
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| request      | path: String, httpMethod: HTTPMethod | Request |
| request      | fullURL: String, httpMethod: HTTPMethod | Request |
| request      | URL: URL, httpMethod: HTTPMethod | Request |
| request      | requestable: JetRequestable, completion: closure  | Request |
                
----

<!---###FlowChart

```flow
st=>start: initSession
op=>operation: Login operation
cond=>condition: Successful Yes or No?
e=>end: To admin

st->op->cond
cond(yes)->e
cond(no)->op
```
--->
###Sequence Diagram
                    
```seq
Andrew->China: Says Hello 
Note right of China: China thinks\nabout it 
China-->Andrew: How are you? 
Andrew->>China: I am good thanks!
```

###End

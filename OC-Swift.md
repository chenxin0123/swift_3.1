#### const

```
OC 
const int i = 10;
Swift
let i = 10
```

#### typedef

````
OC
typedef UInt64 MYUInteger;
Swift
typealias MYUInteger = UInt64

````



#### nil

````
OC
不存在的OC对象的指针
Swift
You set an optional variable to a valueless state by assigning it the special value nil
nil cannot be used with nonoptional constants and variables.
````

#### =，+=

```
Swith中的=并不返回值
OC 
if (a = b) ... // ok
let c = a+=b // ok
Swith
if a = b ... // not ok
let c = a+=b // not ok
```

#### Mutability

```
OC
NSString NSMutableString
NSArray  NSMutableArray // dictionary set
Swith
var s = "s" // mutable
let s = "s" // immutable
var arr = [1,2,3] // mutable
let arr = [1,2,3] // immutable

```

#### Variadic Parameters

```
OC
- (void)xxx:(NSString *)s,...// 可以是多种类型的参数
C 
void xxx(int i,...) // 可以是多种类型的参数
OC/C
va_list args;
va_start(args, sql);
va_arg(args, type);
va_end(args);

Swift
func xxx(_ numbers: Double...) // 只能是double 
numbers被当成Array使用
```

#### In-Out Parameters

```
OC/C
void swap(int *a, int *b)
swap(&a,&b)
Swift
func swap(_ a: inout Int, _ b: inout Int)
swap(&a,&b)

```

#### Function Pointer

```
C
void (*swapFunction)(int *a, int *b)  = &swap;
Swift
var swapFunction: (_ a: inout Int, _ b: inout Int) -> Void = swap
```


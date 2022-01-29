## NULL & nil & Nil & NSNULL

* `nil`  是 OC 的，空对象，地址指向 空(0) 的对象
    * 在 OC 中，可以给空对象发送任何消息，不会出现错误
* `NULL` 是 C 的，空地址，地址的数值是 0，是一个长整数
    * 表示地址是空
* `NSNull` 用于解决向 `NSArray` 和 `NSDictionary` 等集合中添加空值的问题

|  | 值 | 定义 |
| -- | -- | -- |
| NULL | (void *)0 | C指针的字面零值 |
| nil | (id)0 | Objective-C对象的字面零值 |
| Nil | (Class)0 | Objective-C类的字面零值 |
| NSNull | [NSNull null] | 用来表示零值的单独的对象 |


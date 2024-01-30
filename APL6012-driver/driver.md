```c
module_i2c_driver(apl6012_driver);
```
```c
/**
 * module_i2c_driver() - Helper macro for registering a modular I2C driver
 * @__i2c_driver: i2c_driver struct
 *
 * Helper macro for I2C drivers which do not do anything special in module
 * init/exit. This eliminates a lot of boilerplate. Each module may only
 * use this macro once, and calling it replaces module_init() and module_exit()
 */
#define module_i2c_driver(__i2c_driver) \
        module_driver(__i2c_driver, i2c_add_driver, \
                        i2c_del_driver)
```
```c
/**
 * module_driver() - Helper macro for drivers that don't do anything
 * special in module init/exit. This eliminates a lot of boilerplate.
 * Each module may only use this macro once, and calling it replaces
 * module_init() and module_exit().
 *
 * @__driver: driver name
 * @__register: register function for this driver type
 * @__unregister: unregister function for this driver type
 * @...: Additional arguments to be passed to __register and __unregister.
 *
 * Use this macro to construct bus specific macros for registering
 * drivers, and do not use it on its own.
 */
#define module_driver(__driver, __register, __unregister, ...) \
static int __init __driver##_init(void) \
{ \
        return __register(&(__driver) , ##__VA_ARGS__); \
} \
module_init(__driver##_init); \
static void __exit __driver##_exit(void) \
{ \
        __unregister(&(__driver) , ##__VA_ARGS__); \
} \
module_exit(__driver##_exit);
```
,  
```c
module_i2c_driver(apl6012_driver);
```
會先展開成
```c
module_driver(apl6012_driver, i2c_add_driver, i2c_del_driver);
```
再展開成
```c
static int __init apl6012_driver_init(void)
{
    return i2c_add_driver(&apl6012_driver);
}
module_init(apl6012_driver_init);

static void __exit apl6012_driver_exit(void)
{
    i2c_del_driver(&apl6012_driver);
}
module_exit(apl6012_driver_exit);
```
在C語言中, ## 是一個預處理操作符, 用於連接兩個符號（token）。  
在宏定義中, ## 允許將參數和前綴或後綴連接在一起, 形成一個新的標識符, 這對於在宏定義中創建唯一的標識符是很有用的。  
如:  
&nbsp;&nbsp;&nbsp;&nbsp;__driver##_init 會被展開為 apl6012_driver_init。  
&nbsp;&nbsp;&nbsp;&nbsp;__register 會被展開為 i2c_add_driver。  
&nbsp;&nbsp;&nbsp;&nbsp;__unregister 會被展開為 i2c_del_driver。  
可以發現展開完跟我們最早接觸的 hello world driver 有點像了:
```c
/* hello.c */
#include <linux/init.h>
#include <linux/module.h>

MODULE_DESCRIPTION("Hello_world");
MODULE_LICENSE("GPL");

static int hello_init(void)
{
    printk(KERN_INFO "Hello world !\n");
    return 0;
}

static void hello_exit(void)
{
    printk(KERN_INFO "ByeBye !\n");
}

module_init(hello_init);

module_exit(hello_exit);
```
module_i2c_driver 也是基於 module_init 跟 module_exit 的。  
其他類型的 driver 也應該是如此。  
  
-------------------------------------------------------------  

```c
static struct i2c_driver apl6012_driver = {
	.driver = {
		.name = "apl6012",
		.of_match_table = apl6012_of_match,
	},
	.probe = apl6012_probe,
	.remove = apl6012_remove,
	// .id_table = apl6012_id,
};
```
遠古時期的 linux kernel 似乎有沒 assign id_table 就無法執行 probe 的問題:  
https://www.cnblogs.com/xiaojiang1025/p/6501956.html  
但這問題 linux kernel 在好幾年前就解決了, 現在的 linux kernel 在做 device tree 的 match 時不用再 assign id_table。

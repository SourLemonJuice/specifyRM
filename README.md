# specifyRM

## 1.介绍

为了更放心的在脚本中使用`rm`所搓的东西啦\
specify 是指在删除前确认路径是否符合预期，比如要删除`/tmp/test233/`文件夹就在删除前验证路径是否以`/tmp`开头或者以`test233`结尾\
在理论上路径中有部分不变的删除操作时，加个检测也更安心一点吧，万一你的变量被神秘力量改成`/usr`或者`NULL`之类的就不好玩了

写这个是因为想起之前写某个脚本时就因为rm的参数是变量，就在debug的时候来回注释rm的那一行...\
反正有空，写个检测脚本以后还能用的上

## 2.函数说明

目前项目有两个函数

- specifyRM_match\
  负责匹配判断条件，只返回状态码，这也是理想中最常用的功能
- specifyRM\
  执行最终删除操作，目前仅作为示例，很可能没有经过测试

> 两者被放在了单独的文件中

可以将全部的行放进需要使用的脚本里并调用\
也可以执行`source "/pathTO/specifyRM_match.sh"`在*当前* SHELL 载入函数

### 2.1.specifyRM_match

已经写了很多注释了，懒了(´･_･`)

```shell
# specifyRM_match v1
# 
# $1 == Match mode
# $2 == Mode options
# $3 == Path to be delete
# 
# return code:
# 0: matched
# 1: no match
# 16: input error
# 
# mode list:
# path.basename -- Match full path basename with $2
# path.prefix -- Match full path prefix with $2
# path.suffix -- Match full path suffix with $2
# dir.prefix -- just match directory name prefix with $2
# dir.suffix -- just match directory name suffix with $2
```

#### 2.2.1.演示

- 匹配成功

```text
shell> specifyRM_match path.basename "2333" "/temp/2333"
shell> echo $?
0
```

- 匹配失败

```text
shell> specifyRM_match dir.suffix "/not.mp" "/te/mp/2333"
shell> echo $?
1
```

### 2.2.specifyRM

目前仅作为示例使用

因为参数会直接传进 specifyRM_match 函数里，所以选项和上面一致\
如果想要真的**删除/rm**，请取消`rm`的注释

```shell
# real RM here
# rm -r "$3"
```

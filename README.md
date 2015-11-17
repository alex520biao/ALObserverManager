# ALObserverManager

## 功能简介

1. 消息标识符实现Observer Pattern(订阅-发布模式),
	
	>类似于NSNotificationCenter一样的一对多订阅-发布模式消息分发

2. (全局/私有)一对多消息分发
	
	>NSNotificationCenter是全局的,任何类都可以监听消息。
	ALObserverManager需要依附某个类的存在,并且监听消息也仅限于此类的范围。
	
3. 支持delegate和block两种消息分发方式
	
	>使用方式与普通delegae、block相同
	
4. 对监听者弱引用,监听自释放
	
	>监听者释放时,监听会会被自动删除。
	
5. 避免监听者重复监听
	
	>同一监听者多次监听同一消息,NSNotificationCenter会有重复监听的问题; ALObserverManager不会产生重复监听。

## 使用方法&Demo
### demo code
`通过demo code 展示此pod的主要功能，使用者阅读了demo code应该可以了解pod的大部分功能，API设计应尽量简洁易懂`

``` objective-c
//demo code here
```
### 公开类

介绍主要类的功能职责，例如：


### 注意事项(可选)



## 内部实现原理（可选）



## 安装

目前都使用cocoapods安装，在Podfile中加入

``` ruby
pod "ALObserverManager" 
```

## 维护者

alex520biao <alex520biao@163.com>

## 版权声明

ALObserverManager开源项目。

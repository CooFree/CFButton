# CFButton

### 效果图
![](./1.gif)

###  PathButton

```
//按钮散落方向 
typedef NS_ENUM(NSUInteger, PathDirection) {
    PathDirectionLeft,
    PathDirectionRight,
    PathDirectionUP,
    PathDirectionDown,
};
```

### MCFireworksButton

```
//将MCFireworksView粒子动画添加在button上
- (void)layoutSubviews {
    [super layoutSubviews];
    self.fireworksView.frame = self.bounds;
    [self insertSubview:self.fireworksView atIndex:0];
}
```

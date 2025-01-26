# 一个`快捷轻巧`且`功能丰富`的功能引导提示工具

[English](https://github.com/kpaxian7/feature_guider/blob/main/README.md)
[中文](https://github.com/kpaxian7/feature_guider/blob/main/README-zh.md)

## 效果预览
<img alt="Sample" height="560" src="https://raw.githubusercontent.com/kpaxian7/feature_guider/main/sample-gif.gif" width="270"/>


## 功能介绍
- 支持自定义提示说明小组件
- 支持`Widget#key` 或 `Rect`锁定提示位置
- 支持背景蒙版透明度设置
- 支持动画过渡时长设置
- 支持提示描述组件预制选项设置
- 支持提示区域内边距设置
- 支持提示区域圆角设置
- 支持提示描述组件与提示区域间距设置


## 使用方式
```dart
WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  guideManager ??= GuideManager(context, opacity: 0.7);
  guideManager!.prepare([
    GuideItem(
      description: "Click here to go back",
      toGuideKey: keyAppBarBack,
      padding: EdgeInsets.zero,
    ),
  ]);
  guideManager!.show();
});
```

---

## GuideManager

| context | BuildContext |
| --- | --- |
| opacity | 蒙版不透明度，默认值0.4 |
| duration | 提示块动画过渡时间，默认200ms，若设置zero则无动画 |

## GuideItem

| 参数                | 描述                                                                                                     |
|-------------------|--------------------------------------------------------------------------------------------------------|
| descriptionWidget | 提示描述组件                                                                                                 |
| toGuideKey        | 传入一个GlobalKey，用于定位提示区                                                                                  |
| toGuideRect       | 传入一个Rect，用于定位提示区                                                                                       |
| position          | 文本展示在提示区的方位枚举，预设 `screenCenter`、`alignTopLeft`、`alignTopRight`、`alignBottomLeft`、`alignBottomRight`、`auto` |
| padding           | 提示区域内边距                                                                                                |
| borderRadius      | 提示区域圆角                                                                                                 |
| textInterval      | 提示文案与提示区域的间距                                                                                           |

## DescriptionPosition
- `screenCenter` - 屏幕中心
- `alignTopLeft` - 提示区域顶部&左侧对齐
- `alignTopRight` - 提示区域顶部&右侧对齐
- `alignBottomLeft` - 提示区域底部&左侧对齐
- `alignBottomRight` - 提示区域底部&右侧对齐
- `auto` - 提示区在屏幕上半区域时，展示在区域下方，否则展示在上方；左右侧展示时同理
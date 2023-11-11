# 一个`快捷轻巧`且`功能丰富`的功能引导提示工具

[English](https://github.com/kpaxian7/feature_guider/blob/main/README.md)
[中文](https://github.com/kpaxian7/feature_guider/blob/main/README-zh.md)

## 效果预览
<img alt="Sample" height="560" src="https://github.com/kpaxian7/feature_guider/blob/main/sample-gif.gif" width="270"/>


## 功能介绍
- 支持`Widget#key` 或 `Rect`锁定提示位置
- 支持背景蒙版透明度设置
- 支持动画过渡时长设置
- 支持提示文本自定义样式设置
- 支持提示文本位置预制选项设置
- 支持提示文本内边距设置
- 支持提示文本圆角设置

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

| description | 提示文案                                                                                                   |
| --- |--------------------------------------------------------------------------------------------------------|
| toGuideKey | 传入一个GlobalKey，用于定位提示区                                                                                  |
| toGuideRect | 传入一个Rect，用于定位提示区                                                                                       |
| position | 文本展示在提示区的方位枚举，预设 `screenCenter`、`areaTopCenter`、`areaTopFit`、`areaBottomCenter`、`areaBottomFit`、`auto` |
| descriptionStyle | 提示文案TextStyle                                                                                          |
| padding | 提示文案区域内边距                                                                                              |
| borderRadius | 提示文案区域圆角                                                                                               |

## DescriptionPosition
- `screenCenter` - 屏幕中心
- `areaTopCenter` - 提示区域顶部居中
- `areaTopFit` - 提示区域顶部自适应（优先`AlignRight`于提示区，若尾部超出屏幕宽度，则`AlignLeft`）
- `areaBottomCenter` - 提示区域底部居中
- `areaBottomFit` - 提示区域底部自适应（优先`AlignRight`于提示区，若尾部超出屏幕宽度，则`AlignLeft`）
- `auto` - 提示区在屏幕上半区域时，展示在区域下方，否则展示在上方；且同时应用上述Fit属性
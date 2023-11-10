# A `lightweight and feature-rich` tool for functional guidance and tips

## Preview of Effects
[![sample]](https://github.com/kpaxian7/feature_guider/blob/main/device-2023-11-10-233800.mp4)


## Feature Introduction
- Supports locking the tip position with `Widget#key` or `Rect`
- Supports setting the background mask opacity
- Supports setting the duration of animation transitions
- Supports custom style settings for the tip text
- Supports preset options for the position of the tip text
- Supports setting the padding inside the tip text
- Supports setting the border radius for the tip text

## Usage

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
|Parameter|Description|
| ---- | ---- |
|context|	BuildContext|
|opacity|	Mask opacity, default value 0.4|
|duration|	Tip block animation transition time, default 200ms, if set to zero then no animation|

## GuideItem
|Parameter|	Description|
| ---- | ---- |
|description|	Tip text|
|toGuideKey|	Pass a GlobalKey for tip area location|
|toGuideRect|	Pass a Rect for tip area location|
|position|	Text display position in the tip area enum, presets include screenCenter, areaTopCenter, areaTopFit, areaBottomCenter, areaBottomFit, auto|
|descriptionStyle|	TextStyle for the tip text|
|padding|	Internal padding for the tip text area|
|borderRadius|	Border radius for the tip text area|

## DescriptionPosition
- `screenCenter` - In the center of the screen
- `areaTopCenter` - Top center of the tip area
- `areaTopFit` - Top of the tip area, adapts (AlignRight to the tip area as priority, if the end exceeds screen width, then AlignLeft)
- `areaBottomCenter` - Bottom center of the tip area
- `areaBottomFit` - Bottom of the tip area, adapts (AlignRight to the tip area as priority, if the end exceeds screen width, then AlignLeft)
- `auto` - If the tip area is in the upper half of the screen, it will display below the area, otherwise above; applies Fit attributes as described above

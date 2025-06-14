# A `lightweight and feature-rich` tool for functional guidance and tips

[English](https://github.com/kpaxian7/feature_guider/blob/main/README.md)
[中文](https://github.com/kpaxian7/feature_guider/blob/main/README-zh.md)

## Preview of Effects
<img alt="Sample" height="560" src="https://github.com/kpaxian7/feature_guider/blob/main/sample-gif.gif?raw=true" width="270"/>


## Feature Introduction
- Supports one-time display of guide items using optional `id` with SharedPreferences
- Supports custom description widget for GUIDANCE AREA
- Supports locking the tip position with `Widget#key` or `Rect`
- Supports setting the background mask opacity
- Supports setting the duration of animation transitions
- Supports preset options for the position of the description widget
- Supports setting the padding of the guidance area
- Supports setting the border radius of the guidance area
- Supports setting the interval between description and guidance area

## Usage
```dart
WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  guideManager ??= GuideManager(context, opacity: 0.7);
  await guideManager!.prepare([
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
|Parameter| Description                                                                                   |
| ---- |-----------------------------------------------------------------------------------------------|
|context| 	BuildContext                                                                                 |
|opacity| 	Mask opacity, default value is 0.4                                                           |
|duration| Tip block animation transition time, default value is 200ms, if set to zero then no animation |

## GuideItem
| Parameter         | 	Description                                                                                                                                            |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| id                | 	Unique identifier for this guide item, used to track if it's already shown                                                                                                                              |
| descriptionWidget | 	Custom description widget                                                                                                                              |
| toGuideKey        | 	Pass a GlobalKey for guidance area location                                                                                                            |
| toGuideRect       | 	Pass a Rect for guidance area location                                                                                                                 |
| position          | 	Text display position in guidance area enum, presets include `screenCenter`, `alignTopLeft`, `alignTopRight`, `alignBottomLeft`, `alignBottomRight`, `auto` |
| padding           | 	Internal padding for the guidance area                                                                                                                 |
| borderRadius      | 	Border radius for the guidance area                                                                                                                    |
| textInterval      | 	Interval between description and guidance area                                                                                                         |

## DescriptionPosition
- `screenCenter` - Center of the screen
- `alignTopLeft` - Positions the content above the target area, aligned to the left side
- `alignTopRight` - Positions the content above the target area, aligned to the right side
- `alignBottomLeft` - Positions the content below the target area, aligned to the left side
- `alignBottomRight` - Positions the content below the target area, aligned to the right side
- `auto` - Automatically determined based on the position of your component and the dimensions of the text

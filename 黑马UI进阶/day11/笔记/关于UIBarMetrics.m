/**
 UIBarMetricsDefault, // 默认值, 当前设置的图片会在竖屏、横屏下（带 prompt 或者不带 prompt）都显示这个图片
 UIBarMetricsCompact, // 只在横屏下显示当前设置的图片(并且不带prompt)
 UIBarMetricsDefaultPrompt = 101, // 只有在导航条带 prompt 的时候才会应用这个图片
 UIBarMetricsCompactPrompt, // 只有在横屏下同时导航条带 prompt 的时候才会应用这个图片
 
 UIBarMetricsLandscapePhone, // 已过时, 使用 UIBarMetricsCompact 代替
 UIBarMetricsLandscapePhonePrompt, // 已过时, 使用 UIBarMetricsCompactPrompt 代替
 
 所以一般都用 UIBarMetricsDefault, 一次设置到处都能应用
 */
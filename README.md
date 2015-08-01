# CircularProgressView
`CircularProgressView` is a customisable circular progress view written in Swift.


![CircularProgressView Preview][preview]

## Requirements
* iOS 8.x
* Xcode 6
* Swift 1.x

## Installation
Copy `CircularProgressView` into your project.

## Getting Started
1. Create an instance from `CircularProgressView` either in code or directly in storyboard.
2. Customize `CircularProgressView` for your needs (see Attributes).
3. call `setProgress(animated:)` to set the new progress with or without animation.

## Attributes
* `backgroundShapeColor`: The progress views background color. 
* `progressShapeColor`: The progress color.
* `lineWidth`: The line width of the background shape.
* `inset`: The inset of the progress shapes line width. The default value is 0 which means that the progressShape is as thick as the background shapes `lineWidth`.
* `lineCap`: Specifies the line cap for the progress shape (`butt`, `round` or `square`).

All attributes (except `lineCap`) can be edited directly in Interface Builder.

![Edit Attributes in Interface Builder][screenshot_01]

## License
`CircularProgressView` is release under an MIT License.

[preview]: Assets/CircularProgressView.gif
[screenshot_01]: Assets/Screenshot_01.png
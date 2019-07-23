# ThwackTimingGateApp
The cross-platform app for the [Thwack Timing Gate](https://thwacktiminggate.com/). Written in [Dart](https://flutter.dev/) with the [Flutter](https://www.google.com/search?q=dartlang&oq=dartlang&aqs=chrome..69i57.983j0j7&sourceid=chrome&ie=UTF-8) framework.

This app interfaces with the finish line for the Thwack Timing System. Learn about [the entire project](https://thwacktiminggate.com/) or check out [the finish line](https://github.com/P-bibs/ThwackTimingGateFinishLine) and the [web server](https://github.com/P-bibs/ThwackTimingGateServer) it uses to host results.

## Features
The Thwack Timing Gate mobile app allows the retrieval and sorting of training results, as well as configuration of the timing gate itself. Below are a few key features, which can be seen in action in [this video](https://youtu.be/TYNzY31ogd4).

### Card-Based Results
Results are neatly categorized into easily readable cards in a modern looking interface.

#### Sort Your Results
A convenient floating action button allows sorting of cards by racer, by start time, and by run duration.

<img align="center" src="https://d1qmdf3vop2l07.cloudfront.net/unique-yak.cloudvent.net/compressed/77661284735fe4923eff75ddcad546d5.png" alt="drawing" width="400"/>

### See One Racer’s Results
Feeling a little self-absorbed? Care about your results and no one elses? Just tab the button on one of your cards and everyone elses results will be swept away so you can bask in your own success.

<img align="center" src="https://d1qmdf3vop2l07.cloudfront.net/unique-yak.cloudvent.net/compressed/d38714ceea8c71c5aa5abdabea9f860d.png" alt="drawing" width="400"/>

### Settings Tab
An easily accessible settings tab allows configuration of the Thwack Timing Gate for the inevitable occasion when everything doesn’t go quite right.

<img align="center" src="https://d1qmdf3vop2l07.cloudfront.net/unique-yak.cloudvent.net/compressed/a4bdf4ebd2e937e36a43072922cbd601.png" alt="drawing" width="400"/>

### Id-to-Name Conversion Table
The start line features a keypad for racers to punch in their IDs. Use this interface to edit the table that converts these IDs to actual racer names.

<img align="center" src="https://d1qmdf3vop2l07.cloudfront.net/unique-yak.cloudvent.net/compressed/6238049e8dcd0d1469a40af11246efb1.png" alt="drawing" width="400"/>

## Development
Start by cloning the repository
```bash
git clone https://github.com/P-bibs/ThwackTimingGateApp
cd ThwackTimingGateApp
```
Then, run the development build of the app. To complete the following step, you'll need:
1. A [Flutter install](https://flutter.dev/docs/get-started/install) in your development environment
2. An [Android Studio](https://developer.android.com/studio) install
3. The Fluter and Dart plug-ins for Android Studio
2. A valid device to run the app on. This could be any one of:
  * An [Android Virtual Device](https://developer.android.com/studio/run/managing-avds) 
  * An [IOS Simulator](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/iOS_Simulator_Guide/GettingStartedwithiOSSimulator/GettingStartedwithiOSSimulator.html)
  * An Android device plugged in with USB debugging allowed
  * An IOS device plugged in with the development machine trusted

Once you've got all of these, run
```bash
flutter run
```

## Documentation

The app is broken up into a number of 'views' or pages.

### Main View (`main.dart`)

This is the primary view. To show data, swipe down to refresh. It uses a Flutter `ListView.builder` to lazily load a list of `RacerCards`. Additionally, it has a `Floating Action Button` that, when tapped, reveals a series of smaller floating action buttons that each set the global `gSortType` to a different value when tapped, allowing the user to sort the `RacerCards`

### Single-Racer View (`SingleRacerView.dart`)

This is the view that is accessed by tapping 'View Racer's Times' in the Main View. It is similar to the Main View, as it also implements a `ListView.builder`

### Settings View (`settingsView.dart`)

Accessed by tapping the settings icon in the upper right, this is the page for configuring the device and app. The switch 'Use Test Data' toggles between using dummy data (the default) and actually retrieving results from the Raspberry Pi Finish Line Server. For that functionality to work, you'll have to be connected to the Pi's hotspot and enter its IP in 'Finish Line IP'

### Conversion Table Configuration View (`tableConfigureView.dart`)

This is the tab on which the user can configure what IDs each racer should enter at the top of the course for their result to be mapped to their name. You can swipe to erase entries and press the `FloatingActionButton` to add a new one. The icons in the upper right will sort the list.
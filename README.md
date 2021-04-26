# TestObjCTeam
Test objective C team

# Objective C Setup

See the [HomeTurfPodSpecs repo](https://github.com/HomeTurf-LLC/HomeTurfPodSpecs) for project requirements and cocoapod setup instructions. The following instructions assume you have already added/updated a Podfile, run `pod install`, and opened your project with its `PROJECT_NAME.xcworkspace` file.

Note: SMS login is the only current option for Objective C projects since [Auth0 only supports Swift projects](https://community.auth0.com/t/objective-c-integration/41820/2).

### Project Configuration Summary

For convenience, the list of integration steps once the SDK has been installed is:

1. Add `HomeTurf.plist` (structure below - specific values will be provided by HomeTurf)
2. Update `Info.plist` with required values below
3. Update `AppDelegate.h` + `AppDelegate.m` for orientation locking support
4. Update build settings with "Always Embed Swift Standard Libraries" => YES
5. Add `TeamHomeTurfOrientationUtility.swift` file that implements our HomeTurfBaseOrientationUtility protocol
6. Add bridging header, if not already present or created with last step, and add `#import "AppDelegate.h"`
7. Update the ViewController that the app will launch from with a launch action
8. (RECOMMENDED) Add Push Notification and Background Mode capabilities

### Project Configuration Steps

1. Add `HomeTurf.plist`

Add a new properties file to your project called `HomeTurf.plist`, with that name and casing (and with target membership in that project). Right click the file in Xcode and select Open As -> Source Code. Enter the following (substituting the team id we provide for HOMETURF_TEAM_ID):

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>HomeTurfDomain</key>
    <string>https://app.hometurfapp.com</string>
    <key>HomeTurfTeamId</key>
    <string>HOMETURF_TEAM_ID</string>
</dict>
</plist>
```

2. Update `Info.plist`

Select your existing `Info.plist` in Xcode, Open as -> Source Code, and insert the following permissions/configuration before the last `</dict>`. Make sure to consolidate any values or skip if your project already has them.

```
    <key>NSAppleMusicUsageDescription</key>
    <string>HomeTurf would like to access your media library</string>
    <key>NSCameraUsageDescription</key>
    <string>HomeTurf would like to access your camera</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>HomeTurf would like to access your location in order to ensure compliance with local regulations</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>HomeTurf needs to access your microphone for live channel calibration and team scream.</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>HomeTurf would like to access your photo library</string>
    <key>UIBackgroundModes</key>
    <array>
      <string>audio</string>
      <string>fetch</string>
    </array>
    <key>UIRequiresFullScreen</key>
    <true/>
```


1. In this step you'll be updating the AppDelegate header and method files. First, Add the following to `AppDelegate.m`:

```
@synthesize orientationLock = _orientationLock;

- (void) setOrientationLock:(UIInterfaceOrientationMask)orientationLock {
    _orientationLock = orientationLock;
}

- (UIInterfaceOrientationMask) orientationLock {
    return _orientationLock || UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return [self orientationLock];
}
```

Next, ensure that `@interface` is only in `AppDelegate.h` (remove from `AppDelegate.m` if necessary), and then add the following property to `AppDelegate.h` within the @interface block:

```
@property (nonatomic) UIInterfaceOrientationMask orientationLock;
```

4. Go to Build Settings, ensure that your target and out of Basic/Customized/All All is selected, then search for the "Always Embed Swift Standard Libraries" flag and set to YES

5. Add a `TeamHomeTurfOrientationUtility.swift` file to your project (and target membership), which you can copy from the HomeTurfSupport directory in our demo project [here](./TestObjCTeam/HomeTurfSupport/TeamHomeTurfOrientationUtility.swift). Add an Objective-C bridging header if prompted.

6. If you don't already have an Objective-C bridging header, create a new header file in your project named `YOUR_MODULE_NAME-Bridging-Header.h`. Add `#import "AppDelegate.h"` to your bridging header.

7. Add the following import and method to the View Controller .m file where HomeTurf will be started from. This method will launch the HomeTurf app (assuming a navigation controller will be used) once connected to the button or other component that will launch the app:

```
#import <HomeTurf/HomeTurf.h>
#import <YOUR_MODULE_NAME-Swift.h> // Replace YOUR_MODULE_NAME with your module name; this will be auto-generated by your project's bridging header

...

- (IBAction)enterHomeTurf {
    HomeTurfWebViewController *webVC = [[HomeTurfWebViewController alloc] init];
    TeamHomeTurfOrientationUtility *orientationUtility = [[TeamHomeTurfOrientationUtility alloc] init];
    [webVC setOrientationUtilityWithOrientationUtility:orientationUtility];
    [[self navigationController] pushViewController:webVC animated:NO];
}
```

(Other methods such as modal presentation as possible, but using a navigation controller will provide the most immersive experience. If there is not already a navigation controller available, find the storyboard file for the view controller, select the View Controller in the scene and then Editor -> Embed In -> Navigation Controller.)

8. If not already, make sure the following are checked in Signing & Capabilities:

- Audio, Airplay and Picture in Picture
- Background fetch

### Updates

Generally updates will only require an update to the Podfile HomeTurf version and a subsequent `pod install`.

### Support

Feel free to reach out to HomeTurf if you have any issues with the above steps or need any configuration information.

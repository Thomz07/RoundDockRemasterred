#import "UIColor+colorFromHexCode.m"
#import <UIKit/UIKit.h>
#include <Cephei/HBPreferences.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface UIDevice (Private)
-(BOOL)isNotched;
-(BOOL)isAnIpad;
-(BOOL)isAnIpod;
-(BOOL)isFloatingDock;
-(BOOL)isOldDock;
@end

@implementation UIDevice (DockType)

-(BOOL)isNotched {
    
    if([self isAnIpod] || [self isAnIpad]) { 
        return NO;
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    return context.biometryType == LABiometryTypeFaceID; 
}

-(BOOL)isAnIpad {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

-(BOOL)isAnIpod {
    NSString const *model = [UIDevice.currentDevice model]; 
    
    return ([model isEqualToString:@"iPod"]);
} 

-(BOOL)isFloatingDock {
    if ([self isAnIpad]) {
        return YES;
    } else if ([self isAnIpod]) {
        return NO;
    } else if ([self isNotched]) {
        return NO;
    } else {
        return NO;
    }
}

-(BOOL)isOldDock {
    if ([self isAnIpad]) {
        return NO;
    } else if ([self isAnIpod]) {
        return YES;
    } else if ([self isNotched]) {
        return NO;
    } else {
        return YES;
    }
}

@end

@interface SBDockView : UIView
@property (nonatomic, retain) UIView *backgroundView;
@end

@interface SBHighlightView : UIView
@property (nonatomic,readonly) double highlightHeight;
@end

SBDockView *globalDockView;

HBPreferences *preferences;
BOOL enableSwitch;
double dockCornerRadius;
BOOL changeDockColor;
NSString *dockColor;

static void prefs() {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.rounddockremasteredpreferences"];
    [preferences registerDefaults:@{
        @"enableSwitch": @YES,
        @"dockCornerRadius": @20.0,
        @"changeDockColor": @NO,
        @"dockColor": @"#FFFFFF"
    }];

    [preferences registerBool:&enableSwitch default:YES forKey:@"enableSwitch"];
    [preferences registerFloat:&dockCornerRadius default:20.0 forKey:@"dockCornerRadius"];
    [preferences registerBool:&changeDockColor default:NO forKey:@"changeDockColor"];
    [preferences registerObject:&dockColor default:@"#FFFFFF" forKey:@"dockColor"];
}

static void onNotifyCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    prefs();
    if (globalDockView != nil) {
        [globalDockView layoutSubviews];
    }
}
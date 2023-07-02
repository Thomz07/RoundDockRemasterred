#import "Tweak.h"

%group XStyleDock
%hook SBDockView

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    %orig;

    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.thomz.rounddockremasteredpreferences/ReloadPrefs"), NULL, NULL, true);
        }
    }
}

-(void)layoutSubviews {
	%orig;
	if (enableSwitch){
		CGRect frame = self.backgroundView.frame;
		frame.size.height = self.bounds.size.height + 100;
		self.backgroundView.layer.cornerRadius = dockCornerRadius;
		self.backgroundView.backgroundColor = changeDockColor ? [UIColor colorFromHexCode:dockColor] : [UIColor clearColor];
		self.backgroundView.frame = frame;
	} else {
		self.backgroundView.layer.cornerRadius = 30;
		self.backgroundView.backgroundColor = [UIColor clearColor];
	}
}

%end
%end

%group OldStyleDock
%hook SBDockView

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    %orig;

    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.thomz.rounddockremasteredpreferences/ReloadPrefs"), NULL, NULL, true);
        }
    }
}

-(void)layoutSubviews {
	%orig;
	if (enableSwitch){
		CGRect frame = self.backgroundView.frame;
		frame.size.height = self.bounds.size.height + 100;
		frame.size.width = self.bounds.size.width - 20;
		frame.origin.x = 10;
		self.backgroundView.layer.cornerRadius = dockCornerRadius;
		self.backgroundView.backgroundColor = changeDockColor ? [UIColor colorFromHexCode:dockColor] : [UIColor clearColor];
		self.backgroundView.frame = frame;
	} else {
		self.backgroundView.layer.cornerRadius = 0;
		self.backgroundView.backgroundColor = [UIColor clearColor];
	}
}

%end
%end

%group DockInitializer
%hook SBDockView

-(void)setBackgroundView:(UIView *)backgroundView {
    %orig;
	globalDockView = self; 
}

%end
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), 
							NULL, 
							onNotifyCallback, 
							CFSTR("com.thomz.rounddockremasteredpreferences/ReloadPrefs"), 
							NULL, 
							CFNotificationSuspensionBehaviorDeliverImmediately);
	prefs();

	%init(DockInitializer);
	if (![UIDevice.currentDevice isOldDock]) {
		%init(XStyleDock);
	} else {
		%init(OldStyleDock);
	}
	
}
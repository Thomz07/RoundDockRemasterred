#import "Tweak.h"

%group XStyleDock
%hook SBDockView

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
	}
}

%end
%end

%group OldStyleDock
%hook SBDockView

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
#import "Tweak.h"

%group Main
%hook SBDockView

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    %orig;
	if (enableSwitch){
		dispatch_async(dispatch_get_main_queue(), ^(void){
			self.backgroundView.backgroundColor = changeDockColor ? [UIColor colorFromHexCode:dockColor] : [UIColor clearColor];
		});
	}
}

-(void)layoutSubviews {
	%orig;
	if (enableSwitch){
		// Part for both docks
		CGRect frame = self.backgroundView.frame;
		frame.size.height = self.bounds.size.height + 100;
		self.backgroundView.layer.cornerRadius = dockCornerRadius;
		self.backgroundView.backgroundColor = changeDockColor ? [UIColor colorFromHexCode:dockColor] : [UIColor clearColor];
		
		if ([UIDevice.currentDevice isOldDock]){ // Part for only old docks
			frame.size.width = self.bounds.size.width - 20;
			frame.origin.x = 10;
			SBHighlightView *view = MSHookIvar<SBHighlightView *>(self, "_highlightView");
			[view removeFromSuperview]; // This removes the ugly line at the top of the dock, not sure what is is here for 
		}
		
		self.backgroundView.frame = frame;
	} else {
		self.backgroundView.layer.cornerRadius = [UIDevice.currentDevice isOldDock] ? 0 : 30; // Default corner radius is not the same on old or new dock
		self.backgroundView.backgroundColor = [UIColor clearColor];
	}

}

%end
%end

%group NotificationInitializer
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

	%init(NotificationInitializer);
	%init(Main)
	
}
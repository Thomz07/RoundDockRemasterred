#import <Foundation/Foundation.h>
#import "ROURootListController.h"

@implementation ROURootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	

	return _specifiers;
}

@end

@implementation ThomzHeaderCell 

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)reuseIdentifier specifier:(id)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {

		NSBundle *bundle = [[NSBundle alloc]initWithPath:@"/var/jb/Library/PreferenceBundles/RoundDockRemasteredPreferences.bundle"]; // rootless
		// NSBundle *bundle = [[NSBundle alloc]initWithPath:@"/Library/PreferenceBundles/RoundDockRemasteredPreferences.bundle"]; //rootful
		UIImage *logo = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"icon@256" ofType:@"png"]];
		UIImageView *icon = [[UIImageView alloc]initWithImage:logo];
		icon.layer.masksToBounds = YES;
		icon.layer.cornerRadius = 16;
		icon.translatesAutoresizingMaskIntoConstraints = NO;

		UILabel *tweakLabel = [[UILabel alloc] init];
		[tweakLabel setTextAlignment:NSTextAlignmentCenter];
        [tweakLabel setFont:[UIFont systemFontOfSize:30 weight: UIFontWeightRegular]];
        tweakLabel.text = @"RoundDock";
        tweakLabel.translatesAutoresizingMaskIntoConstraints = NO;

		UILabel *devLabel = [[UILabel alloc] init];
		[devLabel setTextAlignment:NSTextAlignmentCenter];
        [devLabel setFont:[UIFont systemFontOfSize:15 weight: UIFontWeightRegular]];
        devLabel.text = @"By Thomz";
        devLabel.translatesAutoresizingMaskIntoConstraints = NO;
		devLabel.alpha = 0.8;

		[self.contentView addSubview:icon];
		[self.contentView addSubview:tweakLabel];
		[self.contentView addSubview:devLabel];

		// Add constraints
		[NSLayoutConstraint activateConstraints:@[
			[icon.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
			[icon.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor constant:-30],
			[icon.widthAnchor constraintEqualToConstant:100],
			[icon.heightAnchor constraintEqualToConstant:100],
			[tweakLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
			[tweakLabel.topAnchor constraintEqualToAnchor:icon.bottomAnchor constant:10],
			[devLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
			[devLabel.topAnchor constraintEqualToAnchor:tweakLabel.bottomAnchor]
		]];

    }
    	return self;

}

- (instancetype)initWithSpecifier:(PSSpecifier *)specifier {
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CenamoHeaderCell" specifier:specifier];
}

- (void)setFrame:(CGRect)frame {
	frame.origin.x = 0;
	[super setFrame:frame];
}

@end

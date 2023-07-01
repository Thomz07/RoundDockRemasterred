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

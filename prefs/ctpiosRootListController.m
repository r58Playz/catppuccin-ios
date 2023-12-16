#import <Foundation/Foundation.h>
#import "ctpiosRootListController.h"

@implementation ctpiosRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end

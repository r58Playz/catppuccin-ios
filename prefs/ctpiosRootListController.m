#import <Foundation/Foundation.h>
#import "ctpiosRootListController.h"

#import <FrontBoardServices/FBSSystemService.h>
#import <SpringBoardServices/SBSRelaunchAction.h>
#import <objc/runtime.h>

@implementation ctpiosRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (instancetype)init {
    self = [super init];

    if (!self) return self;

    UIButton *respringButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [respringButton setTitle:@"Respring" forState:UIControlStateNormal];
    [respringButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [respringButton addTarget:self action:@selector(respring:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:respringButton];

    return self;
}

- (void)respring {
    Class FBSSystemService = objc_getClass("FBSSystemService");
    Class SBSRelaunchAction = objc_getClass("SBSRelaunchAction");

    NSURL *relaunchURL = [NSURL URLWithString:@"prefs:root=Catppuccin"];
    id restartAction = [SBSRelaunchAction actionWithReason:@"RestartRenderServer" options:4 targetURL:relaunchURL];
    [[FBSSystemService sharedService] sendActions:[NSSet setWithObject:restartAction] withResult:nil];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
     [super setPreferenceValue:value specifier:specifier];
     [[[NSUserDefaults alloc] initWithSuiteName:@"com.catppuccin.ios.preferences"] synchronize];
     [self respring];
}
@end

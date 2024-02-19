// vim:ft=objcpp
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <Foundation/NSUserDefaults+Private.h>
#import <UIKit/UIColor.h>
#import <rootless.h>
#import <substrate.h>

static NSArray *colors;
static UIColor *accent;
static UIColor *highlight;

static NSString *pref_flavor;
static NSString *pref_accent;

static NSMutableArray *enabledIntegrations;
static NSMutableArray *enabledTweaks;

static NSArray *applicationBlacklist;

static NSString *PROCESS_NAME;

#include "utils.h"
#include "colors.h"

#import "headers/UISUserInterfaceStyleMode.h"

//__CTPIOS_PREPROCESSOR_SED_HERE

static void setDarkMode(unsigned long long modeValue) {
    if ([PROCESS_NAME isEqualToString:@"Preferences"]) {
        UISUserInterfaceStyleMode *darkMode = [[%c(UISUserInterfaceStyleMode) alloc] init];
        [darkMode setModeValue:modeValue];
        darkMode.modeValue = modeValue;
        NSLog(@"ctpios: set modeValue to %llu", darkMode.modeValue);
    }
}

static void loadPreferences() {
    // https://iphonedev.wiki/PreferenceBundles
    BOOL isSystem = [NSHomeDirectory() isEqualToString:@"/var/mobile"];
    NSDictionary* prefs = nil;
    if(isSystem) {
        CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.catppuccin.ios.prefs"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
        if(keyList) {
            prefs = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, CFSTR("com.catppuccin.ios.prefs"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
            if(!prefs) prefs = [NSDictionary new];
            CFRelease(keyList);
        }
    }
    if (!prefs) {
           prefs = [NSDictionary dictionaryWithContentsOfFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/com.catppuccin.ios.prefs.plist")];
    }
	if (prefs) {
        pref_flavor = [prefs objectForKey:@"flavor"];
        pref_accent = [prefs objectForKey:@"accent"];
        colors = colorsFromHexStrings(flavorFromString(pref_flavor));
        accent = colors[accentFromString(pref_accent)];
        highlight = colorFromHexStringWithAlpha(flavorFromString(pref_flavor)[accentFromString(pref_accent)], 0.3);
        NSLog(@"ctpios: reloaded colors flavor %@ accent %@", pref_flavor, pref_accent);

        if ([prefs objectForKey:@"tweak_blue_is_accent"]) {
            [enabledTweaks addObject:@"blue_is_accent"];
        }

        if ([prefs objectForKey:@"integration_youtube"]) {
            [enabledIntegrations addObject:@"youtube"];
        }

        if ([prefs objectForKey:@"integration_github"]) {
            [enabledIntegrations addObject:@"github"];
        }

        NSLog(@"ctpios: enabledTweaks %@", enabledTweaks);
        NSLog(@"ctpios: enabledIntegrations %@", enabledIntegrations);
    }
    if ([PROCESS_NAME isEqualToString:@"Preferences"]) {
        if ([pref_flavor isEqualToString:@"latte"]) {
            setDarkMode(1);
        } else {
            setDarkMode(2);
        }
    }
}


%ctor {
    PROCESS_NAME = [[NSProcessInfo processInfo] processName];
    enabledTweaks = [NSMutableArray array];
    enabledIntegrations = [NSMutableArray array];

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.catppuccin.ios.prefs/reload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPreferences();

    NSLog(@"ctpios: process name %@", PROCESS_NAME);
    NSLog(@"ctpios: initializing uikit hooks");
    initUIKitHook();

    if ([enabledIntegrations containsObject:@"youtube"]) {
        NSLog(@"ctpios: initializing youtube hooks");
        %init(integration_youtube);
    }

    if ([enabledIntegrations containsObject:@"github"] && [PROCESS_NAME isEqualToString:@"GitHub"]) {
        NSLog(@"ctpios: initializing github hooks");
        initGitHubHook();
    }
}

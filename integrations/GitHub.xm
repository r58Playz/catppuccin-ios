// vim:ft=objcpp

#import <UIKit/UIImageView.h> 

static NSDictionary *GitHubColorTable;

%group integration_github

%hook UIColor
+ (UIColor *)colorNamed:(NSString *)name inBundle:(NSBundle *)bundle compatibleWithTraitCollection:(UITraitCollection *)traitCollection {
    if([GitHubColorTable objectForKey:name]) {
        int idx = [GitHubColorTable[name] intValue];
        NSLog(@"ctpios github: replaced %@ with %d", name, idx);
        return getColor(idx);
    }
    UIColor *orig = %orig;
    NSLog(@"ctpios github: %@ not found, returning %@", name, [[CIColor colorWithCGColor:[orig CGColor]] stringRepresentation]);
    return orig;
}
%end

%hook UIImageView
// scuffed but i don't know how to properly hook swiftui
-(void)tintColorDidChange {
    UIColor* col = getColor(ADAPTIVE_DARK);
    if ((
        [NSStringFromClass([self.superview.superview.superview class]) isEqualToString:@"GitHub.HomeWorkCell"] ||
        [NSStringFromClass([self.superview class]) isEqualToString:@"GitHubUI.AvatarPairView"] ||
        [NSStringFromClass([self.superview.superview class]) isEqualToString:@"GitHub.IssueMergedCell"] ||
        [NSStringFromClass([self.superview.superview class]) isEqualToString:@"GitHub.IssueReviewHeaderCell"]
        ) && ![self.tintColor isEqual:col]) {
        self.tintColor = col;
    }
}
%end

%end

static void initGitHubHook() {
    GitHubColorTable = @{
        @"appBackground": @MANTLE,
        @"backgroundPrimary": @MANTLE,
        @"backgroundElevatedPrimary": @BASE,
        @"backgroundSecondary": @BASE,
        @"backgroundElevatedSecondary": @SURFACE0,
        @"backgroundTertiary": @SURFACE0,
        @"backgroundElevatedTertiary": @SURFACE1,

        @"link": @ACCENT,

        @"gray-000": @TEXT,
        @"gray-700": @SURFACE2,
        @"gray-800": @SURFACE2,
        @"gray-950": @MANTLE,

        @"textPrimary": @TEXT,
        @"textSecondary": @SUBTEXT0,
        @"textTertiary": @SUBTEXT0,
        @"textPlaceholder": @OVERLAY0,

        @"iconPrimary": @TEXT,
        @"iconSecondary": @SUBTEXT0,
        @"iconTertiary": @SUBTEXT0,

        @"badge-blue-background": @BLUE,
        @"badge-blue-stroke": @BLUE,
        @"badge-blue-label": @ADAPTIVE_DARK,
        @"badge-green-background": @GREEN,
        @"badge-green-stroke": @GREEN,
        @"badge-green-label": @ADAPTIVE_DARK,
        @"badge-purple-background": @MAUVE,
        @"badge-purple-stroke": @MAUVE,
        @"badge-purple-label": @ADAPTIVE_DARK,
        @"badge-orange-background": @PEACH,
        @"badge-orange-stroke": @PEACH,
        @"badge-orange-label": @ADAPTIVE_DARK,
        @"badge-red-background": @RED,
        @"badge-red-stroke": @RED,
        @"badge-red-label": @ADAPTIVE_DARK,
        @"badge-yellow-background": @YELLOW,
        @"badge-yellow-stroke": @YELLOW,
        @"badge-yellow-label": @ADAPTIVE_DARK,
        @"badge-gray-background": @SURFACE2,
        @"badge-gray-stroke": @SURFACE2,
        @"badge-gray-label": @TEXT,

        @"red-600": @RED,

        @"green-400": @GREEN,
        @"green-500": @GREEN,
        @"green-600": @GREEN,
        @"green-700": @GREEN,

        @"blue-400": @BLUE,

        @"purple-400": @MAUVE,
        @"purple-500": @MAUVE,

        @"orange-400": @PEACH,
        @"orange-500": @PEACH,

        @"yellow-500": @YELLOW,
        @"yellow-600": @YELLOW,
        @"yellow-900": @YELLOW,

        @"diffLineAdditionBackground": @BASE_25_GREEN,
        @"diffLineNumberAdditionBackground": @GREEN,
        @"diffLineNumberAdditionText": @ADAPTIVE_DARK,
        @"diffLineDeletionBackground": @BASE_25_RED,
        @"diffLineNumberDeletionBackground": @RED,
        @"diffLineNumberDeletionText": @ADAPTIVE_DARK,
    };
    %init(integration_github);
}

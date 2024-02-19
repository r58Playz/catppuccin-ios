// vim:ft=objcpp
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

%end

static void initGitHubHook() {
    GitHubColorTable = @{
        @"appBackground": @BASE,
        @"backgroundPrimary": @BASE,
        @"backgroundElevatedPrimary": @SURFACE0,
        @"backgroundSecondary": @SURFACE0,
        @"backgroundElevatedSecondary": @SURFACE1,
        @"backgroundTertiary": @SURFACE1,
        @"backgroundElevatedTertiary": @SURFACE2,

        @"link": @ACCENT,

        @"gray-000": @TEXT,

        @"textPrimary": @TEXT,
        @"textSecondary": @SUBTEXT0,
        @"textTertiary": @SUBTEXT0,
        @"textPlaceholder": @OVERLAY0,

        @"iconPrimary": @TEXT,
        @"iconSecondary": @SUBTEXT0,
        @"iconTertiary": @SUBTEXT0,

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

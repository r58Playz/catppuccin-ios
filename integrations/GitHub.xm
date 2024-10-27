// vim:ft=objcpp

#import <UIKit/UIImageView.h> 

static NSMutableDictionary *GitHubColorTable;

typedef struct {
    int c1;
    int c2;
    float blendAmt;
} GitHubColor;

NSData *GitHubMakeColoru(int c1) {
    GitHubColor color = GitHubColor { .c1 = c1, .c2 = c1, .blendAmt = 1.0f };
    return [NSData dataWithBytes:&color length:sizeof(color)];
}

NSData *GitHubMakeColorb(int c1, int c2, float blendAmt) {
    GitHubColor color = GitHubColor { .c1 = c1, .c2 = c2, .blendAmt = blendAmt };
    return [NSData dataWithBytes:&color length:sizeof(color)];
}

%group integration_github

%hook UIColor
+ (UIColor *)colorNamed:(NSString *)name inBundle:(NSBundle *)bundle compatibleWithTraitCollection:(UITraitCollection *)traitCollection {
    if([GitHubColorTable objectForKey:name]) {
        GitHubColor color;
        [GitHubColorTable[name] getBytes:&color length:sizeof(color)];
        if (color.c1 == color.c2) {
            NSLog(@"ctpios github: replaced %@ with %d", name, color.c1);
            return getColor(color.c1);
        } else {
            NSLog(@"ctpios github: replaced %@ with %d blended with %d (%f)", name, color.c1, color.c2, color.blendAmt);
            return blend(getColor(color.c1), getColor(color.c2), color.blendAmt);
        }
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
    NSLog(@"%@", self.backgroundColor);
    if ((
        [NSStringFromClass([self.superview.superview.superview class]) isEqualToString:@"GitHub.HomeWorkCell"] ||
        [NSStringFromClass([self.superview class]) isEqualToString:@"GitHubUI.AvatarPairView"] ||
        [NSStringFromClass([self.superview.superview class]) isEqualToString:@"GitHub.IssueMergedCell"] ||
        [NSStringFromClass([self.superview.superview class]) isEqualToString:@"GitHub.IssueStatusEventCell"] ||
        [NSStringFromClass([self.superview.superview class]) isEqualToString:@"GitHub.IssueReviewHeaderCell"] ||
        [NSStringFromClass([self.superview.superview.superview.superview.superview class]) isEqualToString:@"GitHub.ProfileDetailTableViewCell"] ||
        [NSStringFromClass([self.superview class]) isEqualToString:@"UISwipeActionStandardButton"]
        ) && ![self.tintColor isEqual:col]) {
        self.tintColor = col;
    }
}
%end

%end

static void initGitHubHook() {
    GitHubColorTable = [@{
        @"appBackground": GitHubMakeColoru(MANTLE),
        @"backgroundPrimary": GitHubMakeColoru(MANTLE),
        @"backgroundElevatedPrimary": GitHubMakeColoru(BASE),
        @"backgroundSecondary": GitHubMakeColoru(BASE),
        @"backgroundElevatedSecondary": GitHubMakeColoru(SURFACE0),
        @"backgroundTertiary": GitHubMakeColoru(SURFACE0),
        @"backgroundElevatedTertiary": GitHubMakeColoru(SURFACE1),

        @"link": GitHubMakeColoru(ACCENT),

        @"gray-000": GitHubMakeColoru(TEXT),
        @"gray-050": GitHubMakeColoru(TEXT),
        @"gray-100": GitHubMakeColoru(SUBTEXT1),
        @"gray-150": GitHubMakeColoru(SUBTEXT1),
        @"gray-200": GitHubMakeColoru(SUBTEXT0),
        @"gray-250": GitHubMakeColoru(SUBTEXT0),
        @"gray-300": GitHubMakeColoru(OVERLAY2),
        @"gray-350": GitHubMakeColoru(OVERLAY2),
        @"gray-400": GitHubMakeColoru(OVERLAY1),
        @"gray-450": GitHubMakeColoru(OVERLAY1),
        @"gray-500": GitHubMakeColoru(OVERLAY0),
        @"gray-550": GitHubMakeColoru(OVERLAY0),
        @"gray-600": GitHubMakeColoru(SURFACE2),
        @"gray-650": GitHubMakeColoru(SURFACE2),
        @"gray-700": GitHubMakeColoru(SURFACE1),
        @"gray-750": GitHubMakeColoru(SURFACE1),
        @"gray-800": GitHubMakeColoru(SURFACE0),
        @"gray-850": GitHubMakeColoru(SURFACE0),
        @"gray-900": GitHubMakeColoru(BASE),
        @"gray-950": GitHubMakeColoru(MANTLE),
        @"gray-1000":GitHubMakeColoru(CRUST),

        @"textPrimary": GitHubMakeColoru(TEXT),
        @"textSecondary": GitHubMakeColoru(SUBTEXT0),
        @"textTertiary": GitHubMakeColoru(SUBTEXT0),
        @"textPlaceholder": GitHubMakeColoru(OVERLAY0),

        @"iconPrimary": GitHubMakeColoru(TEXT),
        @"iconSecondary": GitHubMakeColoru(SUBTEXT0),
        @"iconTertiary": GitHubMakeColoru(SUBTEXT0),

        @"badge-blue-background": GitHubMakeColoru(BLUE),
        @"badge-blue-stroke": GitHubMakeColoru(BLUE),
        @"badge-blue-label": GitHubMakeColoru(ADAPTIVE_DARK),
        @"badge-green-background": GitHubMakeColoru(GREEN),
        @"badge-green-stroke": GitHubMakeColoru(GREEN),
        @"badge-green-label": GitHubMakeColoru(ADAPTIVE_DARK),
        @"badge-purple-background": GitHubMakeColoru(MAUVE),
        @"badge-purple-stroke": GitHubMakeColoru(MAUVE),
        @"badge-purple-label": GitHubMakeColoru(ADAPTIVE_DARK),
        @"badge-orange-background": GitHubMakeColoru(PEACH),
        @"badge-orange-stroke": GitHubMakeColoru(PEACH),
        @"badge-orange-label": GitHubMakeColoru(ADAPTIVE_DARK),
        @"badge-red-background": GitHubMakeColoru(RED),
        @"badge-red-stroke": GitHubMakeColoru(RED),
        @"badge-red-label": GitHubMakeColoru(ADAPTIVE_DARK),
        @"badge-yellow-background": GitHubMakeColoru(YELLOW),
        @"badge-yellow-stroke": GitHubMakeColoru(YELLOW),
        @"badge-yellow-label": GitHubMakeColoru(ADAPTIVE_DARK),
        @"badge-gray-background": GitHubMakeColoru(SURFACE2),
        @"badge-gray-stroke": GitHubMakeColoru(SURFACE2),
        @"badge-gray-label": GitHubMakeColoru(TEXT),

        @"red-000": GitHubMakeColorb(TEXT, RED, 0.1f),
        @"red-100": GitHubMakeColorb(TEXT, RED, 0.2f),
        @"red-200": GitHubMakeColorb(TEXT, RED, 0.3f),
        @"red-300": GitHubMakeColorb(TEXT, RED, 0.4f),
        @"red-400": GitHubMakeColorb(TEXT, RED, 0.5f),
        @"red-500": GitHubMakeColorb(TEXT, RED, 0.6f),
        @"red-600": GitHubMakeColorb(TEXT, RED, 0.7f),
        @"red-700": GitHubMakeColorb(TEXT, RED, 0.8f),
        @"red-800": GitHubMakeColorb(TEXT, RED, 0.9f),
        @"red-900": GitHubMakeColorb(TEXT, RED, 1.0f),

        @"yellow-000": GitHubMakeColorb(TEXT, YELLOW, 0.1f),
        @"yellow-100": GitHubMakeColorb(TEXT, YELLOW, 0.2f),
        @"yellow-200": GitHubMakeColorb(TEXT, YELLOW, 0.3f),
        @"yellow-300": GitHubMakeColorb(TEXT, YELLOW, 0.4f),
        @"yellow-400": GitHubMakeColorb(TEXT, YELLOW, 0.5f),
        @"yellow-500": GitHubMakeColorb(TEXT, YELLOW, 0.6f),
        @"yellow-600": GitHubMakeColorb(TEXT, YELLOW, 0.7f),
        @"yellow-700": GitHubMakeColorb(TEXT, YELLOW, 0.8f),
        @"yellow-800": GitHubMakeColorb(TEXT, YELLOW, 0.9f),
        @"yellow-900": GitHubMakeColorb(TEXT, YELLOW, 1.0f),

        @"orange-000": GitHubMakeColorb(TEXT, PEACH, 0.1f),
        @"orange-100": GitHubMakeColorb(TEXT, PEACH, 0.2f),
        @"orange-200": GitHubMakeColorb(TEXT, PEACH, 0.3f),
        @"orange-300": GitHubMakeColorb(TEXT, PEACH, 0.4f),
        @"orange-400": GitHubMakeColorb(TEXT, PEACH, 0.5f),
        @"orange-500": GitHubMakeColorb(TEXT, PEACH, 0.6f),
        @"orange-600": GitHubMakeColorb(TEXT, PEACH, 0.7f),
        @"orange-700": GitHubMakeColorb(TEXT, PEACH, 0.8f),
        @"orange-800": GitHubMakeColorb(TEXT, PEACH, 0.9f),
        @"orange-900": GitHubMakeColorb(TEXT, PEACH, 1.0f),

        @"blue-000": GitHubMakeColorb(TEXT, BLUE, 0.1f),
        @"blue-100": GitHubMakeColorb(TEXT, BLUE, 0.2f),
        @"blue-200": GitHubMakeColorb(TEXT, BLUE, 0.3f),
        @"blue-300": GitHubMakeColorb(TEXT, BLUE, 0.4f),
        @"blue-400": GitHubMakeColorb(TEXT, BLUE, 0.5f),
        @"blue-500": GitHubMakeColorb(TEXT, BLUE, 0.6f),
        @"blue-600": GitHubMakeColorb(TEXT, BLUE, 0.7f),
        @"blue-700": GitHubMakeColorb(TEXT, BLUE, 0.8f),
        @"blue-800": GitHubMakeColorb(TEXT, BLUE, 0.9f),
        @"blue-900": GitHubMakeColorb(TEXT, BLUE, 1.0f),

        @"purple-000": GitHubMakeColorb(TEXT, MAUVE, 0.1f),
        @"purple-100": GitHubMakeColorb(TEXT, MAUVE, 0.2f),
        @"purple-200": GitHubMakeColorb(TEXT, MAUVE, 0.3f),
        @"purple-300": GitHubMakeColorb(TEXT, MAUVE, 0.4f),
        @"purple-400": GitHubMakeColorb(TEXT, MAUVE, 0.5f),
        @"purple-500": GitHubMakeColorb(TEXT, MAUVE, 0.6f),
        @"purple-600": GitHubMakeColorb(TEXT, MAUVE, 0.7f),
        @"purple-700": GitHubMakeColorb(TEXT, MAUVE, 0.8f),
        @"purple-800": GitHubMakeColorb(TEXT, MAUVE, 0.9f),
        @"purple-900": GitHubMakeColorb(TEXT, MAUVE, 1.0f),

        @"diffLineAdditionBackground": GitHubMakeColoru(BASE_25_GREEN),
        @"diffLineNumberAdditionBackground": GitHubMakeColoru(GREEN),
        @"diffLineNumberAdditionText": GitHubMakeColoru(ADAPTIVE_DARK),
        @"diffLineDeletionBackground": GitHubMakeColoru(BASE_25_RED),
        @"diffLineNumberDeletionBackground": GitHubMakeColoru(RED),
        @"diffLineNumberDeletionText": GitHubMakeColoru(ADAPTIVE_DARK),
    } mutableCopy];
    if ([PROCESS_NAME isEqualToString:@"ContributionGraphWidget"]) {
        NSDictionary *dict = @{
            @"green-000": GitHubMakeColorb(BASE, ACCENT, 0.1f),
            @"green-100": GitHubMakeColorb(BASE, ACCENT, 0.2f),
            @"green-200": GitHubMakeColorb(BASE, ACCENT, 0.3f),
            @"green-300": GitHubMakeColorb(BASE, ACCENT, 0.4f),
            @"green-400": GitHubMakeColorb(BASE, ACCENT, 0.5f),
            @"green-500": GitHubMakeColorb(BASE, ACCENT, 0.6f),
            @"green-600": GitHubMakeColorb(BASE, ACCENT, 0.7f),
            @"green-700": GitHubMakeColorb(BASE, ACCENT, 0.8f),
            @"green-800": GitHubMakeColorb(BASE, ACCENT, 0.9f),
            @"green-900": GitHubMakeColorb(BASE, ACCENT, 1.0f),
        };
        [GitHubColorTable addEntriesFromDictionary:dict];
    } else {
        NSDictionary *dict = @{
            @"green-000": GitHubMakeColorb(TEXT, GREEN, 0.1f),
            @"green-100": GitHubMakeColorb(TEXT, GREEN, 0.2f),
            @"green-200": GitHubMakeColorb(TEXT, GREEN, 0.3f),
            @"green-300": GitHubMakeColorb(TEXT, GREEN, 0.4f),
            @"green-400": GitHubMakeColorb(TEXT, GREEN, 0.5f),
            @"green-500": GitHubMakeColorb(TEXT, GREEN, 0.6f),
            @"green-600": GitHubMakeColorb(TEXT, GREEN, 0.7f),
            @"green-700": GitHubMakeColorb(TEXT, GREEN, 0.8f),
            @"green-800": GitHubMakeColorb(TEXT, GREEN, 0.9f),
            @"green-900": GitHubMakeColorb(TEXT, GREEN, 1.0f),
        };
        [GitHubColorTable addEntriesFromDictionary:dict];
    }
    %init(integration_github);
}

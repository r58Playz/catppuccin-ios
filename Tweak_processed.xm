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

static NSArray *applicationBlacklist;

static NSString *PROCESS_NAME = [[NSProcessInfo processInfo] processName];

#include "utils.h"
#include "colors.h"

#import "headers/UISUserInterfaceStyleMode.h"

// vim:ft=objcpp

#import <UIKit/UILabel.h>
#import <UIKit/UITabBar.h>

static NSDictionary *UIKitColorTable;
static NSArray *UIKitColorBlacklist;

static UIColor *getColorFromUIKitTable(NSString *name) {
    if([UIKitColorBlacklist containsObject:name]) return nil;
    if([UIKitColorTable objectForKey:name]) {
        int idx = [UIKitColorTable[name] intValue];
        // NSLog(@"ctpios uikit: replaced %@ with %d", name, idx);
        return getColor(idx);
    }
    NSLog(@"ctpios uikit: %@ not found", name);
    return nil;
}

static UIColor *getColorFromUIKitTableD(NSString *name, UIColor *orig) {
    UIColor *color = getColorFromUIKitTable(name);
    return color == nil ? orig : color;
}

%group uikithooks

%hook UIDynamicSystemColor

- (id)initWithName:(NSString *)name colorsByThemeKey:(NSDictionary *)systemColorTable {
    UIColor *color = getColorFromUIKitTable(name);
    if(color != nil) {
        NSMutableDictionary *newColors = [systemColorTable mutableCopy];
        [newColors setObject:color forKey:@0];
        [newColors setObject:color forKey:@2];
        return %orig(name, newColors);
    }

    return %orig;
}

%end

%hook UIColor
+(id)separatorColor { return getColorFromUIKitTableD(@"separatorColor", %orig); }
+(id)insertionPointColor { return getColorFromUIKitTableD(@"insertionPointColor", %orig); }
+(id)selectionHighlightColor { return getColorFromUIKitTableD(@"selectionHighlightColor", %orig); }
+(id)_tintColor { return getColorFromUIKitTableD(@"_tintColor", %orig); }
+(id)tintColor { return getColorFromUIKitTableD(@"tintColor", %orig); }
+(id)darkGrayColor { return getColorFromUIKitTableD(@"darkGrayColor", %orig); }
+(id)magentaColor { return getColorFromUIKitTableD(@"magentaColor", %orig); }
+(id)lightTextColor { return getColorFromUIKitTableD(@"lightTextColor", %orig); }
+(id)redColor { return getColorFromUIKitTableD(@"redColor", %orig); }
+(id)clearColor { return getColorFromUIKitTableD(@"clearColor", %orig); }
+(id)grayColor { return getColorFromUIKitTableD(@"grayColor", %orig); }
+(id)orangeColor { return getColorFromUIKitTableD(@"orangeColor", %orig); }
+(id)tableBackgroundColor { return getColorFromUIKitTableD(@"tableBackgroundColor", %orig); }
+(id)lightGrayColor { return getColorFromUIKitTableD(@"lightGrayColor", %orig); }
+(id)brownColor { return getColorFromUIKitTableD(@"brownColor", %orig); }
+(id)purpleColor { return getColorFromUIKitTableD(@"purpleColor", %orig); }
+(id)whiteColor { return getColorFromUIKitTableD(@"whiteColor", %orig); }
+(id)tableSeparatorColor { return getColorFromUIKitTableD(@"tableSeparatorColor", %orig); }
+(id)yellowColor { return getColorFromUIKitTableD(@"yellowColor", %orig); }
+(id)cyanColor { return getColorFromUIKitTableD(@"cyanColor", %orig); }
+(id)greenColor { return getColorFromUIKitTableD(@"greenColor", %orig); }
+(id)blackColor { return getColorFromUIKitTableD(@"blackColor", %orig); }
+(id)placeholderTextColor { return getColorFromUIKitTableD(@"placeholderTextColor", %orig); }
+(id)blueColor { return getColorFromUIKitTableD(@"blueColor", %orig); }
+(id)_secondarySystemBackgroundColor { return getColorFromUIKitTableD(@"_secondarySystemBackgroundColor", %orig); }
+(id)_separatorColor { return getColorFromUIKitTableD(@"_separatorColor", %orig); }
+(id)_switchOffColor { return getColorFromUIKitTableD(@"_switchOffColor", %orig); }
+(id)_systemGroupBackgroundCellColor { return getColorFromUIKitTableD(@"_systemGroupBackgroundCellColor", %orig); }
+(id)_vibrantLightFillDarkeningColor { return getColorFromUIKitTableD(@"_vibrantLightFillDarkeningColor", %orig); }
+(id)systemDarkLightMidGrayTintColor { return getColorFromUIKitTableD(@"systemDarkLightMidGrayTintColor", %orig); }
+(id)systemMintColor { return getColorFromUIKitTableD(@"systemMintColor", %orig); }
+(id)tableCellFocusedBackgroundColor { return getColorFromUIKitTableD(@"tableCellFocusedBackgroundColor", %orig); }
+(id)tableCellbackgroundColorCarPlay { return getColorFromUIKitTableD(@"tableCellbackgroundColorCarPlay", %orig); }
+(id)systemBlueColor { return getColorFromUIKitTableD(@"systemBlueColor", %orig); }
+(id)systemCyanColor { return getColorFromUIKitTableD(@"systemCyanColor", %orig); }
+(id)systemFillColor { return getColorFromUIKitTableD(@"systemFillColor", %orig); }
+(id)systemGrayColor { return getColorFromUIKitTableD(@"systemGrayColor", %orig); }
+(id)systemPinkColor { return getColorFromUIKitTableD(@"systemPinkColor", %orig); }
+(id)systemTealColor { return getColorFromUIKitTableD(@"systemTealColor", %orig); }
+(id)tableCellGroupedBackgroundColor { return getColorFromUIKitTableD(@"tableCellGroupedBackgroundColor", %orig); }
+(id)tableGroupedSeparatorLightColor { return getColorFromUIKitTableD(@"tableGroupedSeparatorLightColor", %orig); }
+(id)__halfTransparentBlackColor { return getColorFromUIKitTableD(@"__halfTransparentBlackColor", %orig); }
+(id)__halfTransparentWhiteColor { return getColorFromUIKitTableD(@"__halfTransparentWhiteColor", %orig); }
+(id)__tintColor { return getColorFromUIKitTableD(@"__tintColor", %orig); }
+(id)_accessibilityButtonShapesBackgroundColorOnDark { return getColorFromUIKitTableD(@"_accessibilityButtonShapesBackgroundColorOnDark", %orig); }
+(id)_accessibilityButtonShapesBackgroundColorOnLight { return getColorFromUIKitTableD(@"_accessibilityButtonShapesBackgroundColorOnLight", %orig); }
+(id)_accessibilityButtonShapesDisabledBackgroundColorOnDark { return getColorFromUIKitTableD(@"_accessibilityButtonShapesDisabledBackgroundColorOnDark", %orig); }
+(id)_accessibilityButtonShapesNoBlendModeBackgroundColorOnDark { return getColorFromUIKitTableD(@"_accessibilityButtonShapesNoBlendModeBackgroundColorOnDark", %orig); }
+(id)_accessibilityButtonShapesNoBlendModeBackgroundColorOnLight { return getColorFromUIKitTableD(@"_accessibilityButtonShapesNoBlendModeBackgroundColorOnLight", %orig); }
+(id)_alertControllerDimmingViewColor { return getColorFromUIKitTableD(@"_alertControllerDimmingViewColor", %orig); }
+(id)_alternateSystemInteractionTintColor { return getColorFromUIKitTableD(@"_alternateSystemInteractionTintColor", %orig); }
+(id)_appKeyColor { return getColorFromUIKitTableD(@"_appKeyColor", %orig); }
+(id)_appKeyColorOrDefaultTint { return getColorFromUIKitTableD(@"_appKeyColorOrDefaultTint", %orig); }
+(id)_barHairlineShadowColor { return getColorFromUIKitTableD(@"_barHairlineShadowColor", %orig); }
+(id)_barStyleBlackHairlineShadowColor { return getColorFromUIKitTableD(@"_barStyleBlackHairlineShadowColor", %orig); }
+(id)_carSystemFocusColor { return getColorFromUIKitTableD(@"_carSystemFocusColor", %orig); }
+(id)_carSystemFocusLabelColor { return getColorFromUIKitTableD(@"_carSystemFocusLabelColor", %orig); }
+(id)_carSystemFocusPrimaryColor { return getColorFromUIKitTableD(@"_carSystemFocusPrimaryColor", %orig); }
+(id)_carSystemFocusSecondaryColor { return getColorFromUIKitTableD(@"_carSystemFocusSecondaryColor", %orig); }
+(id)_carSystemPrimaryColor { return getColorFromUIKitTableD(@"_carSystemPrimaryColor", %orig); }
+(id)_carSystemQuaternaryColor { return getColorFromUIKitTableD(@"_carSystemQuaternaryColor", %orig); }
+(id)_carSystemSecondaryColor { return getColorFromUIKitTableD(@"_carSystemSecondaryColor", %orig); }
+(id)_carSystemTertiaryColor { return getColorFromUIKitTableD(@"_carSystemTertiaryColor", %orig); }
+(id)_contentBackgroundColor { return getColorFromUIKitTableD(@"_contentBackgroundColor", %orig); }
+(id)_controlForegroundColor { return getColorFromUIKitTableD(@"_controlForegroundColor", %orig); }
+(id)_controlHighlightColor { return getColorFromUIKitTableD(@"_controlHighlightColor", %orig); }
+(id)_controlShadowColor { return getColorFromUIKitTableD(@"_controlShadowColor", %orig); }
+(id)_controlVibrantBottomBackgroundColor { return getColorFromUIKitTableD(@"_controlVibrantBottomBackgroundColor", %orig); }
+(id)_controlVibrantTopBackgroundColor { return getColorFromUIKitTableD(@"_controlVibrantTopBackgroundColor", %orig); }
+(id)_dimmingViewColor { return getColorFromUIKitTableD(@"_dimmingViewColor", %orig); }
+(id)_dynamicTestColor { return getColorFromUIKitTableD(@"_dynamicTestColor", %orig); }
+(id)_externalBarBackgroundColor { return getColorFromUIKitTableD(@"_externalBarBackgroundColor", %orig); }
+(id)_externalSystemDarkGrayColor { return getColorFromUIKitTableD(@"_externalSystemDarkGrayColor", %orig); }
+(id)_externalSystemExtraDarkGrayColor { return getColorFromUIKitTableD(@"_externalSystemExtraDarkGrayColor", %orig); }
+(id)_externalSystemGrayColor { return getColorFromUIKitTableD(@"_externalSystemGrayColor", %orig); }
+(id)_externalSystemMidGrayColor { return getColorFromUIKitTableD(@"_externalSystemMidGrayColor", %orig); }
+(id)_externalSystemSuperDarkGrayColor { return getColorFromUIKitTableD(@"_externalSystemSuperDarkGrayColor", %orig); }
+(id)_externalSystemWhiteColor { return getColorFromUIKitTableD(@"_externalSystemWhiteColor", %orig); }
+(id)_fillColor { return getColorFromUIKitTableD(@"_fillColor", %orig); }
+(id)_groupTableHeaderFooterTextColor { return getColorFromUIKitTableD(@"_groupTableHeaderFooterTextColor", %orig); }
+(id)_labelColor { return getColorFromUIKitTableD(@"_labelColor", %orig); }
+(id)_linkColor { return getColorFromUIKitTableD(@"_linkColor", %orig); }
+(id)_markedTextBackgroundColor { return getColorFromUIKitTableD(@"_markedTextBackgroundColor", %orig); }
+(id)_monochromeCellImageTintColor { return getColorFromUIKitTableD(@"_monochromeCellImageTintColor", %orig); }
+(id)_opaqueSeparatorColor { return getColorFromUIKitTableD(@"_opaqueSeparatorColor", %orig); }
+(id)_pageControlIndicatorColor { return getColorFromUIKitTableD(@"_pageControlIndicatorColor", %orig); }
+(id)_pageControlPlatterIndicatorColor { return getColorFromUIKitTableD(@"_pageControlPlatterIndicatorColor", %orig); }
+(id)_placeholderTextColor { return getColorFromUIKitTableD(@"_placeholderTextColor", %orig); }
+(id)_plainTableHeaderFooterTextColor { return getColorFromUIKitTableD(@"_plainTableHeaderFooterTextColor", %orig); }
+(id)_quaternaryFillColor { return getColorFromUIKitTableD(@"_quaternaryFillColor", %orig); }
+(id)_quaternaryLabelColor { return getColorFromUIKitTableD(@"_quaternaryLabelColor", %orig); }
+(id)_searchBarBackgroundColor { return getColorFromUIKitTableD(@"_searchBarBackgroundColor", %orig); }
+(id)_searchFieldDisabledBackgroundColor { return getColorFromUIKitTableD(@"_searchFieldDisabledBackgroundColor", %orig); }
+(id)_searchFieldPlaceholderTextClearButtonColor { return getColorFromUIKitTableD(@"_searchFieldPlaceholderTextClearButtonColor", %orig); }
+(id)_secondaryFillColor { return getColorFromUIKitTableD(@"_secondaryFillColor", %orig); }
+(id)_secondaryLabelColor { return getColorFromUIKitTableD(@"_secondaryLabelColor", %orig); }
+(id)_secondarySystemGroupedBackgroundColor { return getColorFromUIKitTableD(@"_secondarySystemGroupedBackgroundColor", %orig); }
+(id)_sidebarBackgroundColor { return getColorFromUIKitTableD(@"_sidebarBackgroundColor", %orig); }
+(id)_splitViewBorderColor { return getColorFromUIKitTableD(@"_splitViewBorderColor", %orig); }
+(id)_swiftColor { return getColorFromUIKitTableD(@"_swiftColor", %orig); }
+(id)_swipedSidebarCellBackgroundColor { return getColorFromUIKitTableD(@"_swipedSidebarCellBackgroundColor", %orig); }
+(id)_switchOffImageColor { return getColorFromUIKitTableD(@"_switchOffImageColor", %orig); }
+(id)_systemBackgroundColor { return getColorFromUIKitTableD(@"_systemBackgroundColor", %orig); }
+(id)_systemBackgroundSectionCellColor { return getColorFromUIKitTableD(@"_systemBackgroundSectionCellColor", %orig); }
+(id)_systemBackgroundSectionColor { return getColorFromUIKitTableD(@"_systemBackgroundSectionColor", %orig); }
+(id)_systemBlueColor2 { return getColorFromUIKitTableD(@"_systemBlueColor2", %orig); }
+(id)_systemChromeShadowColor { return getColorFromUIKitTableD(@"_systemChromeShadowColor", %orig); }
+(id)_systemDestructiveTintColor { return getColorFromUIKitTableD(@"_systemDestructiveTintColor", %orig); }
+(id)_systemGray2Color { return getColorFromUIKitTableD(@"_systemGray2Color", %orig); }
+(id)_systemGray3Color { return getColorFromUIKitTableD(@"_systemGray3Color", %orig); }
+(id)_systemGray4Color { return getColorFromUIKitTableD(@"_systemGray4Color", %orig); }
+(id)_systemGray5Color { return getColorFromUIKitTableD(@"_systemGray5Color", %orig); }
+(id)_systemGray6Color { return getColorFromUIKitTableD(@"_systemGray6Color", %orig); }
+(id)_systemGroupBackgroundColor { return getColorFromUIKitTableD(@"_systemGroupBackgroundColor", %orig); }
+(id)_systemGroupedBackgroundColor { return getColorFromUIKitTableD(@"_systemGroupedBackgroundColor", %orig); }
+(id)_systemInteractionTintColor { return getColorFromUIKitTableD(@"_systemInteractionTintColor", %orig); }
+(id)_systemMidGrayTintColor { return getColorFromUIKitTableD(@"_systemMidGrayTintColor", %orig); }
+(id)_systemSelectedColor { return getColorFromUIKitTableD(@"_systemSelectedColor", %orig); }
+(id)_tertiaryFillColor { return getColorFromUIKitTableD(@"_tertiaryFillColor", %orig); }
+(id)_tertiaryLabelColor { return getColorFromUIKitTableD(@"_tertiaryLabelColor", %orig); }
+(id)_tertiarySystemBackgroundColor { return getColorFromUIKitTableD(@"_tertiarySystemBackgroundColor", %orig); }
+(id)_tertiarySystemGroupedBackgroundColor { return getColorFromUIKitTableD(@"_tertiarySystemGroupedBackgroundColor", %orig); }
+(id)_textFieldBackgroundColor { return getColorFromUIKitTableD(@"_textFieldBackgroundColor", %orig); }
+(id)_textFieldBorderColor { return getColorFromUIKitTableD(@"_textFieldBorderColor", %orig); }
+(id)_textFieldDisabledBackgroundColor { return getColorFromUIKitTableD(@"_textFieldDisabledBackgroundColor", %orig); }
+(id)_textFieldDisabledBorderColor { return getColorFromUIKitTableD(@"_textFieldDisabledBorderColor", %orig); }
+(id)_translucentPaperTextureColor { return getColorFromUIKitTableD(@"_translucentPaperTextureColor", %orig); }
+(id)_tvInterfaceStyleDarkContentColor { return getColorFromUIKitTableD(@"_tvInterfaceStyleDarkContentColor", %orig); }
+(id)_tvInterfaceStyleLightContentColor { return getColorFromUIKitTableD(@"_tvInterfaceStyleLightContentColor", %orig); }
+(id)_tvLabelOpacityAColor { return getColorFromUIKitTableD(@"_tvLabelOpacityAColor", %orig); }
+(id)_tvLabelOpacityBColor { return getColorFromUIKitTableD(@"_tvLabelOpacityBColor", %orig); }
+(id)_tvLabelOpacityCColor { return getColorFromUIKitTableD(@"_tvLabelOpacityCColor", %orig); }
+(id)_vibrantDarkFillDodgeColor { return getColorFromUIKitTableD(@"_vibrantDarkFillDodgeColor", %orig); }
+(id)_vibrantLightDividerBurnColor { return getColorFromUIKitTableD(@"_vibrantLightDividerBurnColor", %orig); }
+(id)_vibrantLightDividerDarkeningColor { return getColorFromUIKitTableD(@"_vibrantLightDividerDarkeningColor", %orig); }
+(id)_vibrantLightFillBurnColor { return getColorFromUIKitTableD(@"_vibrantLightFillBurnColor", %orig); }
+(id)_vibrantLightSectionDelimiterDividerBurnColor { return getColorFromUIKitTableD(@"_vibrantLightSectionDelimiterDividerBurnColor", %orig); }
+(id)_vibrantLightSectionDelimiterDividerDarkeningColor { return getColorFromUIKitTableD(@"_vibrantLightSectionDelimiterDividerDarkeningColor", %orig); }
+(id)_webContentBackgroundColor { return getColorFromUIKitTableD(@"_webContentBackgroundColor", %orig); }
+(id)_windowBackgroundColor { return getColorFromUIKitTableD(@"_windowBackgroundColor", %orig); }
+(id)candidateRowBackgroundColor { return getColorFromUIKitTableD(@"candidateRowBackgroundColor", %orig); }
+(id)candidateRowHighlightedColor { return getColorFromUIKitTableD(@"candidateRowHighlightedColor", %orig); }
+(id)darkTextColor { return getColorFromUIKitTableD(@"darkTextColor", %orig); }
+(id)externalSystemGreenColor { return getColorFromUIKitTableD(@"externalSystemGreenColor", %orig); }
+(id)externalSystemRedColor { return getColorFromUIKitTableD(@"externalSystemRedColor", %orig); }
+(id)externalSystemTealColor { return getColorFromUIKitTableD(@"externalSystemTealColor", %orig); }
+(id)groupTableViewBackgroundColor { return getColorFromUIKitTableD(@"groupTableViewBackgroundColor", %orig); }
+(id)infoTextOverPinStripeTextColor { return getColorFromUIKitTableD(@"infoTextOverPinStripeTextColor", %orig); }
+(id)keyboardFocusIndicatorColor { return getColorFromUIKitTableD(@"keyboardFocusIndicatorColor", %orig); }
+(id)labelColor { return getColorFromUIKitTableD(@"labelColor", %orig); }
+(id)lineSeparatorColor { return getColorFromUIKitTableD(@"lineSeparatorColor", %orig); }
+(id)linkColor { return getColorFromUIKitTableD(@"linkColor", %orig); }
+(id)noContentDarkGradientBackgroundColor { return getColorFromUIKitTableD(@"noContentDarkGradientBackgroundColor", %orig); }
+(id)noContentLightGradientBackgroundColor { return getColorFromUIKitTableD(@"noContentLightGradientBackgroundColor", %orig); }
+(id)opaqueSeparatorColor { return getColorFromUIKitTableD(@"opaqueSeparatorColor", %orig); }
+(id)pinStripeColor { return getColorFromUIKitTableD(@"pinStripeColor", %orig); }
+(id)quaternaryLabelColor { return getColorFromUIKitTableD(@"quaternaryLabelColor", %orig); }
+(id)quaternarySystemFillColor { return getColorFromUIKitTableD(@"quaternarySystemFillColor", %orig); }
+(id)scrollViewTexturedBackgroundColor { return getColorFromUIKitTableD(@"scrollViewTexturedBackgroundColor", %orig); }
+(id)secondaryLabelColor { return getColorFromUIKitTableD(@"secondaryLabelColor", %orig); }
+(id)secondarySystemBackgroundColor { return getColorFromUIKitTableD(@"secondarySystemBackgroundColor", %orig); }
+(id)secondarySystemFillColor { return getColorFromUIKitTableD(@"secondarySystemFillColor", %orig); }
+(id)secondarySystemGroupedBackgroundColor { return getColorFromUIKitTableD(@"secondarySystemGroupedBackgroundColor", %orig); }
+(id)sectionHeaderBackgroundColor { return getColorFromUIKitTableD(@"sectionHeaderBackgroundColor", %orig); }
+(id)sectionHeaderBorderColor { return getColorFromUIKitTableD(@"sectionHeaderBorderColor", %orig); }
+(id)sectionHeaderOpaqueBackgroundColor { return getColorFromUIKitTableD(@"sectionHeaderOpaqueBackgroundColor", %orig); }
+(id)sectionListBorderColor { return getColorFromUIKitTableD(@"sectionListBorderColor", %orig); }
+(id)selectionGrabberColor { return getColorFromUIKitTableD(@"selectionGrabberColor", %orig); }
+(id)systemBackgroundColor { return getColorFromUIKitTableD(@"systemBackgroundColor", %orig); }
+(id)systemBlackColor { return getColorFromUIKitTableD(@"systemBlackColor", %orig); }
+(id)systemBrownColor { return getColorFromUIKitTableD(@"systemBrownColor", %orig); }
+(id)systemDarkBlueColor { return getColorFromUIKitTableD(@"systemDarkBlueColor", %orig); }
+(id)systemDarkExtraLightGrayColor { return getColorFromUIKitTableD(@"systemDarkExtraLightGrayColor", %orig); }
+(id)systemDarkExtraLightGrayTintColor { return getColorFromUIKitTableD(@"systemDarkExtraLightGrayTintColor", %orig); }
+(id)systemDarkGrayColor { return getColorFromUIKitTableD(@"systemDarkGrayColor", %orig); }
+(id)systemDarkGrayTintColor { return getColorFromUIKitTableD(@"systemDarkGrayTintColor", %orig); }
+(id)systemDarkGreenColor { return getColorFromUIKitTableD(@"systemDarkGreenColor", %orig); }
+(id)systemDarkLightGrayColor { return getColorFromUIKitTableD(@"systemDarkLightGrayColor", %orig); }
+(id)systemDarkLightGrayTintColor { return getColorFromUIKitTableD(@"systemDarkLightGrayTintColor", %orig); }
+(id)systemDarkLightMidGrayColor { return getColorFromUIKitTableD(@"systemDarkLightMidGrayColor", %orig); }
+(id)systemDarkMidGrayColor { return getColorFromUIKitTableD(@"systemDarkMidGrayColor", %orig); }
+(id)systemDarkMidGrayTintColor { return getColorFromUIKitTableD(@"systemDarkMidGrayTintColor", %orig); }
+(id)systemDarkOrangeColor { return getColorFromUIKitTableD(@"systemDarkOrangeColor", %orig); }
+(id)systemDarkPinkColor { return getColorFromUIKitTableD(@"systemDarkPinkColor", %orig); }
+(id)systemDarkPurpleColor { return getColorFromUIKitTableD(@"systemDarkPurpleColor", %orig); }
+(id)systemDarkRedColor { return getColorFromUIKitTableD(@"systemDarkRedColor", %orig); }
+(id)systemDarkTealColor { return getColorFromUIKitTableD(@"systemDarkTealColor", %orig); }
+(id)systemDarkYellowColor { return getColorFromUIKitTableD(@"systemDarkYellowColor", %orig); }
+(id)systemExtraLightGrayColor { return getColorFromUIKitTableD(@"systemExtraLightGrayColor", %orig); }
+(id)systemExtraLightGrayTintColor { return getColorFromUIKitTableD(@"systemExtraLightGrayTintColor", %orig); }
+(id)systemGray2Color { return getColorFromUIKitTableD(@"systemGray2Color", %orig); }
+(id)systemGray3Color { return getColorFromUIKitTableD(@"systemGray3Color", %orig); }
+(id)systemGray4Color { return getColorFromUIKitTableD(@"systemGray4Color", %orig); }
+(id)systemGray5Color { return getColorFromUIKitTableD(@"systemGray5Color", %orig); }
+(id)systemGray6Color { return getColorFromUIKitTableD(@"systemGray6Color", %orig); }
+(id)systemGrayTintColor { return getColorFromUIKitTableD(@"systemGrayTintColor", %orig); }
+(id)systemGreenColor { return getColorFromUIKitTableD(@"systemGreenColor", %orig); }
+(id)systemGroupedBackgroundColor { return getColorFromUIKitTableD(@"systemGroupedBackgroundColor", %orig); }
+(id)systemIndigoColor { return getColorFromUIKitTableD(@"systemIndigoColor", %orig); }
+(id)systemLightGrayColor { return getColorFromUIKitTableD(@"systemLightGrayColor", %orig); }
+(id)systemLightGrayTintColor { return getColorFromUIKitTableD(@"systemLightGrayTintColor", %orig); }
+(id)systemLightMidGrayColor { return getColorFromUIKitTableD(@"systemLightMidGrayColor", %orig); }
+(id)systemLightMidGrayTintColor { return getColorFromUIKitTableD(@"systemLightMidGrayTintColor", %orig); }
+(id)systemMidGrayColor { return getColorFromUIKitTableD(@"systemMidGrayColor", %orig); }
+(id)systemMidGrayTintColor { return getColorFromUIKitTableD(@"systemMidGrayTintColor", %orig); }
+(id)systemOrangeColor { return getColorFromUIKitTableD(@"systemOrangeColor", %orig); }
+(id)systemPurpleColor { return getColorFromUIKitTableD(@"systemPurpleColor", %orig); }
+(id)systemRedColor { return getColorFromUIKitTableD(@"systemRedColor", %orig); }
+(id)systemWhiteColor { return getColorFromUIKitTableD(@"systemWhiteColor", %orig); }
+(id)systemYellowColor { return getColorFromUIKitTableD(@"systemYellowColor", %orig); }
+(id)tableCellBackgroundColor { return getColorFromUIKitTableD(@"tableCellBackgroundColor", %orig); }
+(id)tableCellBlueTextColor { return getColorFromUIKitTableD(@"tableCellBlueTextColor", %orig); }
+(id)tableCellDefaultSelectionTintColor { return getColorFromUIKitTableD(@"tableCellDefaultSelectionTintColor", %orig); }
+(id)tableCellDisabledBackgroundColor { return getColorFromUIKitTableD(@"tableCellDisabledBackgroundColor", %orig); }
+(id)tableCellGrayTextColor { return getColorFromUIKitTableD(@"tableCellGrayTextColor", %orig); }
+(id)tableCellGroupedBackgroundColorLegacyWhite { return getColorFromUIKitTableD(@"tableCellGroupedBackgroundColorLegacyWhite", %orig); }
+(id)tableCellGroupedSelectedBackgroundColor { return getColorFromUIKitTableD(@"tableCellGroupedSelectedBackgroundColor", %orig); }
+(id)tableCellHighlightedBackgroundColor { return getColorFromUIKitTableD(@"tableCellHighlightedBackgroundColor", %orig); }
+(id)tableCellPlainBackgroundColor { return getColorFromUIKitTableD(@"tableCellPlainBackgroundColor", %orig); }
+(id)tableCellPlainSelectedBackgroundColor { return getColorFromUIKitTableD(@"tableCellPlainSelectedBackgroundColor", %orig); }
+(id)tableCellValue1BlueColor { return getColorFromUIKitTableD(@"tableCellValue1BlueColor", %orig); }
+(id)tableCellValue2BlueColor { return getColorFromUIKitTableD(@"tableCellValue2BlueColor", %orig); }
+(id)tableGroupedTopShadowColor { return getColorFromUIKitTableD(@"tableGroupedTopShadowColor", %orig); }
+(id)tablePlainHeaderFooterBackgroundColor { return getColorFromUIKitTableD(@"tablePlainHeaderFooterBackgroundColor", %orig); }
+(id)tablePlainHeaderFooterFloatingBackgroundColor { return getColorFromUIKitTableD(@"tablePlainHeaderFooterFloatingBackgroundColor", %orig); }
+(id)tableSelectionColor { return getColorFromUIKitTableD(@"tableSelectionColor", %orig); }
+(id)tableSelectionGradientEndColor { return getColorFromUIKitTableD(@"tableSelectionGradientEndColor", %orig); }
+(id)tableSelectionGradientStartColor { return getColorFromUIKitTableD(@"tableSelectionGradientStartColor", %orig); }
+(id)tableSeparatorDarkColor { return getColorFromUIKitTableD(@"tableSeparatorDarkColor", %orig); }
+(id)tableSeparatorLightColor { return getColorFromUIKitTableD(@"tableSeparatorLightColor", %orig); }
+(id)tableShadowColor { return getColorFromUIKitTableD(@"tableShadowColor", %orig); }
+(id)tertiaryLabelColor { return getColorFromUIKitTableD(@"tertiaryLabelColor", %orig); }
+(id)tertiarySystemBackgroundColor { return getColorFromUIKitTableD(@"tertiarySystemBackgroundColor", %orig); }
+(id)tertiarySystemFillColor { return getColorFromUIKitTableD(@"tertiarySystemFillColor", %orig); }
+(id)tertiarySystemGroupedBackgroundColor { return getColorFromUIKitTableD(@"tertiarySystemGroupedBackgroundColor", %orig); }
+(id)textFieldAtomBlueColor { return getColorFromUIKitTableD(@"textFieldAtomBlueColor", %orig); }
+(id)textFieldAtomPurpleColor { return getColorFromUIKitTableD(@"textFieldAtomPurpleColor", %orig); }
+(id)textGrammarIndicatorColor { return getColorFromUIKitTableD(@"textGrammarIndicatorColor", %orig); }
+(id)underPageBackgroundColor { return getColorFromUIKitTableD(@"underPageBackgroundColor", %orig); }
+(id)viewFlipsideBackgroundColor { return getColorFromUIKitTableD(@"viewFlipsideBackgroundColor", %orig); }

%end

%hook UITabBarButton
- (void) didMoveToSuperview {
    %orig;
    [MSHookIvar<NSMutableDictionary*>(self, "_contentTintColorsForState") setObject:getColorFromUIKitTable(@"secondaryLabelColor") forKey:@0];
    MSHookIvar<UIColor*>(self, "_defaultUnselectedLabelTintColor") = getColorFromUIKitTable(@"secondaryLabelColor");
    MSHookIvar<UILabel*>(self, "_label").textColor = getColorFromUIKitTable(@"secondaryLabelColor");
}
-(BOOL)iconShouldUseVibrancyForState:(long long)arg1 {
    return NO;
}
-(BOOL)labelShouldUseVibrancyForState:(long long)arg1 {
    return NO;
}
%end

%end

static void initUIKitHook() {
    UIKitColorTable = @{
        @"_windowBackgroundColor": @BASE,
        @"systemBackgroundColor": @BASE,
        @"_systemBackgroundColor": @BASE,
        @"secondarySystemBackgroundColor": @SURFACE0,
        @"tertiarySystemBackgroundColor": @SURFACE1,

        @"systemGroupedBackgroundColor": @BASE,
        @"_systemGroupedBackgroundColor": @BASE,
        @"secondarySystemGroupedBackgroundColor": @SURFACE0,
        @"_secondarySystemGroupedBackgroundColor": @SURFACE0,
        @"tertiarySystemGroupedBackgroundColor": @SURFACE1,
        @"systemGroupBackgroundColor": @BASE,
        @"systemGroupBackgroundCellColor": @SURFACE0,
        @"groupTableViewBackgroundColor": @BASE,

        @"systemGray6Color": @SURFACE0,
        @"systemGray5Color": @SURFACE1,
        @"systemGray4Color": @SURFACE2,
        @"systemGray3Color": @OVERLAY0,
        @"systemGray2Color": @OVERLAY1,
        @"systemGrayColor": @OVERLAY2,

        @"_labelColor": @TEXT,
        @"labelColor": @TEXT,
        @"_secondaryLabelColor": @SUBTEXT1,
        @"secondaryLabelColor": @SUBTEXT1,
        @"tertiaryLabelColor": @SUBTEXT0,
        @"_tertiaryLabelColor": @SUBTEXT0,
        @"quaternaryLabelColor": @OVERLAY2,
        @"_quaternaryLabelColor": @OVERLAY2,
        @"placeholderTextColor": @SUBTEXT0,
        @"darkTextColor": @BASE,
        @"lightTextColor": @TEXT,
        @"groupTableHeaderFooterTextColor": @TEXT,
        @"plainTableHeaderFooterTextColor": @TEXT,
        @"tableCellGrayTextColor": @TEXT,
        @"tableCellBlueTextColor": @TEXT,

        @"systemFillColor": @SURFACE0,
        @"secondarySystemFillColor": @SURFACE0,
        @"tertiarySystemFillColor": @SURFACE0,
        @"quaternarySystemFillColor": @MEDTRANS_OVERLAY0,
        @"fillColor": @SURFACE0,
        @"secondaryFillColor": @SURFACE0,
        @"tertiaryFillColor": @SURFACE0,
        @"quaternaryFillColor": @SURFACE0,

        @"separatorColor": @OVERLAY1,
        @"_separatorColor": @OVERLAY1,
        @"opaqueSeparatorColor": @OVERLAY1,
        @"lineSeparatorColor": @OVERLAY1,
        @"tableSeparatorColor": @OVERLAY1,
        @"tableSeparatorDarkColor": @OVERLAY1,
        @"tableSeparatorLightColor": @OVERLAY1,
        @"tableGroupedSeparatorLightColor": @OVERLAY1,

        @"tableBackgroundColor": @MANTLE,
        @"tableCellBackgroundColor": @MANTLE,
        @"tableCellPlainBackgroundColor": @MANTLE,
        @"tableCellPlainSelectedBackgroundColor": @SURFACE2,
        @"tableCellGroupedBackgroundColor": @MANTLE,
        @"tableCellGroupedSelectedBackgroundColor": @SURFACE2,
        @"tableCellGroupedBackgroundColorLegacyWhite": @MANTLE,

        @"whiteColor": @ADAPTIVE_LIGHT,
        @"blackColor": @ADAPTIVE_DARK,
        @"indigoColor": @BLUE,
        @"orangeColor": @PEACH,
        @"pinkColor": @PINK,
        @"purpleColor": @MAUVE,
        @"tealColor": @TEAL,
        @"cyanColor": @TEAL,
        @"greenColor": @GREEN,
        @"redColor": @RED,
        @"yellowColor": @YELLOW,
        @"darkGrayColor": @SURFACE1,
        @"grayColor": @OVERLAY0,
        @"lightGrayColor": @OVERLAY2,

        @"systemWhiteColor": @ADAPTIVE_LIGHT,
        @"systemBlackColor": @ADAPTIVE_DARK,
        @"systemIndigoColor": @BLUE,
        @"systemOrangeColor": @PEACH,
        @"systemPinkColor": @PINK,
        @"systemPurpleColor": @MAUVE,
        @"systemTealColor": @TEAL,
        @"systemCyanColor": @TEAL,
        @"systemGreenColor": @GREEN,
        @"systemRedColor": @RED,
        @"systemYellowColor": @YELLOW,

        @"externalSystemWhiteColor": @ADAPTIVE_LIGHT,
        @"externalSystemBlackColor": @ADAPTIVE_DARK,
        @"externalSystemIndigoColor": @BLUE,
        @"externalSystemOrangeColor": @PEACH,
        @"externalSystemPinkColor": @PINK,
        @"externalSystemPurpleColor": @MAUVE,
        @"externalSystemTealColor": @TEAL,
        @"externalSystemCyanColor": @TEAL,
        @"externalSystemGreenColor": @GREEN,
        @"externalSystemRedColor": @RED,
        @"externalSystemYellowColor": @YELLOW,

        @"systemBlueColor": @ACCENT,
        @"systemBlueColor2": @ACCENT,
        @"_systemBlueColor2": @ACCENT,
        @"blueColor": @ACCENT,
        @"linkColor": @ACCENT,
        @"insertionPointColor": @ACCENT,
        @"selectionGrabberColor": @ACCENT,
        @"tintColor": @ACCENT,
        @"_carSystemFocusColor": @ACCENT,
        @"_appKeyColor": @ACCENT,
        @"_appKeyColorOrDefaultTint": @ACCENT,

        @"selectionHighlightColor": @HIGHLIGHT,
        @"_alternateSystemInteractionTintColor": @HIGHLIGHT,
        @"tableCellDefaultSelectionTintColor": @HIGHLIGHT,

        @"_textFieldBorderColor": @OVERLAY0,
        @"_textFieldBackgroundColor": @SURFACE0,
        @"_switchOffColor": @SURFACE0,
        @"_switchOffImageColor": @SURFACE0,
        @"_systemChromeShadowColor": @HIGHTRANS_BASE,
        @"_controlShadowColor": @HIGHTRANS_BASE,
        @"_dimmingViewColor": @HIGHTRANS_BASE,
        @"_alertControllerDimmingViewColor": @HIGHTRANS_BASE,
        @"_pageControlPlatterIndicatorColor": @HIGHTRANS_TEXT,
        @"_pageControlIndicatorColor": @LOWTRANS_TEXT,
        @"_controlForegroundColor": @HIGHTRANS_TEXT,
        @"_splitViewBorderColor": @OVERLAY0,
        @"_barStyleBlackHairlineShadowColor": @HIGHTRANS_TEXT,

        @"ctpios_tabBarBackgroundColor": @TRANSPARENT,
    };
    UIKitColorBlacklist = @[@"clearColor", @"__halfTransparentWhiteColor"];

    %init(uikithooks);
}
// vim:ft=objcpp

#import "vendor/youtube/YTCommonColorPalette.h"

%group integration_youtube
%hook YTCommonColorPalette
- (UIColor *)background1 { return getColor(BASE); }
- (UIColor *)background2 { return getColor(MANTLE); }
- (UIColor *)background3 { return getColor(CRUST); }

- (UIColor *)staticBlue { return getColor(ACCENT); }

- (UIColor *)brandBackgroundSolid { return getColor(MANTLE); }
- (UIColor *)brandBackgroundPrimary { return getColor(MANTLE); }
- (UIColor *)brandBackgroundSecondary { return getColor(CRUST); }

- (UIColor *)generalBackgroundA { return getColor(BASE); }
- (UIColor *)generalBackgroundB { return getColor(MANTLE); }
- (UIColor *)generalBackgroundC { return getColor(CRUST); }

- (UIColor *)errorBackground { return %orig; }

- (UIColor *)textPrimary { return getColor(TEXT); }
- (UIColor *)textSecondary { return getColor(SUBTEXT0); }
- (UIColor *)textDisabled { return getColor(OVERLAY0); }
- (UIColor *)textPrimaryInverse { return getColor(BASE); }

- (UIColor *)callToAction { return getColor(ACCENT); }
- (UIColor *)callToActionInverse { return getColor(ADAPTIVE_DARK); }

- (UIColor *)iconActive { return getColor(ACCENT); }
- (UIColor *)iconActiveOther { return getColor(TEXT); }
- (UIColor *)iconInactive { return getColor(SUBTEXT0); }
- (UIColor *)iconDisabled { return getColor(OVERLAY0); }

- (UIColor *)badgeChipBackground { return %orig; }

- (UIColor *)buttonChipBackgroundHover { return %orig; }

- (UIColor *)touchResponse { return getColor(MEDTRANS_TEXT); }

- (UIColor *)brandIconActive { return getColor(TEXT); }
- (UIColor *)brandIconInactive { return getColor(OVERLAY0); }

- (UIColor *)brandButtonBackground { return %orig; }

- (UIColor *)brandLinkText { return getColor(TEXT); }

- (UIColor *)tenPercentLayer { return getColor(HIGHTRANS_BASE); }

- (UIColor *)snackbarBackground { return %orig; }

- (UIColor *)themedBlue { return getColor(BLUE); }
- (UIColor *)themedGreen { return getColor(GREEN); }

- (UIColor *)staticBrandRed { return getColor(RED); }
- (UIColor *)staticBrandWhite { return getColor(ADAPTIVE_LIGHT); }
- (UIColor *)staticBrandBlack { return getColor(ADAPTIVE_DARK); }

- (UIColor *)staticClearColor { return getColor(TRANSPARENT); }
- (UIColor *)staticAdYellow { return getColor(YELLOW); }
- (UIColor *)staticGrey { return getColor(OVERLAY0); }

- (UIColor *)overlayBackgroundSolid { return getColor(MEDTRANS_BASE); }
- (UIColor *)overlayBackgroundHeavy { return getColor(LOWTRANS_BASE); }
- (UIColor *)overlayBackgroundMedium { return getColor(MEDTRANS_BASE); }
- (UIColor *)overlayBackgroundMediumLight { return getColor(MEDTRANS_BASE); }
- (UIColor *)overlayBackgroundLight { return getColor(MEDTRANS_BASE); }
- (UIColor *)overlayBackgroundBrand { return %orig; }
- (UIColor *)overlayBackgroundClear { return getColor(TRANSPARENT); }

- (UIColor *)overlayTextPrimary { return getColor(TEXT); }
- (UIColor *)overlayTextSecondary { return getColor(SUBTEXT0); }
- (UIColor *)overlayTextTertiary { return getColor(OVERLAY0); }

- (UIColor *)overlayIconActiveCallToAction { return getColor(ACCENT); }
- (UIColor *)overlayIconActiveOther { return getColor(TEXT); }
- (UIColor *)overlayIconInactive { return getColor(SUBTEXT0); }
- (UIColor *)overlayIconDisabled { return getColor(OVERLAY0); }

- (UIColor *)overlayFilledButtonActive { return getColor(ACCENT); }
- (UIColor *)overlayButtonSecondary { return getColor(TEXT); }
- (UIColor *)overlayButtonPrimary { return getColor(TEXT); }

- (UIColor *)verifiedBadgeBackground { return %orig; }

- (UIColor *)themedOverlayBackground { return %orig; }

- (UIColor *)adIndicator { return getColor(YELLOW); }
- (UIColor *)errorIndicator { return getColor(RED); }

- (UIColor *)baseBackground { return getColor(BASE); }
- (UIColor *)raisedBackground { return getColor(BASE); }
- (UIColor *)menuBackground { return getColor(BASE); }
- (UIColor *)invertedBackground { return getColor(TEXT); }
- (UIColor *)additiveBackground { return getColor(MANTLE); }

- (UIColor *)outline { return getColor(SURFACE2); }
%end

%hook YTColor
+ (UIColor *)white1 { return getColor(ADAPTIVE_LIGHT); }
+ (UIColor *)white3 { return getColor(ADAPTIVE_LIGHT); }
+ (UIColor *)black1 { return getColor(ADAPTIVE_DARK); }
+ (UIColor *)black2 { return getColor(ADAPTIVE_DARK); }
+ (UIColor *)black3 { return getColor(ADAPTIVE_DARK); }
%end

%hook ASTextView
- (void)setTextColor:(UIColor *)textColor {
   %orig(getColor(TEXT));
}
%end

%hook CATextLayer
- (void)setTextColor:(CGColorRef)textColor {
    %orig(getColor(TEXT).CGColor);
}
%end

%end

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

        NSLog(@"ctpios: youtube integration %@", [prefs objectForKey:@"integration_youtube"]);
        if ([prefs objectForKey:@"integration_youtube"]) {
            [enabledIntegrations addObject:@"youtube"];
        }
    }
    if ([[[NSProcessInfo processInfo] processName] isEqualToString:@"Preferences"]) {
        if ([pref_flavor isEqualToString:@"latte"]) {
            setDarkMode(1);
        } else {
            setDarkMode(2);
        }
    }
}


%ctor {
    enabledIntegrations = [NSMutableArray array];

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.catppuccin.ios.prefs/reload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPreferences();

    NSLog(@"ctpios: initializing uikit hooks");
    initUIKitHook();

    if ([enabledIntegrations containsObject:@"youtube"]) {
        NSLog(@"ctpios: initializing youtube hooks");
        %init(integration_youtube);
    }
}

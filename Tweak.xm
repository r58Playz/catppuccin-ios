// vim:ft=objcpp
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <Foundation/NSUserDefaults+Private.h>
#import <UIKit/UIColor.h>

#import "utils.h"
#import "colors.h"

static NSString *pref_flavor;
static NSString *pref_accent;

static NSArray *colors;
static UIColor *accent;
static UIColor *highlight;
static NSDictionary *colorTable;
static NSArray *colorBlacklist;

static void loadPreferences();
static UIColor *getColor(NSString *name);
static UIColor *getColorD(NSString *name, UIColor *orig);

%group uihooks

%hook UIDynamicSystemColor

- (id)initWithName:(NSString *)name colorsByThemeKey:(NSDictionary *)systemColorTable {
    UIColor *color = getColor(name);
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
+(id)separatorColor { return getColorD(@"separatorColor", %orig); }
+(id)insertionPointColor { return getColorD(@"insertionPointColor", %orig); }
+(id)selectionHighlightColor { return getColorD(@"selectionHighlightColor", %orig); }
+(id)_tintColor { return getColorD(@"_tintColor", %orig); }
+(id)tintColor { return getColorD(@"tintColor", %orig); }
+(id)darkGrayColor { return getColorD(@"darkGrayColor", %orig); }
+(id)magentaColor { return getColorD(@"magentaColor", %orig); }
+(id)lightTextColor { return getColorD(@"lightTextColor", %orig); }
+(id)redColor { return getColorD(@"redColor", %orig); }
+(id)clearColor { return getColorD(@"clearColor", %orig); }
+(id)grayColor { return getColorD(@"grayColor", %orig); }
+(id)orangeColor { return getColorD(@"orangeColor", %orig); }
+(id)tableBackgroundColor { return getColorD(@"tableBackgroundColor", %orig); }
+(id)lightGrayColor { return getColorD(@"lightGrayColor", %orig); }
+(id)brownColor { return getColorD(@"brownColor", %orig); }
+(id)purpleColor { return getColorD(@"purpleColor", %orig); }
+(id)readableTypeIdentifiersForItemProvider { return getColorD(@"readableTypeIdentifiersForItemProvider", %orig); }
+(id)classFallbacksForKeyedArchiver { return getColorD(@"classFallbacksForKeyedArchiver", %orig); }
+(id)whiteColor { return getColorD(@"whiteColor", %orig); }
+(id)tableSeparatorColor { return getColorD(@"tableSeparatorColor", %orig); }
+(id)yellowColor { return getColorD(@"yellowColor", %orig); }
+(id)cyanColor { return getColorD(@"cyanColor", %orig); }
+(id)greenColor { return getColorD(@"greenColor", %orig); }
+(id)blackColor { return getColorD(@"blackColor", %orig); }
+(id)placeholderTextColor { return getColorD(@"placeholderTextColor", %orig); }
+(id)blueColor { return getColorD(@"blueColor", %orig); }
+(id)writableTypeIdentifiersForItemProvider { return getColorD(@"writableTypeIdentifiersForItemProvider", %orig); }
+(id)_secondarySystemBackgroundColor { return getColorD(@"_secondarySystemBackgroundColor", %orig); }
+(id)_separatorColor { return getColorD(@"_separatorColor", %orig); }
+(id)_switchOffColor { return getColorD(@"_switchOffColor", %orig); }
+(id)_systemGroupBackgroundCellColor { return getColorD(@"_systemGroupBackgroundCellColor", %orig); }
+(id)_vibrantLightFillDarkeningColor { return getColorD(@"_vibrantLightFillDarkeningColor", %orig); }
+(id)systemDarkLightMidGrayTintColor { return getColorD(@"systemDarkLightMidGrayTintColor", %orig); }
+(id)systemMintColor { return getColorD(@"systemMintColor", %orig); }
+(id)tableCellFocusedBackgroundColor { return getColorD(@"tableCellFocusedBackgroundColor", %orig); }
+(id)tableCellbackgroundColorCarPlay { return getColorD(@"tableCellbackgroundColorCarPlay", %orig); }
+(id)systemBlueColor { return getColorD(@"systemBlueColor", %orig); }
+(id)systemCyanColor { return getColorD(@"systemCyanColor", %orig); }
+(id)systemFillColor { return getColorD(@"systemFillColor", %orig); }
+(id)systemGrayColor { return getColorD(@"systemGrayColor", %orig); }
+(id)systemPinkColor { return getColorD(@"systemPinkColor", %orig); }
+(id)systemTealColor { return getColorD(@"systemTealColor", %orig); }
+(id)tableCellGroupedBackgroundColor { return getColorD(@"tableCellGroupedBackgroundColor", %orig); }
+(id)tableGroupedSeparatorLightColor { return getColorD(@"tableGroupedSeparatorLightColor", %orig); }
+(id)__halfTransparentBlackColor { return getColorD(@"__halfTransparentBlackColor", %orig); }
+(id)__halfTransparentWhiteColor { return getColorD(@"__halfTransparentWhiteColor", %orig); }
+(id)__tintColor { return getColorD(@"__tintColor", %orig); }
+(id)_accessibilityButtonShapesBackgroundColorOnDark { return getColorD(@"_accessibilityButtonShapesBackgroundColorOnDark", %orig); }
+(id)_accessibilityButtonShapesBackgroundColorOnLight { return getColorD(@"_accessibilityButtonShapesBackgroundColorOnLight", %orig); }
+(id)_accessibilityButtonShapesDisabledBackgroundColorOnDark { return getColorD(@"_accessibilityButtonShapesDisabledBackgroundColorOnDark", %orig); }
+(id)_accessibilityButtonShapesNoBlendModeBackgroundColorOnDark { return getColorD(@"_accessibilityButtonShapesNoBlendModeBackgroundColorOnDark", %orig); }
+(id)_accessibilityButtonShapesNoBlendModeBackgroundColorOnLight { return getColorD(@"_accessibilityButtonShapesNoBlendModeBackgroundColorOnLight", %orig); }
+(id)_alertControllerDimmingViewColor { return getColorD(@"_alertControllerDimmingViewColor", %orig); }
+(id)_alternateSystemInteractionTintColor { return getColorD(@"_alternateSystemInteractionTintColor", %orig); }
+(id)_apiColorNames { return getColorD(@"_apiColorNames", %orig); }
+(id)_appKeyColor { return getColorD(@"_appKeyColor", %orig); }
+(id)_appKeyColorOrDefaultTint { return getColorD(@"_appKeyColorOrDefaultTint", %orig); }
+(id)_barHairlineShadowColor { return getColorD(@"_barHairlineShadowColor", %orig); }
+(id)_barStyleBlackHairlineShadowColor { return getColorD(@"_barStyleBlackHairlineShadowColor", %orig); }
+(id)_carSystemFocusColor { return getColorD(@"_carSystemFocusColor", %orig); }
+(id)_carSystemFocusLabelColor { return getColorD(@"_carSystemFocusLabelColor", %orig); }
+(id)_carSystemFocusPrimaryColor { return getColorD(@"_carSystemFocusPrimaryColor", %orig); }
+(id)_carSystemFocusSecondaryColor { return getColorD(@"_carSystemFocusSecondaryColor", %orig); }
+(id)_carSystemPrimaryColor { return getColorD(@"_carSystemPrimaryColor", %orig); }
+(id)_carSystemQuaternaryColor { return getColorD(@"_carSystemQuaternaryColor", %orig); }
+(id)_carSystemSecondaryColor { return getColorD(@"_carSystemSecondaryColor", %orig); }
+(id)_carSystemTertiaryColor { return getColorD(@"_carSystemTertiaryColor", %orig); }
+(id)_contentBackgroundColor { return getColorD(@"_contentBackgroundColor", %orig); }
+(id)_controlForegroundColor { return getColorD(@"_controlForegroundColor", %orig); }
+(id)_controlHighlightColor { return getColorD(@"_controlHighlightColor", %orig); }
+(id)_controlShadowColor { return getColorD(@"_controlShadowColor", %orig); }
+(id)_controlVibrantBottomBackgroundColor { return getColorD(@"_controlVibrantBottomBackgroundColor", %orig); }
+(id)_controlVibrantTopBackgroundColor { return getColorD(@"_controlVibrantTopBackgroundColor", %orig); }
+(id)_dimmingViewColor { return getColorD(@"_dimmingViewColor", %orig); }
+(id)_dynamicTestColor { return getColorD(@"_dynamicTestColor", %orig); }
+(id)_externalBarBackgroundColor { return getColorD(@"_externalBarBackgroundColor", %orig); }
+(id)_externalSystemDarkGrayColor { return getColorD(@"_externalSystemDarkGrayColor", %orig); }
+(id)_externalSystemExtraDarkGrayColor { return getColorD(@"_externalSystemExtraDarkGrayColor", %orig); }
+(id)_externalSystemGrayColor { return getColorD(@"_externalSystemGrayColor", %orig); }
+(id)_externalSystemMidGrayColor { return getColorD(@"_externalSystemMidGrayColor", %orig); }
+(id)_externalSystemSuperDarkGrayColor { return getColorD(@"_externalSystemSuperDarkGrayColor", %orig); }
+(id)_externalSystemWhiteColor { return getColorD(@"_externalSystemWhiteColor", %orig); }
+(id)_fillColor { return getColorD(@"_fillColor", %orig); }
+(id)_groupTableHeaderFooterTextColor { return getColorD(@"_groupTableHeaderFooterTextColor", %orig); }
+(id)_labelColor { return getColorD(@"_labelColor", %orig); }
+(id)_linkColor { return getColorD(@"_linkColor", %orig); }
+(id)_markedTextBackgroundColor { return getColorD(@"_markedTextBackgroundColor", %orig); }
+(id)_monochromeCellImageTintColor { return getColorD(@"_monochromeCellImageTintColor", %orig); }
+(id)_opaqueSeparatorColor { return getColorD(@"_opaqueSeparatorColor", %orig); }
+(id)_pageControlIndicatorColor { return getColorD(@"_pageControlIndicatorColor", %orig); }
+(id)_pageControlPlatterIndicatorColor { return getColorD(@"_pageControlPlatterIndicatorColor", %orig); }
+(id)_placeholderTextColor { return getColorD(@"_placeholderTextColor", %orig); }
+(id)_plainTableHeaderFooterTextColor { return getColorD(@"_plainTableHeaderFooterTextColor", %orig); }
+(id)_quaternaryFillColor { return getColorD(@"_quaternaryFillColor", %orig); }
+(id)_quaternaryLabelColor { return getColorD(@"_quaternaryLabelColor", %orig); }
+(id)_searchBarBackgroundColor { return getColorD(@"_searchBarBackgroundColor", %orig); }
+(id)_searchFieldDisabledBackgroundColor { return getColorD(@"_searchFieldDisabledBackgroundColor", %orig); }
+(id)_searchFieldPlaceholderTextClearButtonColor { return getColorD(@"_searchFieldPlaceholderTextClearButtonColor", %orig); }
+(id)_secondaryFillColor { return getColorD(@"_secondaryFillColor", %orig); }
+(id)_secondaryLabelColor { return getColorD(@"_secondaryLabelColor", %orig); }
+(id)_secondarySystemGroupedBackgroundColor { return getColorD(@"_secondarySystemGroupedBackgroundColor", %orig); }
+(id)_sidebarBackgroundColor { return getColorD(@"_sidebarBackgroundColor", %orig); }
+(id)_splitViewBorderColor { return getColorD(@"_splitViewBorderColor", %orig); }
+(id)_swiftColor { return getColorD(@"_swiftColor", %orig); }
+(id)_swipedSidebarCellBackgroundColor { return getColorD(@"_swipedSidebarCellBackgroundColor", %orig); }
+(id)_switchOffImageColor { return getColorD(@"_switchOffImageColor", %orig); }
+(id)_systemBackgroundColor { return getColorD(@"_systemBackgroundColor", %orig); }
+(id)_systemBackgroundSectionCellColor { return getColorD(@"_systemBackgroundSectionCellColor", %orig); }
+(id)_systemBackgroundSectionColor { return getColorD(@"_systemBackgroundSectionColor", %orig); }
+(id)_systemBlueColor2 { return getColorD(@"_systemBlueColor2", %orig); }
+(id)_systemChromeShadowColor { return getColorD(@"_systemChromeShadowColor", %orig); }
+(id)_systemDestructiveTintColor { return getColorD(@"_systemDestructiveTintColor", %orig); }
+(id)_systemGray2Color { return getColorD(@"_systemGray2Color", %orig); }
+(id)_systemGray3Color { return getColorD(@"_systemGray3Color", %orig); }
+(id)_systemGray4Color { return getColorD(@"_systemGray4Color", %orig); }
+(id)_systemGray5Color { return getColorD(@"_systemGray5Color", %orig); }
+(id)_systemGray6Color { return getColorD(@"_systemGray6Color", %orig); }
+(id)_systemGroupBackgroundColor { return getColorD(@"_systemGroupBackgroundColor", %orig); }
+(id)_systemGroupedBackgroundColor { return getColorD(@"_systemGroupedBackgroundColor", %orig); }
+(id)_systemInteractionTintColor { return getColorD(@"_systemInteractionTintColor", %orig); }
+(id)_systemMidGrayTintColor { return getColorD(@"_systemMidGrayTintColor", %orig); }
+(id)_systemSelectedColor { return getColorD(@"_systemSelectedColor", %orig); }
+(id)_tertiaryFillColor { return getColorD(@"_tertiaryFillColor", %orig); }
+(id)_tertiaryLabelColor { return getColorD(@"_tertiaryLabelColor", %orig); }
+(id)_tertiarySystemBackgroundColor { return getColorD(@"_tertiarySystemBackgroundColor", %orig); }
+(id)_tertiarySystemGroupedBackgroundColor { return getColorD(@"_tertiarySystemGroupedBackgroundColor", %orig); }
+(id)_textFieldBackgroundColor { return getColorD(@"_textFieldBackgroundColor", %orig); }
+(id)_textFieldBorderColor { return getColorD(@"_textFieldBorderColor", %orig); }
+(id)_textFieldDisabledBackgroundColor { return getColorD(@"_textFieldDisabledBackgroundColor", %orig); }
+(id)_textFieldDisabledBorderColor { return getColorD(@"_textFieldDisabledBorderColor", %orig); }
+(id)_translucentPaperTextureColor { return getColorD(@"_translucentPaperTextureColor", %orig); }
+(id)_tvInterfaceStyleDarkContentColor { return getColorD(@"_tvInterfaceStyleDarkContentColor", %orig); }
+(id)_tvInterfaceStyleLightContentColor { return getColorD(@"_tvInterfaceStyleLightContentColor", %orig); }
+(id)_tvLabelOpacityAColor { return getColorD(@"_tvLabelOpacityAColor", %orig); }
+(id)_tvLabelOpacityBColor { return getColorD(@"_tvLabelOpacityBColor", %orig); }
+(id)_tvLabelOpacityCColor { return getColorD(@"_tvLabelOpacityCColor", %orig); }
+(id)_vibrantDarkFillDodgeColor { return getColorD(@"_vibrantDarkFillDodgeColor", %orig); }
+(id)_vibrantLightDividerBurnColor { return getColorD(@"_vibrantLightDividerBurnColor", %orig); }
+(id)_vibrantLightDividerDarkeningColor { return getColorD(@"_vibrantLightDividerDarkeningColor", %orig); }
+(id)_vibrantLightFillBurnColor { return getColorD(@"_vibrantLightFillBurnColor", %orig); }
+(id)_vibrantLightSectionDelimiterDividerBurnColor { return getColorD(@"_vibrantLightSectionDelimiterDividerBurnColor", %orig); }
+(id)_vibrantLightSectionDelimiterDividerDarkeningColor { return getColorD(@"_vibrantLightSectionDelimiterDividerDarkeningColor", %orig); }
+(id)_webContentBackgroundColor { return getColorD(@"_webContentBackgroundColor", %orig); }
+(id)_windowBackgroundColor { return getColorD(@"_windowBackgroundColor", %orig); }
+(id)candidateRowBackgroundColor { return getColorD(@"candidateRowBackgroundColor", %orig); }
+(id)candidateRowHighlightedColor { return getColorD(@"candidateRowHighlightedColor", %orig); }
+(id)darkTextColor { return getColorD(@"darkTextColor", %orig); }
+(id)externalSystemGreenColor { return getColorD(@"externalSystemGreenColor", %orig); }
+(id)externalSystemRedColor { return getColorD(@"externalSystemRedColor", %orig); }
+(id)externalSystemTealColor { return getColorD(@"externalSystemTealColor", %orig); }
+(id)groupTableViewBackgroundColor { return getColorD(@"groupTableViewBackgroundColor", %orig); }
+(id)infoTextOverPinStripeTextColor { return getColorD(@"infoTextOverPinStripeTextColor", %orig); }
+(id)keyboardFocusIndicatorColor { return getColorD(@"keyboardFocusIndicatorColor", %orig); }
+(id)labelColor { return getColorD(@"labelColor", %orig); }
+(id)lineSeparatorColor { return getColorD(@"lineSeparatorColor", %orig); }
+(id)linkColor { return getColorD(@"linkColor", %orig); }
+(id)noContentDarkGradientBackgroundColor { return getColorD(@"noContentDarkGradientBackgroundColor", %orig); }
+(id)noContentLightGradientBackgroundColor { return getColorD(@"noContentLightGradientBackgroundColor", %orig); }
+(id)opaqueSeparatorColor { return getColorD(@"opaqueSeparatorColor", %orig); }
+(id)pinStripeColor { return getColorD(@"pinStripeColor", %orig); }
+(id)quaternaryLabelColor { return getColorD(@"quaternaryLabelColor", %orig); }
+(id)quaternarySystemFillColor { return getColorD(@"quaternarySystemFillColor", %orig); }
+(id)scrollViewTexturedBackgroundColor { return getColorD(@"scrollViewTexturedBackgroundColor", %orig); }
+(id)secondaryLabelColor { return getColorD(@"secondaryLabelColor", %orig); }
+(id)secondarySystemBackgroundColor { return getColorD(@"secondarySystemBackgroundColor", %orig); }
+(id)secondarySystemFillColor { return getColorD(@"secondarySystemFillColor", %orig); }
+(id)secondarySystemGroupedBackgroundColor { return getColorD(@"secondarySystemGroupedBackgroundColor", %orig); }
+(id)sectionHeaderBackgroundColor { return getColorD(@"sectionHeaderBackgroundColor", %orig); }
+(id)sectionHeaderBorderColor { return getColorD(@"sectionHeaderBorderColor", %orig); }
+(id)sectionHeaderOpaqueBackgroundColor { return getColorD(@"sectionHeaderOpaqueBackgroundColor", %orig); }
+(id)sectionListBorderColor { return getColorD(@"sectionListBorderColor", %orig); }
+(id)selectionGrabberColor { return getColorD(@"selectionGrabberColor", %orig); }
+(id)systemBackgroundColor { return getColorD(@"systemBackgroundColor", %orig); }
+(id)systemBlackColor { return getColorD(@"systemBlackColor", %orig); }
+(id)systemBrownColor { return getColorD(@"systemBrownColor", %orig); }
+(id)systemDarkBlueColor { return getColorD(@"systemDarkBlueColor", %orig); }
+(id)systemDarkExtraLightGrayColor { return getColorD(@"systemDarkExtraLightGrayColor", %orig); }
+(id)systemDarkExtraLightGrayTintColor { return getColorD(@"systemDarkExtraLightGrayTintColor", %orig); }
+(id)systemDarkGrayColor { return getColorD(@"systemDarkGrayColor", %orig); }
+(id)systemDarkGrayTintColor { return getColorD(@"systemDarkGrayTintColor", %orig); }
+(id)systemDarkGreenColor { return getColorD(@"systemDarkGreenColor", %orig); }
+(id)systemDarkLightGrayColor { return getColorD(@"systemDarkLightGrayColor", %orig); }
+(id)systemDarkLightGrayTintColor { return getColorD(@"systemDarkLightGrayTintColor", %orig); }
+(id)systemDarkLightMidGrayColor { return getColorD(@"systemDarkLightMidGrayColor", %orig); }
+(id)systemDarkMidGrayColor { return getColorD(@"systemDarkMidGrayColor", %orig); }
+(id)systemDarkMidGrayTintColor { return getColorD(@"systemDarkMidGrayTintColor", %orig); }
+(id)systemDarkOrangeColor { return getColorD(@"systemDarkOrangeColor", %orig); }
+(id)systemDarkPinkColor { return getColorD(@"systemDarkPinkColor", %orig); }
+(id)systemDarkPurpleColor { return getColorD(@"systemDarkPurpleColor", %orig); }
+(id)systemDarkRedColor { return getColorD(@"systemDarkRedColor", %orig); }
+(id)systemDarkTealColor { return getColorD(@"systemDarkTealColor", %orig); }
+(id)systemDarkYellowColor { return getColorD(@"systemDarkYellowColor", %orig); }
+(id)systemExtraLightGrayColor { return getColorD(@"systemExtraLightGrayColor", %orig); }
+(id)systemExtraLightGrayTintColor { return getColorD(@"systemExtraLightGrayTintColor", %orig); }
+(id)systemGray2Color { return getColorD(@"systemGray2Color", %orig); }
+(id)systemGray3Color { return getColorD(@"systemGray3Color", %orig); }
+(id)systemGray4Color { return getColorD(@"systemGray4Color", %orig); }
+(id)systemGray5Color { return getColorD(@"systemGray5Color", %orig); }
+(id)systemGray6Color { return getColorD(@"systemGray6Color", %orig); }
+(id)systemGrayTintColor { return getColorD(@"systemGrayTintColor", %orig); }
+(id)systemGreenColor { return getColorD(@"systemGreenColor", %orig); }
+(id)systemGroupedBackgroundColor { return getColorD(@"systemGroupedBackgroundColor", %orig); }
+(id)systemIndigoColor { return getColorD(@"systemIndigoColor", %orig); }
+(id)systemLightGrayColor { return getColorD(@"systemLightGrayColor", %orig); }
+(id)systemLightGrayTintColor { return getColorD(@"systemLightGrayTintColor", %orig); }
+(id)systemLightMidGrayColor { return getColorD(@"systemLightMidGrayColor", %orig); }
+(id)systemLightMidGrayTintColor { return getColorD(@"systemLightMidGrayTintColor", %orig); }
+(id)systemMidGrayColor { return getColorD(@"systemMidGrayColor", %orig); }
+(id)systemMidGrayTintColor { return getColorD(@"systemMidGrayTintColor", %orig); }
+(id)systemOrangeColor { return getColorD(@"systemOrangeColor", %orig); }
+(id)systemPurpleColor { return getColorD(@"systemPurpleColor", %orig); }
+(id)systemRedColor { return getColorD(@"systemRedColor", %orig); }
+(id)systemWhiteColor { return getColorD(@"systemWhiteColor", %orig); }
+(id)systemYellowColor { return getColorD(@"systemYellowColor", %orig); }
+(id)tableCellBackgroundColor { return getColorD(@"tableCellBackgroundColor", %orig); }
+(id)tableCellBlueTextColor { return getColorD(@"tableCellBlueTextColor", %orig); }
+(id)tableCellDefaultSelectionTintColor { return getColorD(@"tableCellDefaultSelectionTintColor", %orig); }
+(id)tableCellDisabledBackgroundColor { return getColorD(@"tableCellDisabledBackgroundColor", %orig); }
+(id)tableCellGrayTextColor { return getColorD(@"tableCellGrayTextColor", %orig); }
+(id)tableCellGroupedBackgroundColorLegacyWhite { return getColorD(@"tableCellGroupedBackgroundColorLegacyWhite", %orig); }
+(id)tableCellGroupedSelectedBackgroundColor { return getColorD(@"tableCellGroupedSelectedBackgroundColor", %orig); }
+(id)tableCellHighlightedBackgroundColor { return getColorD(@"tableCellHighlightedBackgroundColor", %orig); }
+(id)tableCellPlainBackgroundColor { return getColorD(@"tableCellPlainBackgroundColor", %orig); }
+(id)tableCellPlainSelectedBackgroundColor { return getColorD(@"tableCellPlainSelectedBackgroundColor", %orig); }
+(id)tableCellValue1BlueColor { return getColorD(@"tableCellValue1BlueColor", %orig); }
+(id)tableCellValue2BlueColor { return getColorD(@"tableCellValue2BlueColor", %orig); }
+(id)tableGroupedTopShadowColor { return getColorD(@"tableGroupedTopShadowColor", %orig); }
+(id)tablePlainHeaderFooterBackgroundColor { return getColorD(@"tablePlainHeaderFooterBackgroundColor", %orig); }
+(id)tablePlainHeaderFooterFloatingBackgroundColor { return getColorD(@"tablePlainHeaderFooterFloatingBackgroundColor", %orig); }
+(id)tableSelectionColor { return getColorD(@"tableSelectionColor", %orig); }
+(id)tableSelectionGradientEndColor { return getColorD(@"tableSelectionGradientEndColor", %orig); }
+(id)tableSelectionGradientStartColor { return getColorD(@"tableSelectionGradientStartColor", %orig); }
+(id)tableSeparatorDarkColor { return getColorD(@"tableSeparatorDarkColor", %orig); }
+(id)tableSeparatorLightColor { return getColorD(@"tableSeparatorLightColor", %orig); }
+(id)tableShadowColor { return getColorD(@"tableShadowColor", %orig); }
+(id)tertiaryLabelColor { return getColorD(@"tertiaryLabelColor", %orig); }
+(id)tertiarySystemBackgroundColor { return getColorD(@"tertiarySystemBackgroundColor", %orig); }
+(id)tertiarySystemFillColor { return getColorD(@"tertiarySystemFillColor", %orig); }
+(id)tertiarySystemGroupedBackgroundColor { return getColorD(@"tertiarySystemGroupedBackgroundColor", %orig); }
+(id)textFieldAtomBlueColor { return getColorD(@"textFieldAtomBlueColor", %orig); }
+(id)textFieldAtomPurpleColor { return getColorD(@"textFieldAtomPurpleColor", %orig); }
+(id)textGrammarIndicatorColor { return getColorD(@"textGrammarIndicatorColor", %orig); }
+(id)underPageBackgroundColor { return getColorD(@"underPageBackgroundColor", %orig); }
+(id)viewFlipsideBackgroundColor { return getColorD(@"viewFlipsideBackgroundColor", %orig); }

%end

%end


static void loadPreferences() {
	NSUserDefaults *preferences = [[NSUserDefaults alloc] initWithSuiteName:@"com.catppuccin.ios.prefs"];
	if (preferences) {
        pref_flavor = [preferences objectForKey:@"flavor"];
        pref_accent = [preferences objectForKey:@"accent"];
        colors = colorsFromHexStrings(flavorFromString(pref_flavor));
        accent = colors[accentFromString(pref_accent)];
        highlight = colorFromHexStringWithAlpha(flavorFromString(pref_flavor)[accentFromString(pref_accent)], 0.3);
        NSLog(@"ctpios: reloaded colors");
    }
}

static UIColor *getColor(NSString *name) {
    if([colorBlacklist containsObject:name]) return nil;
    if([colorTable objectForKey:name]) {
        int idx = [colorTable[name] intValue];
        UIColor *color;
        switch(idx) {
            case ACCENT:
                color = accent;
                break;
            case HIGHLIGHT:
                color = highlight;
                break;
            case BASE_ACCENT:
                color = blend(colors[BASE],accent,0.5);
                break;
            default:
                color = colors[idx];
                break;
        }
        // NSLog(@"ctpios: replaced %@ with %d", name, idx);
        return color;
    }
    NSLog(@"ctpios: %@ not found", name);
    return nil;
}

static UIColor *getColorD(NSString *name, UIColor *orig) {
    UIColor *color = getColor(name);
    return color == nil ? orig : color;
}

%ctor {
    colorTable = @{
        @"lightTextColor": @TEXT,
        @"darkTextColor": @TEXT,
        @"labelColor": @TEXT,
        @"placeholderTextColor": @SUBTEXT0,
        @"quaternaryLabelColor": @OVERLAY0,
        @"quaternarySystemFillColor": @CRUST,
        @"secondaryLabelColor": @SUBTEXT0,
        @"secondarySystemBackgroundColor": @BASE,
        @"secondarySystemFillColor": @MANTLE,
        @"systemBlackColor": @OVERLAY2,
        @"systemFillColor": @BASE,
        @"systemGray5Color": @BASE_ACCENT,
        @"systemGroupedBackgroundColor": @BASE,
        @"systemIndigoColor": @BLUE,
        @"systemOrangeColor": @PEACH,
        @"systemPinkColor": @PINK,
        @"systemPurpleColor": @MAUVE,
        @"systemTealColor": @TEAL,
        @"systemWhiteColor": @BASE,
        @"systemGreenColor": @GREEN,
        @"systemRedColor": @RED,
        @"systemYellowColor": @YELLOW,
        @"tableBackgroundColor": @BASE,
        @"tableCellGroupedBackgroundColor": @MANTLE,
        @"tableCellPlainBackgroundColor": @BASE,
        @"tableCellPlainSelectedBackgroundColor": @BASE_ACCENT,
        @"tertiaryLabelColor": @OVERLAY2,
        @"tertiarySystemBackgroundColor": @CRUST,


        @"systemBackgroundColor":@BASE,
        @"groupTableViewBackgroundColor": @BASE,

        @"_textFieldBackgroundColor": @SURFACE0,
        @"_textFieldBorderColor": @OVERLAY0,

        @"systemBlueColor": @ACCENT,
        @"systemBlueColor2": @ACCENT,
        @"linkColor": @ACCENT,
        @"insertionPointColor": @ACCENT,
        @"selectionGrabberColor": @ACCENT,
        @"tintColor": @ACCENT,

        @"selectionHighlightColor": @HIGHLIGHT,
    };
    colorBlacklist = @[@"clearColor", @"_appKeyColor", @"_appKeyColorOrDefaultTint"];

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.catppuccin.ios.prefs/reload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPreferences();
    %init(uihooks);
}

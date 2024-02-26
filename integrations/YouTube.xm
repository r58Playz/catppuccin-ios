// vim:ft=objcpp

#import "vendor/youtube/YTCommonColorPalette.h"
#import "vendor/youtube/YTColorPalette.h"
#import "vendor/youtube/_ASDisplayView.h"
#import "vendor/youtube/ASTextNode.h"

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

- (UIColor *)badgeChipBackground { return getColor(SURFACE0); }

- (UIColor *)buttonChipBackgroundHover { return %orig; }

- (UIColor *)touchResponse { return getColor(MEDTRANS_TEXT); }

- (UIColor *)brandIconActive { return getColor(TEXT); }
- (UIColor *)brandIconInactive { return getColor(OVERLAY0); }

- (UIColor *)brandButtonBackground { return %orig; }

- (UIColor *)brandLinkText { return getColor(ACCENT); }

- (UIColor *)tenPercentLayer { return getColor(HIGHTRANS_BASE); }

- (UIColor *)snackbarBackground { return getColor(BASE); }

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
- (UIColor *)overlayBackgroundBrand { return getColor(MEDTRANS_BASE); }
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

- (UIColor *)verifiedBadgeBackground { return getColor(SURFACE0); }

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

%hook YTColorPalette
- (UIColor *)background1 { return getColor(BASE); }
- (UIColor *)background2 { return getColor(MANTLE); }
- (UIColor *)background3 { return getColor(CRUST); }
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
- (UIColor *)iconActive { return getColor(ACCENT); }
- (UIColor *)iconActiveOther { return getColor(TEXT); }
- (UIColor *)iconInactive { return getColor(SUBTEXT0); }
- (UIColor *)iconDisabled { return getColor(OVERLAY0); }
- (UIColor *)badgeChipBackground { return getColor(SURFACE0); }
- (UIColor *)buttonChipBackgroundHover { return %orig; }
- (UIColor *)touchResponse { return getColor(MEDTRANS_TEXT); }
- (UIColor *)callToActionInverse { return getColor(ADAPTIVE_DARK); }
- (UIColor *)brandIconActive { return getColor(TEXT); }
- (UIColor *)brandIconInactive { return getColor(OVERLAY0); }
- (UIColor *)brandButtonBackground { return %orig; }
- (UIColor *)brandLinkText { return getColor(ACCENT); }
- (UIColor *)tenPercentLayer { return getColor(HIGHTRANS_BASE); }
- (UIColor *)snackbarBackground { return getColor(BASE); }
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
- (UIColor *)overlayBackgroundBrand { return getColor(MEDTRANS_BASE); }
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
- (UIColor *)verifiedBadgeBackground { return getColor(SURFACE0); }
- (UIColor *)themedOverlayBackground { return %orig; }
- (UIColor *)adIndicator { return getColor(YELLOW); }
%end

%hook YTMySubsFilterHeaderView
-(void)setElementViews:(id)arg1 {
    NSArray *views = (NSArray*)arg1;
    for (UIView *view in views) {
        UIView *subview = [view.subviews firstObject];
        if (subview) {
            subview.backgroundColor = getColor(BASE);
        }
    }
    %orig;
}
%end

@interface YTWatchView: UIView
@property UIView *watchNextView;
@end

%hook YTWatchView
-(void)didMoveToWindow {
    self.watchNextView.backgroundColor = getColor(BASE);
    %orig;
}
%end

%hook YTCinematicContainerView
-(void)updateGradientLayer {}
-(void)updateGradientColor {}
%end

@interface YTWatchRoundedCornersView: UIView
@property UIColor *backgroundColor;
@end

%hook YTWatchRoundedCornersView
-(void)didMoveToWindow {
    self.backgroundColor = getColor(BASE);
    %orig;
}
%end

%hook ASDisplayNode 
-(void)didLoad {
    if ([self.accessibilityIdentifier isEqualToString:@"dot-decoration-id"]) {
        self.backgroundColor = getColor(ACCENT);
        self.yogaParent.backgroundColor = getColor(SURFACE1);
    }
    %orig;
}
%end

%hook ASTextNode
-(void)didLoad {
    NSString *parentId = self.yogaParent.accessibilityIdentifier;
    NSString *parentParentId = self.yogaParent.yogaParent.accessibilityIdentifier;

    if ([parentId isEqualToString:@"subs_channel_list.all_button"]) {
        NSMutableAttributedString *str = [self.attributedText mutableCopy];
        [str addAttribute:NSForegroundColorAttributeName value:getColor(ACCENT) range:NSMakeRange(0,[str length])];
        self.attributedText = str;
    } else if (
        [parentId isEqualToString:@"channel-bar-channel-id"] ||
        [parentParentId isEqualToString:@"eml.metadata"]
    ) {
        NSMutableAttributedString *str = [self.attributedText mutableCopy];
        [str addAttribute:NSForegroundColorAttributeName value:getColor(TEXT) range:NSMakeRange(0,[str length])];
        self.attributedText = str;
    }
}
%end

%hook YTInlinePlayerBarContainerView
- (id)quietProgressBarColor {
    return getColor(ACCENT);
}
%end

%hook YTSegmentableInlinePlayerBarView
-(void)resetPlayerBarModeColors {
    %orig;
    MSHookIvar<UIColor*>(self, "_progressBarColor") = getColor(ACCENT);
    MSHookIvar<UIColor*>(self, "_userIsScrubbingProgressBarColor") = getColor(ACCENT);
    MSHookIvar<UIColor*>(self, "_bufferedProgressBarColor") = getColor(OVERLAY0);
    MSHookIvar<UIColor*>(self, "_unbufferedProgressBarColor") = getColor(SURFACE1);
    MSHookIvar<UIColor*>(self, "_linearLiveStreamSeekableProgressColor") = getColor(ACCENT);
    MSHookIvar<UIView*>(self, "_scrubberCircle").backgroundColor = getColor(ACCENT);
}
%end

%hook YTProgressView
-(void)setProgressBarColor:(id)arg1 {
    %orig(getColor(ACCENT));
}
%end

%end

void initYoutubeHook() {
    %init(integration_youtube);
}

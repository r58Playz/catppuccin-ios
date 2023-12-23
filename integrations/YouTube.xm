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

%end


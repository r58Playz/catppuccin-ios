#import <substrate.h>
#define HOOK_SWIFT(target, replacement) void target(void); void replacement(void); MSHookFunction(target, replacement, NULL);

void initSwift() {
	HOOK_SWIFT($s7SwiftUI5ColorV06accentC0ACvgZ, $s7SwiftUI5ColorV10catppuccinE06accentC5_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV3redACvgZ, $s7SwiftUI5ColorV10catppuccinE8red_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV4blueACvgZ, $s7SwiftUI5ColorV10catppuccinE9blue_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV4cyanACvgZ, $s7SwiftUI5ColorV10catppuccinE9cyan_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV4grayACvgZ, $s7SwiftUI5ColorV10catppuccinE9gray_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV4mintACvgZ, $s7SwiftUI5ColorV10catppuccinE9mint_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV4pinkACvgZ, $s7SwiftUI5ColorV10catppuccinE9pink_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV4tealACvgZ, $s7SwiftUI5ColorV10catppuccinE9teal_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV5blackACvgZ, $s7SwiftUI5ColorV10catppuccinE10black_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV5brownACvgZ, $s7SwiftUI5ColorV10catppuccinE10brown_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV5greenACvgZ, $s7SwiftUI5ColorV10catppuccinE10green_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV5whiteACvgZ, $s7SwiftUI5ColorV10catppuccinE10white_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV6indigoACvgZ, $s7SwiftUI5ColorV10catppuccinE11indigo_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV6orangeACvgZ, $s7SwiftUI5ColorV10catppuccinE11orange_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV6purpleACvgZ, $s7SwiftUI5ColorV10catppuccinE11purple_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV6yellowACvgZ, $s7SwiftUI5ColorV10catppuccinE11yellow_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV7primaryACvgZ, $s7SwiftUI5ColorV10catppuccinE12primary_hookACvgZ)
	HOOK_SWIFT($s7SwiftUI5ColorV9secondaryACvgZ, $s7SwiftUI5ColorV10catppuccinE14secondary_hookACvgZ)
}

// vim: ft=c

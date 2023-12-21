// vim:ft=objcpp
// https://github.com/Skittyblock/Spectrum/blob/master/Tweak.x#L35-L87
static CGFloat colorComponentFrom(NSString *string, NSInteger start, NSInteger length) {
	NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
	NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
	unsigned hexComponent;
	[[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
	return hexComponent / 255.0;
}

static UIColor *colorFromHexString(NSString *hexString) {
	if (!hexString) return nil;
	CGFloat red, green, blue, alpha;
	switch(hexString.length) {
		case 3: // #RGB
			red = colorComponentFrom(hexString, 0, 1);
			green = colorComponentFrom(hexString, 1, 1);
			blue = colorComponentFrom(hexString, 2, 1);
			alpha = 1;
			break;
		case 4: // #RGBA
			red = colorComponentFrom(hexString, 0, 1);
			green = colorComponentFrom(hexString, 1, 1);
			blue = colorComponentFrom(hexString, 2, 1);
			alpha = colorComponentFrom(hexString, 3, 1);
			break;
		case 6: // #RRGGBB
			red = colorComponentFrom(hexString, 0, 2);
			green = colorComponentFrom(hexString, 2, 2);
			blue = colorComponentFrom(hexString, 4, 2);
			alpha = 1;
			break;
		case 8: // #RRGGBBAA
			red = colorComponentFrom(hexString, 0, 2);
			green = colorComponentFrom(hexString, 2, 2);
			blue = colorComponentFrom(hexString, 4, 2);
			alpha = colorComponentFrom(hexString, 6, 2);
			break;
		default: // Invalid color
			red = 0;
			green = 0;
			blue = 0;
			alpha = 0;
			break;
	}
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

static UIColor *colorFromHexStringWithAlpha(NSString *hexString, double alpha) {
	unsigned rgbValue = 0;
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	[scanner setScanLocation:0];
	[scanner scanHexInt:&rgbValue];
	return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

static NSArray *colorsFromHexStrings(NSArray *colors) {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[colors count]];
    for (id color in colors) {
        [result addObject:[colorFromHexString(color) copy]];
    }
    return result;
}

// https://stackoverflow.com/a/18903483
static UIColor *blend(UIColor* c1, UIColor* c2, float alpha) {
    alpha = MIN(1.f, MAX( 0.f, alpha ));
    float beta = 1.f - alpha;
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [c1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [c2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat r = r1 * beta + r2 * alpha;
    CGFloat g = g1 * beta + g2 * alpha;
    CGFloat b = b1 * beta + b2 * alpha;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

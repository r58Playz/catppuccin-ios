// vim:ft=objcpp

#define ROSEWATER 0
#define FLAMINGO 1
#define PINK 2
#define MAUVE 3
#define RED 4
#define MAROON 5
#define PEACH 6
#define YELLOW 7
#define GREEN 8
#define TEAL 9
#define SKY 10
#define SAPPHIRE 11
#define BLUE 12
#define LAVENDER 13

#define TEXT 14
#define SUBTEXT1 15
#define SUBTEXT0 16
#define OVERLAY2 17
#define OVERLAY1 18
#define OVERLAY0 19
#define SURFACE2 20
#define SURFACE1 21
#define SURFACE0 22
#define BASE 23
#define MANTLE 24
#define CRUST 25
#define ACCENT 26
#define HIGHLIGHT 27
#define BASE_50_ACCENT 28
#define ADAPTIVE_LIGHT 29
#define ADAPTIVE_DARK 30
#define TRANSPARENT 31
#define HIGHTRANS_BASE 32
#define MEDTRANS_BASE 33
#define LOWTRANS_BASE 34
#define HIGHTRANS_TEXT 35
#define MEDTRANS_TEXT 36
#define LOWTRANS_TEXT 37
#define MEDTRANS_OVERLAY0 38
#define LOWTRANS_SURFACE0 39
#define BASE_25_GREEN 40
#define BASE_25_RED 41

static NSArray *flavorFromString(NSString *flavor) {
    if([flavor isEqualToString:@"latte"]) {
        return @[@"dc8a78",@"dd7878",@"ea76cb",@"8839ef",@"d20f39",@"e64553",@"fe640b",@"df8e1d",@"40a02b",@"179299",@"04a5e5",@"209fb5",@"1e66f5",@"7287fd",@"4c4f69",@"5c5f77",@"6c6f85",@"7c7f93",@"8c8fa1",@"9ca0b0",@"acb0be",@"bcc0cc",@"ccd0da",@"eff1f5",@"e6e9ef",@"dce0e8"];
    } else if([flavor isEqualToString:@"frappe"]) {
        return @[@"f2d5cf",@"eebebe",@"f4b8e4",@"ca9ee6",@"e78284",@"ea999c",@"ef9f76",@"e5c890",@"a6d189",@"81c8be",@"99d1db",@"85c1dc",@"8caaee",@"babbf1",@"c6d0f5",@"b5bfe2",@"a5adce",@"949cbb",@"838ba7",@"737994",@"626880",@"51576d",@"414559",@"303446",@"292c3c",@"232634"];
    } else if([flavor isEqualToString:@"macchiato"]) {
        return @[@"f4dbd6",@"f0c6c6",@"f5bde6",@"c6a0f6",@"ed8796",@"ee99a0",@"f5a97f",@"eed49f",@"a6da95",@"8bd5ca",@"91d7e3",@"7dc4e4",@"8aadf4",@"b7bdf8",@"cad3f5",@"b8c0e0",@"a5adcb",@"939ab7",@"8087a2",@"6e738d",@"5b6078",@"494d64",@"363a4f",@"24273a",@"1e2030",@"181926"];
    }

    return @[@"f5e0dc",@"f2cdcd",@"f5c2e7",@"cba6f7",@"f38ba8",@"eba0ac",@"fab387",@"f9e2af",@"a6e3a1",@"94e2d5",@"89dceb",@"74c7ec",@"89b4fa",@"b4befe",@"cdd6f4",@"bac2de",@"a6adc8",@"9399b2",@"7f849c",@"6c7086",@"585b70",@"45475a",@"313244",@"1e1e2e",@"181825",@"11111b"];
}

static int accentFromString(NSString *color) {
    if([color isEqualToString:@"rosewater"]) {
        return ROSEWATER;
    } else if([color isEqualToString:@"flamingo"]) {
        return FLAMINGO;
    } else if([color isEqualToString:@"pink"]) {
        return PINK;
    } else if([color isEqualToString:@"mauve"]) {
        return MAUVE;
    } else if([color isEqualToString:@"red"]) {
        return RED;
    } else if([color isEqualToString:@"maroon"]) {
        return MAROON;
    } else if([color isEqualToString:@"peach"]) {
        return PEACH;
    } else if([color isEqualToString:@"yellow"]) {
        return YELLOW;
    } else if([color isEqualToString:@"teal"]) {
        return TEAL;
    } else if([color isEqualToString:@"sky"]) {
        return SKY;
    } else if([color isEqualToString:@"sapphire"]) {
        return SAPPHIRE;
    } else if([color isEqualToString:@"blue"]) {
        return BLUE;
    } else if([color isEqualToString:@"lavender"]) {
        return LAVENDER;
    }
    return MAUVE;
}

static UIColor *getColor(int idx) {
    UIColor *color;
    // stopwatch view
    NSArray *weirdApps = @[@"MobileTimer"];
    switch(idx) {
        case ACCENT:
            color = accent;
            break;
        case HIGHLIGHT:
            color = highlight;
            break;
        case BASE_50_ACCENT:
            color = blend(colors[BASE],accent,0.5);
            break;
        case ADAPTIVE_LIGHT:
            if ([pref_flavor isEqualToString:@"latte"] && ![weirdApps containsObject:PROCESS_NAME]) {
                color = colors[BASE];
            } else {
                color = colors[TEXT];
            }
            break;
        case ADAPTIVE_DARK:
            if ([pref_flavor isEqualToString:@"latte"] && ![weirdApps containsObject:PROCESS_NAME]) {
                color = colors[TEXT];
            } else {
                color = colors[BASE];
            }
            break;
        case HIGHTRANS_BASE:
            color = [colors[BASE] colorWithAlphaComponent:0.3];
            break;
        case MEDTRANS_BASE:
            color = [colors[BASE] colorWithAlphaComponent:0.5];
            break;
        case LOWTRANS_BASE:
            color = [colors[BASE] colorWithAlphaComponent:0.7];
            break;
        case HIGHTRANS_TEXT:
            color = [colors[TEXT] colorWithAlphaComponent:0.3];
            break;
        case MEDTRANS_TEXT:
            color = [colors[TEXT] colorWithAlphaComponent:0.5];
            break;
        case LOWTRANS_TEXT:
            color = [colors[TEXT] colorWithAlphaComponent:0.7];
            break;
        case MEDTRANS_OVERLAY0:
            color = [colors[OVERLAY0] colorWithAlphaComponent:0.5];
            break;
        case LOWTRANS_SURFACE0:
            color = [colors[SURFACE0] colorWithAlphaComponent:0.7];
            break;
        case BASE_25_GREEN:
            color = blend(colors[BASE],colors[GREEN],0.5);
            break;
        case BASE_25_RED:
            color = blend(colors[BASE],colors[GREEN],0.5);
            break;
        case TRANSPARENT:
            color = [UIColor colorWithWhite:0.0 alpha:0.0];
            break;
        default:
            color = colors[idx];
            break;
    }
    return color;
}

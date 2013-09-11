//
//  NSAttributedStringBuilder.m
//  Redro
//
//  Created by jeffrey chen on 2013-06-20.
//

#import "NSAttributedStringBuilder.h"

@implementation NSAttributedStringBuilder

- (id)init
{
    self = [super init];
    if (self) {
        fullTexts = [[NSMutableArray alloc] init];
        attributes = [[NSMutableArray alloc] init];
        length = 0;
        spacing = -1;
    }
    return self;
}

- (id)initWithDefaultAttributeFont:(UIFont *)font andColor:(UIColor *)color
{
    if ([self init]) {
        [self setDefaultAttributeFont:font andColor:color];
    }
    return self;
}

- (void)setDefaultAttributeFont:(UIFont *)font andColor:(UIColor *)color
{
    defaultFont = font;
    defaultColor = color;
}

- (NSAttributedStringBuilder *)addNewLine
{
    static NSString *line = @"\n";
    return [self addText:line withFont:nil andColor:nil];
}

- (NSAttributedStringBuilder *)addNewLineIfNotEmpty:(NSString *)text withFont:(UIFont *)font andColor:(UIColor *)color
{
    if ([text length] == 0) return self;
    
    text = [NSString stringWithFormat:@"%@\n", text];
    return [self addText:text withFont:font andColor:color];
}

- (NSAttributedStringBuilder *)addNewLine:(NSString *)text withFont:(UIFont *)font andColor:(UIColor *)color
{
    if ([text length] == 0) {
        return [self addNewLine];
    } else {
        text = [NSString stringWithFormat:@"%@\n", text];
        return [self addText:text withFont:font andColor:color];
    }
}

- (NSAttributedStringBuilder *)addText:(NSString *)text withFont:(UIFont *)font andColor:(UIColor *)color
{
    if ([text length] == 0) return self;
    
    NSRange range = NSMakeRange(length, text.length);
    NSValue *rangeValue = [NSValue valueWithRange:range];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:rangeValue forKey:@"range"];
    if (font) {
        [dict setObject:font forKey:@"font"];
    }
    if (color) {
        [dict setObject:color forKey:@"color"];
    }
    [attributes addObject:dict];
    
    [fullTexts addObject:text];
    length += text.length;
    
    return self;
}

- (NSAttributedString *)makeAttributedString
{
    NSString *fullString = [fullTexts componentsJoinedByString:@""];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:fullString];
    for (NSDictionary *dict in attributes) {
        NSRange range = [[dict objectForKey:@"range"] rangeValue];
        if ([dict objectForKey:@"font"]) {
            [attrString addAttribute:NSFontAttributeName value:[dict objectForKey:@"font"] range:range];
        } else if (defaultFont) {
            [attrString addAttribute:NSFontAttributeName value:defaultFont range:range];
        }
        if ([dict objectForKey:@"color"]) {
            [attrString addAttribute:NSForegroundColorAttributeName value:[dict objectForKey:@"color"] range:range];
        } else if (defaultColor) {
            [attrString addAttribute:NSForegroundColorAttributeName value:defaultColor range:range];
        }
    }
    
    if (spacing != -1) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:spacing];
        [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, length)];
    }

    return attrString;
}

- (void)setLineSpacing:(int)lineSpacing
{
    if (lineSpacing > 0) {
        spacing = lineSpacing;
    } else {
        lineSpacing = -1;
    }
}

@end

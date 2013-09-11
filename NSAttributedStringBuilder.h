//
//  NSAttributedStringBuilder.h
//  Redro
//
//  Created by jeffrey chen on 2013-06-20.
//

#import <Foundation/Foundation.h>

@interface NSAttributedStringBuilder : NSObject
{
    NSMutableArray *fullTexts;
    NSMutableArray *attributes;
    int length;
    UIFont *defaultFont;
    UIColor *defaultColor;
    int spacing;
}

- (id)initWithDefaultAttributeFont:(UIFont *)font andColor:(UIColor *)color;
- (void)setDefaultAttributeFont:(UIFont *)font andColor:(UIColor *)color;
- (NSAttributedStringBuilder *)addNewLine;
- (NSAttributedStringBuilder *)addNewLineIfNotEmpty:(NSString *)text withFont:(UIFont *)font andColor:(UIColor *)color;
- (NSAttributedStringBuilder *)addNewLine:(NSString *)text withFont:(UIFont *)font andColor:(UIColor *)color;
- (NSAttributedStringBuilder *)addText:(NSString *)text withFont:(UIFont *)font andColor:(UIColor *)color;
- (NSAttributedString *)makeAttributedString;
- (void)setLineSpacing:(int)lineSpacing;

@end

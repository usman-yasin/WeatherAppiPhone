

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject


+(void) setBorderColor:(UIColor*)color borderWidth:(CGFloat)borderWidth radius:(CGFloat)radius andTranslationX:(int)translationX ofView:(UIView*)view;
+(NSString*)uniqueString;
+(void)showAlertWithMessage:(NSString*)message;
+(void)showAlertWithMessage:(NSString*)message AndTitle:(NSString*)title;
+(void)showAlertWithMessage:(NSString*)message AndTitle:(NSString*)title delegate:(id)delegate cancelButtonTitle:(NSString *)title1 otherButtonTitle:(NSString *)title2;
+(void)showAlertWithMessage:(NSString*)message AndTitle:(NSString*)title delegate:(id)delegate cancelButtonTitle:(NSString *)title1 otherButtonTitle:(NSString *)title2 tag:(NSInteger)tag;
+(void)deleteFile:(NSString*)filePath;
+(BOOL)fileExists:(NSString*)filePath;
+(BOOL)moveFile:(NSString*)sourceFilePath destination:(NSString*)destinationFilePath;
+(NSString*)documentDirectory;
+(NSString*)filePathWithDocumentDirectory:(NSString*)fileName;
+(NSString*)filePathWithBundle:(NSString*)fileName;
+(NSString*)performAccelaEncoding:(NSString*)text;

@end


static inline NSMutableString *filteredPhoneStringFromStringWithFilter(NSString *string, NSString *filter)
{
    NSUInteger onOriginal = 0, onFilter = 0, onOutput = 0;
    char outputString[([filter length])];
    BOOL done = NO;
    
    while(onFilter < [filter length] && !done)
    {
        char filterChar = [filter characterAtIndex:onFilter];
        char originalChar = onOriginal >= string.length ? '\0' : [string characterAtIndex:onOriginal];
        switch (filterChar) {
            case '#':
                if(originalChar=='\0')
                {
                    // We have no more input numbers for the filter.  We're done.
                    done = YES;
                    break;
                }
                if(isdigit(originalChar))
                {
                    outputString[onOutput] = originalChar;
                    onOriginal++;
                    onFilter++;
                    onOutput++;
                }
                else
                {
                    onOriginal++;
                }
                break;
            default:
                // Any other character will automatically be inserted for the user as they type (spaces, - etc..) or deleted as they delete if there are more numbers to come.
                outputString[onOutput] = filterChar;
                onOutput++;
                onFilter++;
                if(originalChar == filterChar)
                    onOriginal++;
                break;
        }
    }
    outputString[onOutput] = '\0'; // Cap the output string
    return [NSString stringWithUTF8String:outputString];
}


static inline NSString *NSStringFromInt(int i)
{
    return [NSString stringWithFormat:@"%d", i];
}
static inline NSString *NSStringFromUInt(NSUInteger i)
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)i];
}
static inline NSString *NSStringFromNumber(NSNumber *number)
{
    if(number == nil)
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%d", [number intValue]];
}
static inline NSString *NSStringFromDouble(double value)
{
    return [NSString stringWithFormat:@"%lf", value];
}



#import "Utility.h"


@implementation Utility

+(void) setBorderColor:(UIColor*)color borderWidth:(CGFloat)borderWidth radius:(CGFloat)radius andTranslationX:(int)translationX ofView:(UIView*)view
{
    view.layer.borderColor= color.CGColor;
    view.layer.cornerRadius = 0.0;
    view.layer.borderWidth = 1.0f;
    view.layer.sublayerTransform = CATransform3DMakeTranslation(translationX, 0, 0);
}

+(NSString*)uniqueString
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return [(NSString *)uuidStr autorelease];
}
+(void)showAlertWithMessage:(NSString*)message
{
    [self showAlertWithMessage:message AndTitle:nil];
}
+(void)showAlertWithMessage:(NSString*)message AndTitle:(NSString*)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}
+(void)showAlertWithMessage:(NSString*)message AndTitle:(NSString*)title delegate:(id)delegate cancelButtonTitle:(NSString *)title1 otherButtonTitle:(NSString *)title2
{
    [Utility showAlertWithMessage:message AndTitle:title delegate:delegate cancelButtonTitle:title1 otherButtonTitle:title2 tag:-1];
}
+(void)showAlertWithMessage:(NSString*)message AndTitle:(NSString*)title delegate:(id)delegate cancelButtonTitle:(NSString *)title1 otherButtonTitle:(NSString *)title2 tag:(NSInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:title1
                                              otherButtonTitles:title2, nil];
    alertView.tag = tag;
    [alertView show];
    [alertView release];
}
+(void)deleteFile:(NSString*)filePath
{
    NSError *error = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath])
    {
        [fileManager removeItemAtPath:filePath error:&error];
    }
}
+(BOOL)fileExists:(NSString*)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}
+(BOOL)moveFile:(NSString*)sourceFilePath destination:(NSString*)destinationFilePath
{
    NSError *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:sourceFilePath])
    {
        return NO;
    }
    
    if([fileManager fileExistsAtPath:destinationFilePath])
    {
        [fileManager removeItemAtPath:destinationFilePath error:nil];
    }

    if ([fileManager moveItemAtPath:sourceFilePath toPath:destinationFilePath error:&error] != YES)
    {
        NSLog(@"Unable to move file: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
}
+(NSString*)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return (NSString*)[paths objectAtIndex:0];
}
+(NSString*)filePathWithDocumentDirectory:(NSString*)fileName
{
    return [[Utility documentDirectory] stringByAppendingPathComponent:fileName];
}
+(NSString*)filePathWithBundle:(NSString*)fileName
{
    NSString* theFileName = [[fileName lastPathComponent] stringByDeletingPathExtension];
    return [[NSBundle mainBundle] pathForResource:theFileName ofType:[fileName pathExtension]];
}

+(NSString*)performAccelaEncoding:(NSString*)text
{
    NSString* theFileName = [[text lastPathComponent] stringByDeletingPathExtension];
    return [[NSBundle mainBundle] pathForResource:theFileName ofType:[text pathExtension]];
}

@end

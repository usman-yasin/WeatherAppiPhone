#import "NSStringAddition.h"
#import <MobileCoreServices/MobileCoreServices.h>


@implementation NSString (Empty)


+ (BOOL)isEmpty:(NSString*)string 
{	
	return string == nil || string.length == 0;	
}
+ (NSString*)trim:(NSString*)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+ (BOOL)isValidEmailAddress:(NSString*)email
{	
    email = [email lowercaseString];

	//NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
	NSString *emailRegEx =
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx]; 
	return [emailTest evaluateWithObject:email];
}
+ (BOOL)isValidWebURL:(NSString*)webURL
{
    webURL = [webURL lowercaseString];
    if([webURL hasPrefix:@"https://"] == NO && [webURL hasPrefix:@"http://"] == NO)
        webURL = [NSString stringWithFormat:@"http://%@", webURL];

    NSURL *candidateURL = [NSURL URLWithString:webURL];
    // WARNING > "test" is an URL according to RFCs, being just a path
    // so you still should check scheme and all other NSURL attributes you need
    if (candidateURL && candidateURL.scheme && candidateURL.host) {
        // candidate is a well-formed url with:
        //  - a scheme (like http://)
        //  - a host (like stackoverflow.com)
        
        return YES;
    }

    return NO;
}
+ (NSString*)stringWithoutCharacterEscapes:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@"\\'" withString:@"\'"];
    string = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    return string;
}

+(BOOL)isNumeric:(NSString*)string
{
    if (string.length == 0)
    {
        return YES;
    }
    
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    if([string rangeOfCharacterFromSet:myCharSet].location == NSNotFound)
    {
        return NO;
    }
    
    /* limit to only numeric characters - Just for Pasting */
    for (int i = 0; i < [string length]; i++)
    {
        unichar c = [string characterAtIndex:i];
        if ([myCharSet characterIsMember:c] == NO)
        {
            return NO;
        }
    }

    return YES;
//    NSCharacterSet *charcter =[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
//    NSString *filtered;
//    filtered = [[inputString componentsSeparatedByCharactersInSet:charcter] componentsJoinedByString:@""];
//    return [inputString isEqualToString:filtered];
}

+ (BOOL)isValidPhoneNumber2:(NSString*)phone
{
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    
    NSRange inputRange = NSMakeRange(0, [phone length]);
    NSArray *matches = [detector matchesInString:phone options:0 range:inputRange];
    
    // no match at all
    if ([matches count] == 0)
    {
        return NO;
    }
    
    // found match but we need to check if it matched the whole string
    NSTextCheckingResult *result = (NSTextCheckingResult *)[matches objectAtIndex:0];
    
    if ([result resultType] == NSTextCheckingTypePhoneNumber && result.range.location == inputRange.location && result.range.length == inputRange.length)
    {
        // it matched the whole string
        return YES;
    }
    else
    {
        // it only matched partial string
        return NO;
    }
}
+(BOOL)isValidPhoneNumber:(NSString*)inputString
{
    BOOL status = [NSString isValidPhoneNumber2:inputString];
    if(status == NO)
    {
        return status;
    }
    
    NSCharacterSet *charcter =[[NSCharacterSet characterSetWithCharactersInString:@"+-()0123456789"] invertedSet];
    NSString *filtered;
    filtered = [[inputString componentsSeparatedByCharactersInSet:charcter] componentsJoinedByString:@""];
    status = [inputString isEqualToString:filtered];
    if(status == NO)
    {
        return status;
    }
    
    if(inputString.length > 13)
    {
        return NO;
    }
    
    return status;
}


+ (NSString*)stringToAvoidNameCollisionForPath:(NSString*)path
{
    // raise an exception for invalid paths
    if (path == nil || [path length] == 0)
    {
        [NSException raise:@"DMStringUtilsException" format:@"Invalid path"];
    }
    
    NSFileManager *manager = [[[NSFileManager alloc] init] autorelease];
    BOOL isDirectory;
    
    // file does not exist, so the path doesn't need to change
    if (![manager fileExistsAtPath:path isDirectory:&isDirectory])
    {
        return path;
    }
    
    NSString *lastComponent = [path lastPathComponent];
    NSString *fileName = isDirectory ? lastComponent : [lastComponent stringByDeletingPathExtension];
    NSString *ext = isDirectory ? @"" : [NSString stringWithFormat:@".%@", [path pathExtension]];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"-([0-9]{1,})$" options:0 error:nil];
    NSArray *matches = [regex matchesInString:fileName options:0 range:NSMakeRange(0, [fileName length])];
//    NSArray *matches = [regex matchesInString:fileName options:0 range:STRING_RANGE(fileName)];

    // missing suffix... start from 1 (foo-1.ext)
    if ([matches count] == 0)
    {
        return [NSString stringWithFormat:@"%@-1%@", fileName, ext];
    }
    
    // get last match (theoretically the only one due to "$" in the regex)
    NSTextCheckingResult *result = (NSTextCheckingResult *)[matches lastObject];
    
    // extract suffix value
    NSUInteger counterValue = [[fileName substringWithRange:[result rangeAtIndex:1]] integerValue];
    
    // remove old suffix from the string
    NSString *fileNameNoSuffix = [fileName stringByReplacingCharactersInRange:[result rangeAtIndex:0] withString:@""];
    
    // return the path with the incremented counter suffix
    return [NSString stringWithFormat:@"%@-%lu%@", fileNameNoSuffix, counterValue + 1, ext];
}
+ (NSString *)mimeTypeForData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c)
    {
        case 0xFF:
            return @"image/jpeg";
            break;
        case 0x89:
            return @"image/png";
            break;
        case 0x47:
            return @"image/gif";
            break;
        case 0x49:
        case 0x4D:
            return @"image/tiff";
            break;
        case 0x25:
            return @"application/pdf";
            break;
        case 0xD0:
            return @"application/vnd";
            break;
        case 0x46:
            return @"text/plain";
            break;
        default:
            return @"application/octet-stream";
    }
    return nil;
}
+ (NSString *)fileExtensionForData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c)
    {
        case 0xFF:
            return @"jpeg";
            break;
        case 0x89:
            return @"png";
            break;
        case 0x47:
            return @"gif";
            break;
        case 0x49:
        case 0x4D:
            return @"tiff";
            break;
        case 0x25:
            return @"pdf";
            break;
        case 0xD0:
            return @"vnd";
            break;
        case 0x46:
            return @"txt";
            break;
        default:
            return @"oct";
    }
    return @"";
}


- (void)trim
{
    self = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSInteger)countOccurencesOfString:(NSString*)searchString
{
    NSArray * portions = [self componentsSeparatedByString:searchString];
    return [portions count] - 1;
    
//    NSInteger strCount = [self length] - [[self stringByReplacingOccurrencesOfString:searchString withString:@""] length];
//    return strCount / [searchString length];
}


-(NSString*)filename
{
//    return [[[NSFileManager defaultManager] displayNameAtPath:self] stringByDeletingPathExtension];
    return [[self lastPathComponent] stringByDeletingPathExtension];
}
-(NSString*)fileExtension
{
    return [self pathExtension];
}
- (NSString *)mimeTypeForPath
{
    // get a mime type for an extension using MobileCoreServices.framework
    CFStringRef extension = (__bridge CFStringRef)[self pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);
    
    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);
    
    CFRelease(UTI);
    
    return mimetype;
}


@end
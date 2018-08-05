
#import <Foundation/Foundation.h>

@interface NSString (Empty)

+ (BOOL)isEmpty:(NSString*)string;
+ (NSString*)trim:(NSString*)string;
+ (BOOL)isValidEmailAddress:(NSString*)email;
+ (BOOL)isValidWebURL:(NSString*)webURL;
+ (NSString*)stringWithoutCharacterEscapes:(NSString*)string;

+(BOOL)isNumeric:(NSString*)inputString;
+ (BOOL)isValidPhoneNumber:(NSString*)inputString;



+ (NSString*)stringToAvoidNameCollisionForPath:(NSString*)path;

- (void)trim;
- (NSInteger)countOccurencesOfString:(NSString*)searchString;

-(NSString*)filename;
-(NSString*)fileExtension;
-(NSString*)mimeTypeForPath;


@end
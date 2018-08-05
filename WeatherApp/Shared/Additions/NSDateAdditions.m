/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "NSDateAdditions.h"
#import "NSStringAddition.h"

@implementation NSDate (NSDateAdditions)

- (NSDate *)cc_dateByMovingToBeginningOfDay
{
  unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
  NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
  [parts setHour:0];
  [parts setMinute:0];
  [parts setSecond:0];
  return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingToBeginingOfHour
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setMinute:0];
    [parts setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingToEndOfDay
{
  unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
  NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
  [parts setHour:23];
  [parts setMinute:59];
  [parts setSecond:59];
  return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingToFirstDayOfTheMonth
{
  NSDate *d = nil;
  BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&d interval:NULL forDate:self];
  NSAssert1(ok, @"Failed to calculate the first day the month based on %@", self);
  return d;
}
- (NSDate *)cc_dateByMovingToFirstDayOfThePreviousMonth
{
  NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
  c.month = -1;
  return [[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0] cc_dateByMovingToFirstDayOfTheMonth];  
}
- (NSDate *)cc_dateByMovingToFirstDayOfTheFollowingMonth
{
  NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
  c.month = 1;
  return [[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0] cc_dateByMovingToFirstDayOfTheMonth];
}
- (NSDateComponents *)cc_componentsForMonthDayAndYear
{
  return [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
}
- (NSUInteger)cc_year
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    return [parts year];
}
- (NSUInteger)cc_weekday
{
  return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
}
- (NSUInteger)cc_numberOfDaysInMonth
{
  return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}
- (NSDate *)cc_dateByMovingOneHourForward
{
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
	[parts setHour:[parts hour]+1];
	[parts setMinute:0];
	[parts setSecond:0];
	return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingOneHourBack
{
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
	[parts setHour:[parts hour]-1];
	[parts setMinute:0];
	[parts setSecond:0];
	return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingPreviousDay
{
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
	[parts setDay:([parts day] - 1)];
	[parts setHour:0];
	[parts setMinute:0];
	[parts setSecond:0];
	return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingDays:(NSInteger)days
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
	[parts setDay:([parts day] + days)];
	[parts setHour:0];
	[parts setMinute:0];
	[parts setSecond:0];
	return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingThreeDaysBack
{
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
	[parts setDay:([parts day] - 3)];
	[parts setHour:0];
	[parts setMinute:0];
	[parts setSecond:0];
	return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingHourForward:(int)hours
{
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
	[parts setHour:[parts hour]+hours];
	return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingMinutesForward:(int)minutes
{
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
	[parts setMinute:[parts minute]+minutes];
	return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingForwardHours:(int)hours andMinutes:(int)minutes
{
	unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:[parts hour]+hours];
	[parts setMinute:[parts minute]+minutes];
	return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateBySetdHours:(int)hours andMinutes:(int)minutes
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:hours];
    [parts setMinute:minutes];
    [parts setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingNextDay
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setDay:([parts day] + 1)];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}
- (NSDate *)cc_dateByMovingNextYear
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setYear:([parts year] + 1)];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSInteger)cc_dateHours
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    return parts.hour;
}
- (NSInteger)cc_dateMinutes
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    return parts.minute;
}

- (NSString*)dateForBackendRequestFormat
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-dd-MM"];
	NSString *date = [dateFormatter stringFromDate:self];
	[dateFormatter release];
	return date;
}


#pragma mark - Misc Functions
+(NSDate*)dateFromString:(NSString*)dateInString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *date = [format dateFromString:dateInString];
	[format release];
	return date;
}
+(NSString*)timeInStringFromDate:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    if([NSDate is24HourFormat])
        [format setDateFormat:@"HH:mm"];
    else
        [format setDateFormat:@"hh:mma"];

	NSString *time = [format stringFromDate:date];
	[format release];
	return time;
}
+(NSString*)dateInStringFromDate:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEE, MMM dd yyyy"];
	NSString *time = [format stringFromDate:date];
	[format release];
	return time;
}
+(NSString*)dateInStringFromDate:(NSDate *)date withFormat:(NSString*)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
	NSString *time = [formatter stringFromDate:date];
	[formatter release];
	return time;
}
+(NSDate*)dateTimeFromString:(NSString *)date withFormat:(NSString*)format
{
    if([NSString isEmpty:date])
    {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *returnDate = [formatter dateFromString:date];
    [formatter release];
    return returnDate;
}


+(BOOL)is24HourFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24h = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
    [formatter release];
    return is24h;
}
+(NSString*)dateFormat:(NSString*)dateFormat
{
    if([NSDate is24HourFormat]) return dateFormat;
    
    return [NSString stringWithFormat:@"%@ a", dateFormat];
}
+(NSString*)todayDateInString
{
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:[NSDate dateFormat:@"yyyyMMdd"]];
	NSString *dateString = [format stringFromDate:[NSDate date]];
	[format release];
	return dateString;
}
+(NSString*)timeInString:(int)timeInSeconds 
{
	NSString *min = @"";
	NSString *sec = @"";
	if(timeInSeconds/60 > 0)
		min = [NSString stringWithFormat:@"%dmin", timeInSeconds/60];
	if(timeInSeconds%60 > 0)
		sec = [NSString stringWithFormat:@"%.2dsec", timeInSeconds%60];
	
	return [NSString stringWithFormat:@"%@ %@", min, sec];
}
+(NSString*)dateInString:(NSTimeInterval)dateInSeconds 
{
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:[NSDate dateFormat:@"EEEE MMMM d, yyyy hh:mm"]];
	NSString *dateString = [format stringFromDate:[NSDate dateWithTimeIntervalSince1970:dateInSeconds]];
	[format release];
	return dateString;
}
+(NSString*)dateInStringForJSONSubmit:(NSDate*)date
{
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"M/d/yyyy hh:mm"];
	NSString *dateString = [format stringFromDate:date];
	[format release];
	return dateString;
}
+(NSString*)announcementDateInString:(NSDate*)date
{
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:[NSDate dateFormat:@"EEEE d MMM yyyy, hh:mm"]];
	NSString *dateString = [format stringFromDate:date];
	[format release];
	return dateString;
}
+(NSString*)eventDateRangeInString:(NSDate*)startDate to:(NSDate*)endDate
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* partsStart = [[NSCalendar currentCalendar] components:flags fromDate:startDate];
    NSDateComponents* partsEnd = [[NSCalendar currentCalendar] components:flags fromDate:endDate];
    
    
    if([partsStart year] != [partsEnd year])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
        
        NSString *dateStartString = [dateFormatter stringFromDate:startDate];
        NSString *dateEndString = [dateFormatter stringFromDate:endDate];
        
        [dateFormatter release];
        
        return [NSString stringWithFormat:@"%@ to %@", dateStartString, dateEndString];
    }
    
    
    if([partsStart month] != [partsEnd month])
    {
        NSDateFormatter *dateFormatterStart = [[NSDateFormatter alloc] init];
        [dateFormatterStart setDateFormat:@"dd MMM"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
        
        NSString *dateStartString = [dateFormatterStart stringFromDate:startDate];
        NSString *dateEndString = [dateFormatter stringFromDate:endDate];
        
        [dateFormatterStart release];
        [dateFormatter release];
        
        return [NSString stringWithFormat:@"%@ to %@", dateStartString, dateEndString];
    }
    
    
    if([partsStart day] != [partsEnd day])
    {
        NSDateFormatter *dateFormatterStart = [[NSDateFormatter alloc] init];
        [dateFormatterStart setDateFormat:@"dd"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
        
        NSString *dateStartString = [dateFormatterStart stringFromDate:startDate];
        NSString *dateEndString = [dateFormatter stringFromDate:endDate];
        
        [dateFormatterStart release];
        [dateFormatter release];
        
        return [NSString stringWithFormat:@"%@ to %@", dateStartString, dateEndString];
    }
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSString *dateStartString = [dateFormatter stringFromDate:startDate];
    [dateFormatter release];
    
    return dateStartString;
}
+(NSString*)eventStartDateInString:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:[NSDate dateFormat:@"EEEE MMM d, yyyy hh:mm"]];
	NSString *dateString = [format stringFromDate:date];
	[format release];
	return dateString;
}
+(NSString*)eventEndDateInString:(NSDate*)startDate and:(NSDate*)endDate
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents* partsStart = [[NSCalendar currentCalendar] components:flags fromDate:startDate];
    NSDateComponents* partsEnd = [[NSCalendar currentCalendar] components:flags fromDate:endDate];
    
    
    if([partsStart year] != [partsEnd year] || [partsStart month] != [partsEnd month] || [partsStart day] != [partsEnd day])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:[NSDate dateFormat:@"EEEE MMM d, yyyy hh:mm"]];
        
        NSString *dateEndString = [dateFormatter stringFromDate:endDate];
        
        [dateFormatter release];
        
        return dateEndString;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:[NSDate dateFormat:@"hh:mm"]];
    NSString *dateStartString = [dateFormatter stringFromDate:endDate];
    [dateFormatter release];

    return dateStartString;    
}
+ (NSString*)notificationStringFromDate:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat: @"EEE, yyyy-MM-d H:m"];
    NSString *stringDate = [format stringFromDate:date];
    [format release];
    return stringDate;
}
-(BOOL)isBetweenStartDate:(NSDate*)dateStart endDate:(NSDate *)dateEnd
{
	if ([self compare:dateEnd] == NSOrderedDescending)
		return NO;
	
	if ([self compare:dateStart] == NSOrderedAscending)
		return NO;
	
	return YES;
}


@end

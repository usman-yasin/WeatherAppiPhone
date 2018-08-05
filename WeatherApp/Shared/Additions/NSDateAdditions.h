/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <Foundation/Foundation.h>


@interface NSDate (NSDateAdditions)

// All of the following methods use [NSCalendar currentCalendar] to perform
// their calculations.

- (NSDate *)cc_dateByMovingToBeginningOfDay;
- (NSDate *)cc_dateByMovingToBeginingOfHour;
- (NSDate *)cc_dateByMovingToEndOfDay;
- (NSDate *)cc_dateByMovingToFirstDayOfTheMonth;
- (NSDate *)cc_dateByMovingToFirstDayOfThePreviousMonth;
- (NSDate *)cc_dateByMovingToFirstDayOfTheFollowingMonth;
- (NSDateComponents *)cc_componentsForMonthDayAndYear;
- (NSUInteger)cc_year;
- (NSUInteger)cc_weekday;
- (NSUInteger)cc_numberOfDaysInMonth;

- (NSDate *)cc_dateByMovingOneHourForward;
- (NSDate *)cc_dateByMovingOneHourBack;
- (NSDate *)cc_dateByMovingDays:(NSInteger)days;
- (NSDate *)cc_dateByMovingThreeDaysBack;
- (NSDate *)cc_dateByMovingPreviousDay;
- (NSDate *)cc_dateByMovingHourForward:(int)hours;
- (NSDate *)cc_dateByMovingMinutesForward:(int)minutes;
- (NSDate *)cc_dateByMovingForwardHours:(int)hours andMinutes:(int)minutes;
- (NSDate *)cc_dateByMovingNextDay;
- (NSDate *)cc_dateBySetdHours:(int)hours andMinutes:(int)minutes;

- (NSInteger)cc_dateHours;
- (NSInteger)cc_dateMinutes;

- (NSString*)dateForBackendRequestFormat;

+(NSDate*)dateFromString:(NSString*)dateInString;
+(NSString*)timeInStringFromDate:(NSDate*)date;
+(NSString*)dateInStringFromDate:(NSDate*)date;
+(NSString*)dateInStringFromDate:(NSDate *)date withFormat:(NSString*)format;
+(NSDate*)dateTimeFromString:(NSString *)date withFormat:(NSString*)format;


+(NSString*)dateFormat:(NSString*)dateFormat;
+(BOOL)is24HourFormat;
+(NSString*)timeInString:(int)time;
+(NSString*)dateInString:(NSTimeInterval)dateInSeconds;
+(NSString*)dateInStringForJSONSubmit:(NSDate*)date;
+(NSString*)announcementDateInString:(NSDate*)date;
+(NSString*)todayDateInString;
+(NSString*)eventDateRangeInString:(NSDate*)startDate to:(NSDate*)endDate;
+(NSString*)eventStartDateInString:(NSDate*)date;
+(NSString*)eventEndDateInString:(NSDate*)startDate and:(NSDate*)endDate;
+(NSString*)notificationStringFromDate:(NSDate*)date;

-(BOOL)isBetweenStartDate:(NSDate*)dateStart endDate:(NSDate *)dateEnd;


@end
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const kResponseDictionaryImageUrlKey;
static NSString *const kResponseDictionaryDateKey;
static NSString *const kResponseDictionaryTitleKey;
static NSString *const kResponseDictionaryDescriptionKey;

// Fetches data from NASA using public APIs.
@interface ApodDataFetcher: NSObject

// Fetch picture of the day for selected date.
+ (void)fetchAPOFForDate:(nullable NSDate *)date completion:(void (^)(NSString *imageURL, NSString *title, NSString *description))completion;

// Fetch multiple pictures for a set of dates.
+ (void)fetchAPOFForStartDate:(nullable NSDate *)startDate endDate:(NSDate *)endDate completion:(void (^)(NSArray<NSDictionary *> *responses))completion;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

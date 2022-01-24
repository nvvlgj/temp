#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Displays the Astronomy pictures marked as "Favourite".
@interface FavouritesCollectionViewController: UIViewController

- (instancetype)initWithResponseData:(NSArray *)responseData;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

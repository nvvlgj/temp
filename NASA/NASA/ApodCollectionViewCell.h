#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Collection view cell used to display Astronomy pictures marked as fovourite.
@interface ApodCollectionViewCell: UICollectionViewCell

- (void)setImageFromUrl:(NSString *)url date:(NSString *)date title:(NSString *)title description:(NSString *)description ;

@end

NS_ASSUME_NONNULL_END


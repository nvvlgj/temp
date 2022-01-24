#import "ApodCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApodCollectionViewCell ()

// stackView is used as a content view that holds image, description, title and date.
@property(nonatomic) UIStackView *stackView;
@property(nonatomic) UIImageView *imageView;
@property(nonatomic) UIView *dividerView;
@property(nonatomic) UITextView *imageDescription;
@property(nonatomic) UILabel *imageTitleLabel;
@property(nonatomic) UILabel *dateLabel;

@end

@implementation ApodCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _stackView = [[UIStackView alloc] init];
        _imageView = [[UIImageView alloc] init];
        _dividerView = [[UIView alloc] init];
        _dateLabel = [[UILabel alloc] init];
        _imageTitleLabel = [[UILabel alloc] init];
        _imageDescription = [[UITextView alloc] init];
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [_dateLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    _imageTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_imageTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    
    _imageDescription.textContainerInset = UIEdgeInsetsMake(0, 2, 0, 2);
    _imageDescription.scrollEnabled = NO;
    _imageDescription.editable = NO;
    _imageDescription.selectable = NO;
    _imageDescription.font = [UIFont fontWithName:_imageDescription.font.fontName size:15];
    _imageDescription.textAlignment = NSTextAlignmentJustified;
    _imageDescription.text = @"Sample text";
    
    _dividerView.backgroundColor = UIColor.blackColor;
    
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.distribution = UIStackViewDistributionFill;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.spacing = 10.0;
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [_stackView addArrangedSubview:_imageView];
    [_stackView addArrangedSubview:_dateLabel];
    [_stackView addArrangedSubview:_imageView];
    [_stackView addArrangedSubview:_imageTitleLabel];
    [_stackView addArrangedSubview:_imageDescription];
    [_stackView addArrangedSubview:_dividerView];
    
    [self.contentView addSubview:_stackView];
    [NSLayoutConstraint activateConstraints:@[
        [_imageView.heightAnchor constraintEqualToConstant:200],
        
        [_dividerView.heightAnchor constraintEqualToConstant:1],
        [_dividerView.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor],
        
        [_stackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [_stackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [_stackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        [_stackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
    ]];
}

- (void)setImageFromUrl:(NSString *)url date:(NSString *)date title:(NSString *)title description:(NSString *)description {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    self.imageView.image = image;
    self.dateLabel.text = date;
    self.imageTitleLabel.text = title;
    self.imageDescription.text = description;
}

@end

NS_ASSUME_NONNULL_END


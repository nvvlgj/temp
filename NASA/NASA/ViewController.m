#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "ApodDataFetcher.h"
#import "FavouritesCollectionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController ()

@property(nonatomic) UIScrollView *contentScrollView;
@property(nonatomic) UIStackView *verticalStackView;
@property(nonatomic) UIStackView *horizontalStackView;

@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) UILabel *descriptionLabel;
@property(nonatomic) UILabel *pickDateLabel;
@property(nonatomic) UIDatePicker *datePicker;
@property(nonatomic) UIImageView *podView;
@property(nonatomic) UILabel *imageTitleLabel;
@property(nonatomic) UITextView *imageDescriptionTextView;
@property(nonatomic) UIButton *addToFavouritesButton;
@property(nonatomic) UIButton *favouritesButton;
@property(nonatomic) UIView *dividerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitleLabel];
    [self setupPickDateLabel];
    [self setupDateSelector];
    [self setupPictureOfTheDay];
    [self setupImageTitleLabel];
    [self setupImageDescriptionTextView];
    [self setupDividerView];
    [self setupAddToFavouriteButton];
    [self setupFavouritesButton];
    
    [self setupHorizontalStackView];
    [self setupVerticalStackView];
    [self setupContentScrollView];
    
    [self setupConstraints];
    
    [self fetchAPOFForDate:nil];
}

# pragma mark - Private helpers

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.favouritesButton.enabled = YES;
}

- (void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"Astronomy Picture of the Day";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
}

- (void)setupPickDateLabel {
    self.pickDateLabel = [[UILabel alloc] init];
    self.pickDateLabel.text = @"Please pick a date of your choice";
    self.pickDateLabel.numberOfLines = 0;
}

- (void)setupDateSelector {
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.maximumDate = [NSDate date];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self
                        action:@selector(didChangeDatePickerValue)
              forControlEvents:UIControlEventValueChanged];
}

- (void)setupPictureOfTheDay {
    UIImage *defaultImage = [UIImage imageNamed:@"nasa_logo.jgp"];
    self.podView = [[UIImageView alloc] initWithImage:defaultImage];
    self.podView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setupImageTitleLabel {
    self.imageTitleLabel = [[UILabel alloc] init];
    self.imageTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.imageTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
}

- (void)setupImageDescriptionTextView {
    self.imageDescriptionTextView = [[UITextView alloc] init];
    self.imageDescriptionTextView.textContainerInset = UIEdgeInsetsMake(0, 2, 0, 2);
    self.imageDescriptionTextView.scrollEnabled = NO;
    self.imageDescriptionTextView.editable = NO;
    self.imageDescriptionTextView.selectable = NO;
    self.imageDescriptionTextView.font = [UIFont fontWithName:self.imageDescriptionTextView.font.fontName size:15];
    self.imageDescriptionTextView.textAlignment = NSTextAlignmentJustified;
    self.imageDescriptionTextView.text = @"Loading Astronomy picture of the day...";
}

- (void)setupDividerView {
    self.dividerView = [[UIView alloc] init];
    self.dividerView.backgroundColor = UIColor.blackColor;
}

- (void)setupAddToFavouriteButton {
    self.addToFavouritesButton = [self createButtonWithTitle:@"Add to Favourites"];
    self.addToFavouritesButton.enabled = NO;
    [self.addToFavouritesButton addTarget:self action:@selector(didTapAddToFavouritesButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapAddToFavouritesButton {
    [self.addToFavouritesButton setTitle:@"Added to favourites" forState:UIControlStateNormal];
    // TODO
}

- (void)setupFavouritesButton {
    self.favouritesButton = [self createButtonWithTitle:@"Favourites"];
    [self.favouritesButton addTarget:self action:@selector(didTapFavouritesButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapFavouritesButton {
    self.favouritesButton.enabled = NO;
    [ApodDataFetcher fetchAPOFForStartDate:[NSDate date] endDate:[NSDate date] completion:^(NSArray * _Nonnull responses) {
        FavouritesCollectionViewController *favouritesViewController = [[FavouritesCollectionViewController alloc] initWithResponseData:responses];
        [self presentViewController:favouritesViewController animated:YES completion:nil];
    }];
}

- (UIButton *)createButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = UIColor.systemGray5Color;
    button.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 8.0;
    button.layer.masksToBounds = YES;
    
    return button;
}

// Contains "Favorites" feature related buttons.
- (void)setupHorizontalStackView {
    self.horizontalStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.addToFavouritesButton, self.favouritesButton]];
    self.horizontalStackView.axis = UILayoutConstraintAxisHorizontal;
    self.horizontalStackView.distribution = UIStackViewDistributionFill;
    self.horizontalStackView.spacing = 10.0;
}

// Used as a content view which holds all views having data.
- (void)setupVerticalStackView {
    self.verticalStackView = [[UIStackView alloc] initWithArrangedSubviews:@[
        self.titleLabel,
        self.dividerView,
        self.pickDateLabel,
        self.datePicker,
        self.podView,
        self.imageTitleLabel,
        self.dividerView,
        self.imageDescriptionTextView,
        self.horizontalStackView,
    ]];
    self.verticalStackView.axis = UILayoutConstraintAxisVertical;
    self.verticalStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.verticalStackView.alignment = UIStackViewAlignmentCenter;
    self.verticalStackView.spacing = 10.0;
    self.verticalStackView.translatesAutoresizingMaskIntoConstraints = NO;
}

// Scrollable container view.
- (void)setupContentScrollView {
    self.contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    
    [self.contentScrollView addSubview:self.verticalStackView];
    [self.view addSubview:self.contentScrollView];
}

- (void)setupConstraints {
    NSLayoutConstraint *podViewHeightConstraint = [self.podView.heightAnchor constraintEqualToConstant:300];
    NSLayoutConstraint *dividerViewHeightConstraint = [self.dividerView.heightAnchor constraintEqualToConstant:1];
    NSLayoutConstraint *dividerViewWidthConstraint = [self.dividerView.widthAnchor constraintEqualToAnchor:self.verticalStackView.widthAnchor];
    
    NSLayoutConstraint *contentScrollViewLeadingConstraint = [self.contentScrollView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor];
    NSLayoutConstraint *contentScrollViewTrailingConstraint = [self.contentScrollView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor multiplier:0.95];
    NSLayoutConstraint *contentScrollViewTopConstraint = [self.contentScrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20];
    NSLayoutConstraint *contentScrollViewBottomConstraint = [self.contentScrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
    
    NSLayoutConstraint *verticalStackViewLeadingConstraint = [self.verticalStackView.leadingAnchor constraintEqualToAnchor:self.contentScrollView.leadingAnchor];
    NSLayoutConstraint *verticalStackViewWidthConstraint = [self.verticalStackView.widthAnchor constraintEqualToAnchor:self.contentScrollView.widthAnchor];
    NSLayoutConstraint *verticalStackViewTopConstraint = [self.verticalStackView.topAnchor constraintEqualToAnchor:self.contentScrollView.topAnchor constant:20];
    NSLayoutConstraint *verticalStackViewBottomConstraint = [self.verticalStackView.bottomAnchor constraintEqualToAnchor:self.contentScrollView.bottomAnchor constant:-20];
    
    [NSLayoutConstraint activateConstraints:@[
        podViewHeightConstraint,
        dividerViewHeightConstraint,
        dividerViewWidthConstraint,
        
        contentScrollViewLeadingConstraint,
        contentScrollViewTrailingConstraint,
        contentScrollViewTopConstraint,
        contentScrollViewBottomConstraint,
        
        verticalStackViewLeadingConstraint,
        verticalStackViewWidthConstraint,
        verticalStackViewTopConstraint,
        verticalStackViewBottomConstraint
    ]];
}

- (void)didChangeDatePickerValue {
    NSLog(@"Selected date = %@", self.datePicker.date);
    self.addToFavouritesButton.enabled = NO;
    [self fetchAPOFForDate:self.datePicker.date];
}

- (void)fetchAPOFForDate:(nullable NSDate *)date {
    [ApodDataFetcher fetchAPOFForDate:date completion:^(NSString * _Nonnull imageURL, NSString * _Nonnull title, NSString * _Nonnull description) {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
            self.podView.image = image;
        self.imageTitleLabel.text = title;
            self.imageDescriptionTextView.text = description;
            self.addToFavouritesButton.enabled = YES;
            [self.view layoutIfNeeded];
            
    }];
}

@end

NS_ASSUME_NONNULL_END

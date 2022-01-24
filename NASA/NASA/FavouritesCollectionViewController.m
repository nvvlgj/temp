#import "FavouritesCollectionViewController.h"
#import "ApodCollectionViewCell.h"
#import "ApodDataFetcher.h"

@interface FavouritesCollectionViewController() <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) NSArray<NSDictionary *> * responseData;

@end

@implementation FavouritesCollectionViewController

- (instancetype)initWithResponseData:(NSArray<NSDictionary *> *)responseData {
    self = [super init];
    if (self) {
        _responseData = responseData;
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        [_collectionView registerClass:[ApodCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.collectionView];
        
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [NSLayoutConstraint activateConstraints:@[
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:40],
            [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        ]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.responseData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *response = self.responseData[indexPath.row];
    ApodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSString *imageUrl = [response valueForKey:kResponseDictionaryImageUrlKey];
    NSString *date = [response valueForKey:kResponseDictionaryDateKey];
    NSString *title = [response valueForKey:kResponseDictionaryTitleKey];
    NSString *description = [response valueForKey:kResponseDictionaryDescriptionKey];
    [cell setImageFromUrl:imageUrl date:date title:title description:description];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width - 20, 700);
}

@end

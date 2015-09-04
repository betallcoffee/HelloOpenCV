//
//  LLPhotosViewController.m
//  HelloOpenCV
//
//  Created by liang on 6/6/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import "LLPhotosViewController.h"
#import "LLPhotosStore.h"
#import "LLPhotoModel.h"
#import "LLPhotoCell.h"
#import "UIImage+Util.h"

#import "LLPhotoViewController.h"

@interface LLPhotosViewController ()<
  UICollectionViewDataSource,
  UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LLPhotosStore *photosStore;

@property (nonatomic, copy) FilterImageBlock filterImageBlock;
@property (nonatomic, copy) id<LLPhotoFilter> photoFilter;

@end

@implementation LLPhotosViewController

- (instancetype)initWithFilterImageBlock:(FilterImageBlock)filterImageBlock {
    self = [super init];
    if (self) {
        _filterImageBlock = filterImageBlock;
    }
    return self;
}

- (instancetype)initWithPhotoFilter:(id<LLPhotoFilter>)photoFilter {
    self = [super init];
    if (self) {
        _photoFilter = photoFilter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:YES];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];
    self.navigationItem.rightBarButtonItem = done;
    
    [self.view addSubview:self.collectionView];
    
    [self.photosStore fetchPhotosComplete:^(LLPhotosStore *photosStore) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosStore.photos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photocell" forIndexPath:indexPath];
    if (indexPath.row < self.photosStore.photos.count) {
        [cell configCell:self.photosStore.photos[indexPath.row]];
    }
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor blueColor].CGColor;
    cell.layer.borderWidth = 1;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor blueColor].CGColor;
    cell.layer.borderWidth = 0;
}

#pragma mark IBAction

- (IBAction)onDone:(UIButton *)sender {
    NSArray *indexPathes = [self.collectionView indexPathsForSelectedItems];
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:indexPathes.count];
    UIImage *originImage;
    for (NSIndexPath *indexPath in indexPathes) {
        LLPhotoModel *model = _photosStore.photos[indexPath.row];
        UIImage *image = [UIImage imageWithALAsset:model.asset];
        [images addObject:image];
        originImage = image;
    }
    
    UIImage *filterImage;
    if (self.filterImageBlock) {
        if (self.imageCountOfFilter <= images.count) {
            filterImage = self.filterImageBlock(images);
        }
    } else if (self.photoFilter) {
        if ([self.photoFilter imageCountOfFilter] <= images.count) {
            filterImage = [self.photoFilter filterImage:images];
        }
    }
    
    if (filterImage) {
        LLPhotoViewController *viewController = [[LLPhotoViewController alloc] initWithFilterImage:filterImage andOriginImage:originImage];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark setter/getter method

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = [LLPhotoCell size];

        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.frame = self.view.bounds;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.allowsMultipleSelection = YES;

        [_collectionView registerClass:[LLPhotoCell class] forCellWithReuseIdentifier:@"photocell"];
    }
    return _collectionView;
}

- (LLPhotosStore *)photosStore
{
    if (!_photosStore) {
        _photosStore = [[LLPhotosStore alloc] init];
    }
    return _photosStore;
}

@end

//
//  LLViewController.m
//  HelloOpenCV
//
//  Created by liang on 12/16/14.
//  Copyright (c) 2014 Tina. All rights reserved.
//

//#import "opensift.h"
//#import "imgfeatures.h"
#import "wote.h"

#import "LLViewController.h"
#import "UIImage+Util.h"
#import "UIImage+CVMat.h"
#import "UIImage+CVBlend.h"
#import "UIImage+Convolves.h"

#import "LLPhotosViewController.h"

@interface LLViewController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *filters;
@property (nonatomic, strong) NSArray *imageCounts;

@end

@implementation LLViewController

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)filterImage:(NSString *)imageName withBlock:(cv::Mat (^)(cv::Mat &cvMat))filter{
    UIImage *image = [UIImage imageNamed:imageName];
    cv::Mat cvMat = [image CVMatFromImage];
    if (filter != nil) {
        cvMat = filter(cvMat);
    }
    
    return [UIImage imageWithCVMat:cvMat];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.filters.count > indexPath.row) {
        FilterImageBlock block = self.filters[indexPath.row];
        LLPhotosViewController *photos = [[LLPhotosViewController alloc] initWithFilterImageBlock:block];
        NSNumber *imageCount = self.imageCounts[indexPath.row];
        photos.imageCountOfFilter = imageCount.integerValue;
        [self.navigationController pushViewController:photos animated:YES];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Titles"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Titles"];
    }
    
    if (self.titles.count > indexPath.row) {
        cell.textLabel.text = self.titles[indexPath.row];
    } else {
        cell.textLabel.text = @"超出了";
    }
    
    return cell;
}

#pragma mark setter/getter

- (NSArray *)titles {
    if (_titles == nil) {
        _titles = @[@"CVBlend",
                    @"ContrastEnhancement",
                    @"Filter2D"];
    }
    return _titles;
}

- (NSArray *)filters {
    if (_filters == nil) {
        _filters = @[[[UIImage blendImageBlock] copy],
                     [[UIImage contrastEnhancementImageBlock] copy],
                     [[UIImage filter2DImageBlock] copy]];
    }
    return _filters;
}

- (NSArray *)imageCounts {
    if (_imageCounts == nil) {
        _imageCounts = @[[UIImage blendImageCount],
                         [UIImage contrastEnhascementImageCount],
                         [UIImage filter2DImageCount]];
    }
    return _imageCounts;
}

@end

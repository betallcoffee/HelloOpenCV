//
//  LLViewController.m
//  HelloOpenCV
//
//  Created by liang on 12/16/14.
//  Copyright (c) 2014 Tina. All rights reserved.
//

#import "UIImage+Util.h"
#import "UIImage+CVMat.h"
#import "LLMaskMatrices.h"
#import "LLBlend.h"
#import "LLContrastBrightness.h"
#include "LLBaseDrawing.hpp"

#import "LLViewController.h"
#import "LLFilterResultViewController.h"

@interface LLViewController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIImage *resultImage;

@end

@implementation LLViewController

- (instancetype)initWithImages:(NSArray *)images
{
    self = [super init];
    if (self) {
        self.images = images;
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

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.titles.count > indexPath.row) {
        if (self.images.count > 0) {
            switch (indexPath.row) {
                case 0:
                    [self blend];
                    break;
                case 1:
                    [self contrastEnhancement];
                    break;
                case 2:
                    [self filter2D];
                    break;
                case 3:
                    [self contrastBrightness];
                    break;
                case 4:
                    [self baseDrawAtom];
                    break;
                case 5:
                    [self baseDrawRook];
                    break;
                default:
                    break;
            }
            
            UIImage *originImage = self.images[0];
            LLFilterResultViewController *result = [[LLFilterResultViewController alloc] initWithFilterImage:self.resultImage
                                                                                              andOriginImage:originImage];
            [self.navigationController pushViewController:result animated:YES];
        }
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

- (void)blend
{
    if (self.images.count > 1) {
        UIImage *imageA = [self.images[0] scaleToSize:CGSizeMake(640, 1280)];
        UIImage *imageB = [self.images[1] scaleToSize:CGSizeMake(640, 1280)];
        self.resultImage = [LLBlend imageBlendImage:imageA andImage:imageB withBeta:0.5];
    }
}
- (void)contrastEnhancement
{
    if (self.images.count > 0) {
        UIImage *originImage = self.images[0];
        self.resultImage = [LLMaskMatrices contrastEnhancementWithImage:originImage];
    }
}

- (void)filter2D
{
    if (self.images.count > 0) {
        UIImage *originImage = self.images[0];
        self.resultImage = [LLMaskMatrices filter2DWithImage:originImage];
    }
}

- (void)contrastBrightness
{
    if (self.images.count > 0) {
        UIImage *originImage = self.images[0];
        self.resultImage = [LLContrastBrightness contrastBrightness:originImage alpha:2.2 beta:50];
    }
}

- (void)baseDrawAtom
{
    int w = 400;
    cv::Mat cvMat = cv::Mat::zeros( w, w, CV_8UC3 );
    LL::BaseDrawing::drawAtom(cvMat);
    self.resultImage = [UIImage imageWithCVMat:cvMat];
}

- (void)baseDrawRook
{
    int w = 400;
    cv::Mat cvMat = cv::Mat::zeros(w, w, CV_8UC3);
    LL::BaseDrawing::drawRook(cvMat);
    self.resultImage = [UIImage imageWithCVMat:cvMat];
}

#pragma mark setter/getter

- (NSArray *)titles {
    if (_titles == nil) {
        _titles = @[@"CVBlend",
                    @"ContrastEnhancement",
                    @"Filter2D",
                    @"ContrastBrightness",
                    @"BaseDrawAtom",
                    @"BaseDrawRook"];
    }
    return _titles;
}

@end

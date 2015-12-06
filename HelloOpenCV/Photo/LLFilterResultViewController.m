//
//  LLFilterResultViewController.m
//  HelloOpenCV
//
//  Created by liang on 12/6/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import "LLFilterResultViewController.h"

@interface LLFilterResultViewController ()
{
    UIImage *_filterImage;
    UIImageView *_filterImageView;
    
    UIImage *_originImage;
    UIImageView *_originImageView;
}

@end

@implementation LLFilterResultViewController

- (instancetype)initWithFilterImage:(UIImage *)filterImage andOriginImage:(UIImage *)originImage
{
    self = [super init];
    if (self) {
        _filterImage = filterImage;
        _originImage = originImage;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = (self.view.frame.size.height  - 64) / 2;
    
    _filterImageView = [[UIImageView alloc] initWithImage:_filterImage];
    _filterImageView.frame = CGRectMake(0, 64, width, height);
    [self.view addSubview:_filterImageView];
    
    _originImageView = [[UIImageView alloc] initWithImage:_originImage];
    _originImageView.frame = CGRectMake(0, height+64, width, height);
    [self.view addSubview:_originImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

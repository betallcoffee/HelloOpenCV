//
//  LLPhotoViewController.m
//  HelloOpenCV
//
//  Created by liang on 7/30/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import "LLPhotoViewController.h"

@interface LLPhotoViewController ()
{
    UIImage *_image;
    UIImageView *_imageView;
}

@end

@implementation LLPhotoViewController

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageView = [[UIImageView alloc] initWithImage:_image];
    _imageView.frame = self.view.bounds;
    [self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
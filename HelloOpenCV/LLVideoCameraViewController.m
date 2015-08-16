//
//  LLVideoCameraViewController.m
//  HelloOpenCV
//
//  Created by liang on 6/13/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import "LLVideoCameraViewController.h"
#import <opencv2/highgui/cap_ios.h>

@interface LLVideoCameraViewController ()<CvVideoCameraDelegate>

@property (nonatomic, strong) CvVideoCamera* videoCamera;

@end

@implementation LLVideoCameraViewController

- (void)viewDidLoad
{
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.view];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    self.videoCamera.delegate = self;
}

- (IBAction)actionStart:(id)sender {
    [self.videoCamera start];
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus

- (void)processImage:(cv::Mat &)image {
    [LLConvolvesImage contrastEnhancement:image];
}

//- (void)processImage:(Mat&)image
//{
////    woteHash(image);
//    // Do some OpenCV stuff with the image
////    CvSize size{8,8};
////    IplImage iplImage = (IplImage)image;
////    IplImage *iplImage_small = cvCreateImage(size, iplImage.depth, iplImage.nChannels);
////    cvResize(iplImage_small, &iplImage);
////    Mat image_small(&iplImage);
//
//
////    IplImage iplImage = (IplImage)image;
////    struct feature *features;
////    int n;
////    n = [OpenSift siftFeature:&features image:&iplImage];
////    [OpenSift drawFeatures:features onImage:&iplImage ofNum:n];
////
////    Mat image_feature(&iplImage);
//
//    //    Mat image_copy;
//    //    cvtColor(image, image_copy, CV_BGRA2BGR);
//    // invert image
////    bitwise_not(image_copy, image_copy);
//
////    cvtColor(image_small, image, CV_BGR2GRAY);
////        cvReleaseImage(&iplImage_small);
//
//}
#endif



@end

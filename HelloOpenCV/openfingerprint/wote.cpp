//
//  wote.cpp
//  HelloOpenCV
//
//  Created by liang on 12/17/14.
//  Copyright (c) 2014 Tina. All rights reserved.
//

#include <opencv2/imgproc/imgproc.hpp>
#include "wote.h"

long long woteHash(Mat &image) {
    // 1. scale image to size(8,8);
    Mat image_samll(Size(8,8), image.type());
    resize(image, image_samll, Size(8,8), 0, 0);
    
    // 2. convert rgb image to gray scale
    Mat image_gray;
    cvtColor(image_samll, image_gray, CV_BGRA2GRAY);
    cvtColor(image_samll, image, CV_BGRA2GRAY);
    
    CV_Assert(image_gray.depth() != sizeof(uchar));
    
    const int channels = image_gray.channels();
    switch(channels)
    {
        case 1:
        {
            MatIterator_<uchar> it, end;
            int sum = 0;
            int num = 0;
            for( it = image_gray.begin<uchar>(), end = image_gray.end<uchar>(); it != end; ++it) {
                uchar c = *it;
                sum += c;
                num++;
            }
            int avg = sum / 64;
            printf("sum :%d, arv: %d, num: %d\n", sum, avg, num);
            long long hash = 0;
            num = 0;
            for( it = image_gray.begin<uchar>(), end = image_gray.end<uchar>(); it != end; ++it) {
                uchar c = *it;
                if (c > avg) {
                    hash ^= (1 << num);
                }
                num++;
            }
            printf("hash %lu:%s\n", sizeof(hash), (char*)&hash);
            return hash;
        }
    }

    return 0;
}

//
//  LLBaseDrawing.hpp
//  HelloOpenCV
//
//  Created by liang on 12/17/16.
//  Copyright © 2016 Tina. All rights reserved.
//  http://docs.opencv.org/2.4/doc/tutorials/core/basic_geometric_drawing/basic_geometric_drawing.html#drawing-1

#ifndef LLBaseDrawing_hpp
#define LLBaseDrawing_hpp

#include <opencv2/core/core.hpp>

namespace LL {
    class BaseDrawing {
    public:
        BaseDrawing() {};
        ~BaseDrawing() {};
        
        static void drawAtom(cv::Mat &cvMat);
        static void drawRook(cv::Mat &cvMat);
    private:
        static void drawLine(cv::Mat &cvMat, cv::Point start, cv::Point end);
        static void drawEllipse(cv::Mat &cvMat, double angel);
        static void drawFilledCircle(cv::Mat &cvMat, cv::Point center);
        static void drawPolygon(cv::Mat &cvMat);
    };
}

#endif /* LLBaseDrawing_hpp */

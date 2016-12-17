//
//  LLBaseDrawing.cpp
//  HelloOpenCV
//
//  Created by liang on 12/17/16.
//  Copyright © 2016 Tina. All rights reserved.
//

#include "LLBaseDrawing.hpp"

static const int w = 400;

using namespace LL;

void BaseDrawing::drawAtom(cv::Mat &cvMat) {
    // 1.a. Creating ellipses
    drawEllipse( cvMat, 90 );
    drawEllipse( cvMat, 0 );
    drawEllipse( cvMat, 45 );
    drawEllipse( cvMat, -45 );
    
    /// 1.b. Creating circles
    drawFilledCircle( cvMat, cv::Point( w/2.0, w/2.0) );
}

void BaseDrawing::drawRook(cv::Mat &cvMat) {
    /// 2.a. Create a convex polygon
    drawPolygon( cvMat );
    
    /// 2.b. Creating rectangles
    cv::rectangle( cvMat,
              cv::Point( 0, 7*w/8.0 ),
              cv::Point( w, w),
              cv::Scalar( 0, 255, 255 ),
              -1,
              8 );
    
    /// 2.c. Create a few lines
    drawLine( cvMat, cv::Point( 0, 15*w/16 ), cv::Point( w, 15*w/16 ) );
    drawLine( cvMat, cv::Point( w/4, 7*w/8 ), cv::Point( w/4, w ) );
    drawLine( cvMat, cv::Point( w/2, 7*w/8 ), cv::Point( w/2, w ) );
    drawLine( cvMat, cv::Point( 3*w/4, 7*w/8 ), cv::Point( 3*w/4, w ) );
}

void BaseDrawing::drawLine(cv::Mat &cvMat, cv::Point start, cv::Point end) {
    int thickness = 2;
    int lineType = 8;
    cv::line(cvMat, start, end, cv::Scalar(0, 0, 0), thickness, lineType);
}

void BaseDrawing::drawEllipse(cv::Mat &cvMat, double angle) {
    int thickness = 2;
    int lineType = 8;
    cv::ellipse(cvMat, cv::Point(w/2.0, w/2.0), cv::Size(w/4.0, w/16.0), angle, 0, 360, cv::Scalar(255, 0, 0), thickness, lineType);
}

void BaseDrawing::drawFilledCircle(cv::Mat &cvMat, cv::Point center) {
    int thickness = -1;
    int lineType = 8;
    cv::circle(cvMat, center, w/32, cv::Scalar(0, 0, 255), thickness, lineType);
}

void BaseDrawing::drawPolygon(cv::Mat &cvMat) {
    int lineType = 8;
    /** Create some points */
    cv::Point rook_points[1][20];
    rook_points[0][0] = cv::Point( w/4.0, 7*w/8.0 );
    rook_points[0][1] = cv::Point( 3*w/4.0, 7*w/8.0 );
    rook_points[0][2] = cv::Point( 3*w/4.0, 13*w/16.0 );
    rook_points[0][3] = cv::Point( 11*w/16.0, 13*w/16.0 );
    rook_points[0][4] = cv::Point( 19*w/32.0, 3*w/8.0 );
    rook_points[0][5] = cv::Point( 3*w/4.0, 3*w/8.0 );
    rook_points[0][6] = cv::Point( 3*w/4.0, w/8.0 );
    rook_points[0][7] = cv::Point( 26*w/40.0, w/8.0 );
    rook_points[0][8] = cv::Point( 26*w/40.0, w/4.0 );
    rook_points[0][9] = cv::Point( 22*w/40.0, w/4.0 );
    rook_points[0][10] = cv::Point( 22*w/40.0, w/8.0 );
    rook_points[0][11] = cv::Point( 18*w/40.0, w/8.0 );
    rook_points[0][12] = cv::Point( 18*w/40.0, w/4.0 );
    rook_points[0][13] = cv::Point( 14*w/40.0, w/4.0 );
    rook_points[0][14] = cv::Point( 14*w/40.0, w/8.0 );
    rook_points[0][15] = cv::Point( w/4.0, w/8.0 );
    rook_points[0][16] = cv::Point( w/4.0, 3*w/8.0 );
    rook_points[0][17] = cv::Point( 13*w/32.0, 3*w/8.0 );
    rook_points[0][18] = cv::Point( 5*w/16.0, 13*w/16.0 );
    rook_points[0][19] = cv::Point( w/4.0, 13*w/16.0) ;
    
    const cv::Point* ppt[1] = { rook_points[0] };
    int npt[] = { 20 };
    
    cv::fillPoly(cvMat, ppt, npt, 1, cv::Scalar(255, 255, 255), lineType);
    
}

//
//  LLPhotosStore.h
//  HelloOpenCV
//
//  Created by liang on 6/6/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLPhotosStore : NSObject

@property (nonatomic, readonly) NSMutableArray *photos;
@property (nonatomic, readonly) NSCache *thumbCache;

- (void)fetchPhotosComplete:(void (^)(LLPhotosStore *photosStore))completeBlock;

@end

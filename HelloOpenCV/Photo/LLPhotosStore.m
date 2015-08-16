//
//  LLPhotosStore.m
//  HelloOpenCV
//
//  Created by liang on 6/6/15.
//  Copyright (c) 2015 Tina. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "LLPhotosStore.h"
#import "LLPhotoModel.h"

@interface LLPhotosStore ()

@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation LLPhotosStore

@synthesize photos = _photos;

- (void)fetchPhotosComplete:(void (^)(LLPhotosStore *))completeBlock
{
    __weak typeof(&*self) weakSelf = self;
    [self.library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                    NSLog(@"LLPhotosStore group %@", group);
                                    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                        NSLog(@"LLPhotosStore asset %@", result);
                                        ALAssetRepresentation *rep = [result defaultRepresentation];
                                        NSLog(@"LLPhotosStore filename %@", rep.filename);
                                        LLPhotoModel *model = [[LLPhotoModel alloc] init];
                                        model.rep = rep;
                                        [self.photos addObject:model];
                                    }];
                                    if (completeBlock) {
                                        completeBlock(weakSelf);
                                    }
                                } failureBlock:^(NSError *error) {
                                    NSLog(@"LLPhotsStore failure: %@", error);
                                }];
}

#pragma mark - getter/setter

- (ALAssetsLibrary *)library
{
    if (!_library) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

@end

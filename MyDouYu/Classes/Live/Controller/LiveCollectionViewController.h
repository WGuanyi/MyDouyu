//
//  LiveCollectionViewController.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/19.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRoom.h"
#import "MyFaceCollectionViewCell.h"
#import "MyCollectionViewCell.h"

typedef enum {
    LiveCellTypeNormal,
    LiveCellTypeFaceLevel
}LiveCellType;

@interface LiveCollectionViewController : UICollectionViewController

@property (nonatomic, assign) LiveCellType cellType;

@property (nonatomic, assign) int offset;

@property (nonatomic, strong) NSMutableArray *rooms;

@property (nonatomic, copy) NSString *lastUrl;

@end

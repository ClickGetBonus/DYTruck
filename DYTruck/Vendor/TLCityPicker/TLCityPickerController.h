//
//  TLCityPickerController.h
//  TLCityPickerDemo
//
//  Created by 李伯坤 on 15/11/5.
//  Copyright © 2015年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCityPickerDelegate.h"
#import "TLCity.h"

#define     MAX_COMMON_CITY_NUMBER      8
#define     COMMON_CITY_DATA_KEY        @"TLCityPickerCommonCityArray"

@interface TLCityPickerController : UIViewController

@property (nonatomic, assign) id<TLCityPickerDelegate>delegate;

/*
 *  定位城市id
 */
@property (nonatomic, strong) TLCity *locationCity;

/*
 *  城市数据，可在Getter方法中重新指定
 */
@property (nonatomic, strong) NSMutableArray <TLCity *> * citys;
@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, strong) UITableView *tableView;

- (void)updateSubviewsFrame;

@end

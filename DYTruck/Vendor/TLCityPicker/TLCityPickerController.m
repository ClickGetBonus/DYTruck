//
//  TLCityPickerController.m
//  TLCityPickerDemo
//
//  Created by 李伯坤 on 15/11/5.
//  Copyright © 2015年 李伯坤. All rights reserved.
//

#import "TLCityPickerController.h"
#import "TLCityPickerSearchResultController.h"
#import "TLCityHeaderView.h"
#import "TLCityGroupCell.h"

@interface TLCityPickerController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>


@property (nonatomic, strong) NSMutableArray *cityData;
@property (nonatomic, strong) NSMutableArray *arraySection;

@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation TLCityPickerController
@synthesize data = _data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   self.view.bounds.size.width,
                                                                   self.view.bounds.size.height)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.shadowColor = UIColorFromRGB(0x0b0b0b).CGColor;
    self.tableView.layer.shadowRadius = 5.0;
    self.tableView.layer.shadowOpacity = 0.2;
    self.tableView.layer.shadowOffset = CGSizeMake(0, 0);
    self.tableView.clipsToBounds = false;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:UIColorFromRGB(0x999999)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[TLCityHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLCityHeaderView"];
    if ([self.tableView respondsToSelector:@selector (setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        [self.tableView setSeparatorColor:[UIColor groupTableViewBackgroundColor]];
    }
}

- (void)updateSubviewsFrame {
    self.tableView.frame = self.view.bounds;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arraySection.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        NSString *keyword = self.arraySection[section];
        NSArray *array = self.data[keyword];
        return array.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (indexPath.section == 0) {
        [cell.textLabel setText:self.locationCity.cityName];
    } else {
        
        NSString *keyword = self.arraySection[indexPath.section];
        TLCity *city = self.data[keyword][indexPath.row];
        [cell.textLabel setText:city.cityName];
    }
    
    return cell;
}


#pragma mark UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TLCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLCityHeaderView"];
    NSString *title = [_arraySection objectAtIndex:section];
    [headerView setTitle:title];
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 27.0f;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TLCity *city;
    if (indexPath.section == 0) {
        city = self.locationCity;
    } else {
        NSString *keyword = self.arraySection[indexPath.section];
        city = self.data[keyword][indexPath.row];
    }
    [self didSelctedCity:city];
    
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [self.arraySection mutableCopy];
    array[0] = @"定位";
    return array;
}

//- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    //    if(index == 0) {
//    //        [self.tableView scrollRectToVisible:self.searchController.searchBar.frame animated:NO];
//    //        return -1;
//    //    }
//    return index;
//}


#pragma mark - Event Response
- (void) cancelButtonDown:(UIBarButtonItem *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerControllerDidCancel:)]) {
        [_delegate cityPickerControllerDidCancel:self];
    }
}

- (void)onCancel:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerControllerDidCancel:)]) {
        [_delegate cityPickerControllerDidCancel:self];
    }
}

#pragma mark - Private Methods
- (void) didSelctedCity:(TLCity *)city
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerController:didSelectCity:)]) {
        [_delegate cityPickerController:self didSelectCity:city];
    }
}

#pragma mark - Setter
- (void)setCitys:(NSMutableArray<TLCity *> *)citys {
    
    _data = [[NSMutableDictionary alloc] init];
    
    for (TLCity *city in citys) {
        NSString *initials = city.initials;
        if ([_data.allKeys containsObject:initials]) {
            NSMutableArray *array = _data[initials];
            [array addObject:city];
        } else {
            [_data setObject:[NSMutableArray arrayWithObject:city]
                      forKey:initials];
        }
    }
    
    self.arraySection = [NSMutableArray arrayWithObject:@"当前定位城市"];
    for (NSString *key in _data.allKeys) {
        [self.arraySection addObject:key];
    }
    
    _citys = citys;
}

#pragma mark - Getter

//- (NSMutableArray *) localCityData
//{
//    if (_localCityData == nil) {
//        _localCityData = [[NSMutableArray alloc] init];
//        if (self.locationCityID != nil) {
//            TLCity *city = nil;
//            for (TLCity *item in self.cityData) {
//                if ([item.cityID isEqualToString:self.locationCityID]) {
//                    city = item;
//                    break;
//                }
//            }
//            if (city == nil) {
//                NSLog(@"Not Found City: %@", self.locationCityID);
//            }
//            else {
//                [_localCityData addObject:city];
//            }
//        }
//    }
//    return _localCityData;
//}


//- (NSMutableArray *) arraySection
//{
//    if (_arraySection == nil) {
//        _arraySection = [[NSMutableArray alloc] initWithObjects:@"当前定位城市", @"★热门城市", nil];
//    }
//    return _arraySection;
//}

@end

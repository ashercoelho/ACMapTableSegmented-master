//
//  ViewController.h
//  ACMapTableSegmented-example
//
//  Created by Asher Coelho on 8/1/13.
//  Copyright (c) 2013 Asher Coelho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACMapTableSegmentedViewController.h"
#import "KIPullToRevealCell.h"
#import "LocationPickerView.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, LocationPickerViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) LocationPickerView *locationPickerView;

@end

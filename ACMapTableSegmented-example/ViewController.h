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
#import "SDSegmentedControl.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, LocationPickerViewDelegate>

@property (nonatomic, retain) SDSegmentedControl *segmentedControl;
@property (nonatomic, strong) LocationPickerView *locationPickerView;

@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIImageView *buttonImage;

@end

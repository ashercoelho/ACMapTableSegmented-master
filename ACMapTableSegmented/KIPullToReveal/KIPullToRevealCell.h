//
//  PullToRevealCell.h
//  PullToReveal
//
//  Created by Marcus Kida on 05.11.12.
//  Copyright (c) 2012 Marcus Kida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface KIPullToRevealCell : UITableViewCell

+ (KIPullToRevealCell *)cellFromNibNamed:(NSString *)nibName;

@property (nonatomic, assign) CLLocationCoordinate2D pointLocation;
@property (nonatomic, retain) UIImageView *iconImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *distanceLabel;

@property (nonatomic, retain)  IBOutlet UIImageView *a;
@property (nonatomic, retain)  IBOutlet UILabel *b;
@property (nonatomic, retain)  IBOutlet UILabel *c;
@property (nonatomic, retain)  IBOutlet UIImageView *d;

@end

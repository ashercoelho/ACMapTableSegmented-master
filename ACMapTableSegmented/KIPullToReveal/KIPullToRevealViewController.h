//
//  PullToRevealViewController.h
//  PullToReveal
//
//  Created by Marcus Kida on 02.11.12.
//  Copyright (c) 2012 Marcus Kida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "KIPullToRevealCell.h"
#import "SDSegmentedControl.h"

@protocol KIPullToRevealDelegate <NSObject>

-(void)segmentedControlIndexChanged;
@optional
- (void) pullToRevealDidSearchFor:(NSString *)searchText;

@end

@interface KIPullToRevealViewController : UITableViewController

@property (nonatomic, weak) id <KIPullToRevealDelegate> pullToRevealDelegate;
@property (nonatomic, assign) BOOL centerUserLocation;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) SDSegmentedControl *segmentedControl;

@end



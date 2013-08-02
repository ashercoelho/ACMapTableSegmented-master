//
//  ACMapTableSegmentedViewController.h
//
//  Created by Asher Coelho on 8/1/13.
//  Copyright (c) 2013 Asher Coelho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <GoogleMaps/GoogleMaps.h>

#import "KIPullToRevealCell.h"
#import "SDSegmentedControl.h"

@protocol ACMapTableSegmentedDelegate <NSObject>

-(void)segmentedControlIndexChanged;

@end

@interface ACMapTableSegmentedViewController : UITableViewController

@property (nonatomic, weak) id <ACMapTableSegmentedDelegate> mapTableSegmentedDelegate;
@property (nonatomic, assign) BOOL centerUserLocation;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) SDSegmentedControl *segmentedControl;

@end



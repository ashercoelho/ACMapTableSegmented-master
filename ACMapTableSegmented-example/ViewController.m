//
//  ViewController.m
//  ACMapTableSegmented-example
//
//  Created by Asher Coelho on 8/1/13.
//  Copyright (c) 2013 Asher Coelho. All rights reserved.
//


#import "ViewController.h"
#import "SVPullToRefresh.h"

#define ButtonHeight 135

@interface ViewController ()
{
    NSArray *noticias;
    NSArray *transito;
    NSArray *usuarios;
    
    int pos1,pos2,pos3;
    
    BOOL hidden;
}
@property (nonatomic, strong) NSArray * aTitles;

@end

@implementation ViewController

-(NSArray *)aTitles{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            return noticias;
            break;
        case 1:
            return transito;
            break;
        case 2:
            return usuarios;
            break;
        default:
            return @[];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pos1 = 4;
    pos2 = 10;
    pos3 = 15;

    [self fillData];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bt_top"] forBarMetrics:UIBarMetricsDefault];
    [self insertImageRightInNavBar];
    [[self navigationItem] setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marca_top"]]];
    
    
    // The LocationPickerView can be created programmatically (see below) or
    // using Storyboards/XIBs (see Storyboard file).
//    self.locationPickerView = [[LocationPickerView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
    self.locationPickerView = [[LocationPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.locationPickerView.tableViewDataSource = self;
    self.locationPickerView.tableViewDelegate = self;
    
    // Optional parameters
    self.locationPickerView.delegate = self;
    self.locationPickerView.shouldCreateHideMapButton = YES;
    self.locationPickerView.pullToExpandMapEnabled = NO;
    self.locationPickerView.defaultMapHeight = 140.0;
    self.locationPickerView.parallaxScrollFactor = 0.3;
    
    [self.view insertSubview:self.locationPickerView belowSubview:self.buttonsView];
    
    
//    //Segmented Control
//    self.segmentedControl = [[SDSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"Notícias", @"Trânsito", @"Colabore", nil]];
//    [self.segmentedControl addTarget:self action:@selector(segmentedControlIndexChanged) forControlEvents:UIControlEventValueChanged];
//    self.segmentedControl.frame = CGRectMake(0, 0, self.locationPickerView.tableView.bounds.size.width, 40);
//    [self.segmentedControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//    self.segmentedControl.tintColor = [UIColor clearColor];
//   [self.view  addSubview:self.segmentedControl];

}

- (void)viewDidUnload {
    [self setButtonsView:nil];
    [self setButtonImage:nil];
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Pulltorefresh
    [self.locationPickerView.tableView.pullToRefreshView setTitle:@"Carregando notícias..." forState:SVPullToRefreshStateLoading];
    [self.locationPickerView.tableView addPullToRefreshWithActionHandler:^{
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            wait(3);
            [self.locationPickerView.tableView.pullToRefreshView stopAnimating];
        });
    }];
    
    [self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height - ButtonHeight, ButtonHeight, ButtonHeight)];

    //Adding shadow to the map
    UIImageView *shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.locationPickerView.tableView.tableHeaderView.frame.size.height - 8, self.locationPickerView.tableView.frame.size.width, 8)];
    shadowView.image = [UIImage imageNamed:@"shadow-inverted"];
    [self.locationPickerView.tableView.tableHeaderView  addSubview:shadowView];
}


#pragma mark - TableView Datasource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.aTitles count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stCellIdentifier = @"Cell";
    KIPullToRevealCell *cell = (KIPullToRevealCell *)[tableView dequeueReusableCellWithIdentifier:stCellIdentifier];
    
    if(!cell)
        cell = (KIPullToRevealCell *)[KIPullToRevealCell cellFromNibNamed:NSStringFromClass([KIPullToRevealCell class])];

//    cell.pointLocation = CLLocationCoordinate2DMake([[aLatitudes objectAtIndex:indexPath.row] doubleValue], [[aLongitudes objectAtIndex:indexPath.row] doubleValue]);
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", [self.aTitles objectAtIndex:indexPath.row]];
    cell.distanceLabel.text = [NSString stringWithFormat:@"~ 0.0 km"];

    cell.titleLabel.hidden = false;
    cell.distanceLabel.hidden = false;
    cell.a.hidden = false;
    cell.b.hidden = false;
    cell.c.hidden = false;
    cell.d.hidden = false;
    
//    if (indexPath.row == pos1 || indexPath.row == pos2 || indexPath.row == pos3) {
//        cell.iconImageView.image = [UIImage imageNamed:@"banner"];
//        
//        cell.titleLabel.hidden = true;
//        cell.distanceLabel.hidden = true;
//        cell.a.hidden = true;
//        cell.b.hidden = true;
//        cell.c.hidden = true;
//        cell.d.hidden = true;
//    }else
    if ([indexPath row] % 2 == 0) {
        [cell.iconImageView setImage:[UIImage imageNamed:@"bg-cel-transito-transparent"]];
    } else {
        [cell.iconImageView setImage:[UIImage imageNamed:@"bg-cel-noticias-cinza"]];
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    return image;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!self.segmentedControl) {
        self.segmentedControl = [[SDSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"Notícias", @"Trânsito", @"Colabore", nil]];
        [self.segmentedControl addTarget:self action:@selector(segmentedControlIndexChanged) forControlEvents:UIControlEventValueChanged];
        self.segmentedControl.frame = CGRectMake(0, 0, self.locationPickerView.tableView.bounds.size.width, 40);
        [self.segmentedControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        self.segmentedControl.tintColor = [UIColor clearColor];
    }
    return self.segmentedControl;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

#pragma mark - TableView Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LocationPicker Delegate
- (void)locationPicker:(LocationPickerView *)locationPicker
     mapViewWillExpand:(GMSMapView *)mapView{
    [self expand];
}
- (void)locationPicker:(LocationPickerView *)locationPicker mapViewWillBeHidden:(GMSMapView *)mapView{
    [self contract];
}

#pragma mark - Private Methods

-(void)segmentedControlIndexChanged
{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self.navigationController setToolbarHidden:YES animated:YES];
        pos1 = 4; pos2 = 10; pos3 = 15;
        

        [UIView transitionWithView:self.view
                          duration:0.3
                           options:UIViewAnimationOptionCurveLinear
                        animations:^{ [self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height, ButtonHeight, ButtonHeight)];}
                        completion:^(BOOL finished){
                            [self.buttonImage setImage:[UIImage imageNamed:@"alertaNoticia"]];
                            [UIView transitionWithView:self.view
                                              duration:0.3
                                               options:UIViewAnimationOptionCurveLinear
                                            animations:^{ [self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height - ButtonHeight, ButtonHeight, ButtonHeight)];}
                                            completion:^(BOOL finished){}
                             ];
                        }
         ];

    }else if (self.segmentedControl.selectedSegmentIndex == 1) {
        [self.navigationController setToolbarHidden:YES animated:YES];
        pos1 = 1; pos2 = 7; pos3 = 13;
        
        [self.buttonImage setImage:[UIImage imageNamed:@"tracarRota"]];
        
        [UIView transitionWithView:self.view
                          duration:0.3
                           options:UIViewAnimationOptionCurveLinear
                        animations:^{ [self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height, ButtonHeight, ButtonHeight)];}
                        completion:^(BOOL finished){
                            [UIView transitionWithView:self.view
                                              duration:0.3
                                               options:UIViewAnimationOptionCurveLinear
                                            animations:^{ [self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height - ButtonHeight, ButtonHeight, ButtonHeight)];}
                                            completion:^(BOOL finished){}
                             ];
                        }
         ];
    }else{
        pos1 = -1; pos2 = -1; pos3 = -1;
        [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"banner"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
//        [self.navigationController setToolbarHidden:NO animated:YES];
        
        [UIView transitionWithView:self.view
                          duration:0.3
                           options:UIViewAnimationOptionCurveLinear
                        animations:^{ [self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height, ButtonHeight, ButtonHeight)];}
                        completion:^(BOOL finished){
                            [UIView transitionWithView:self.view
                                              duration:0.3 
                                               options:UIViewAnimationOptionCurveLinear
                                            animations:^{ [self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height - ButtonHeight, ButtonHeight, ButtonHeight)];}
                                            completion:^(BOOL finished){}
                             ];
                        }
         ];
    }
    [self.locationPickerView.tableView reloadData];
    [self.locationPickerView.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self contract];
}

-(void)expand
{
    if(hidden)
        return;
    
    hidden = YES;
    
    [UIView transitionWithView:self.view
                      duration:UINavigationControllerHideShowBarDuration
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{[self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height, ButtonHeight, ButtonHeight)];}
                    completion:^(BOOL finished){}
     ];
}

-(void)contract
{
    if(!hidden)
        return;
    
    hidden = NO;
    
    [UIView transitionWithView:self.view
                      duration:UINavigationControllerHideShowBarDuration
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{[self.buttonsView setFrame:CGRectMake(112, self.view.frame.size.height - ButtonHeight, ButtonHeight, ButtonHeight)];}
                    completion:^(BOOL finished){}
     ];
    
    
}


- (void)insertImageRightInNavBar {
    UIImage *backImage = [UIImage imageNamed:@"oglobo_top_right"];
    CGRect imageFrame = CGRectMake(0, 0, [backImage size].width, [backImage size].height);
    UIButton *button = [[UIButton alloc] initWithFrame:imageFrame];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    [button setImage:backImage forState:UIControlStateDisabled];
    UIBarButtonItem *fakeButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    fakeButtonItem.enabled = NO;
    [[self navigationItem] setRightBarButtonItem:fakeButtonItem animated:NO];
}

-(void)fillData{
    noticias = [[NSArray alloc] initWithObjects:
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla.",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 2",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 3",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 4",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 5",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 6",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 7",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 8",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 9",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 8",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 9",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 8",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 9",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 8",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 9",
                @"Rebouças e Santa Barbara estão engarrafados para o Centro. Opção é a orla. 10"
                , nil];
    transito = [[NSArray alloc] initWithObjects:
                @"transito 1",
                @"transito 2",
                @"transito 3",
                @"transito 4",
                @"transito 5",
                @"transito 6",
                @"transito 7",
                @"transito 8",
                @"transito 9",
                @"transito 10"
                , nil];
    usuarios = [[NSArray alloc] initWithObjects:
                @"usuarios 1",
                @"usuarios 2",
                @"usuarios 3",
                @"usuarios 4",
                @"usuarios 5",
                @"usuarios 6",
                @"usuarios 7",
                @"usuarios 8",
                @"usuarios 9",
                @"usuarios 10"
                , nil];
}

@end

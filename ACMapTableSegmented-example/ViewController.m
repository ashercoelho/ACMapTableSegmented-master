//
//  ViewController.m
//  ACMapTableSegmented-example
//
//  Created by Asher Coelho on 8/1/13.
//  Copyright (c) 2013 Asher Coelho. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()
{
    NSArray *aLatitudes;
    NSArray *aLongitudes;
    NSArray *noticias;
    NSArray *transito;
    NSArray *usuarios;
    
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hidden;
}

@property (nonatomic, strong) NSArray * aTitles;

@end

@implementation ViewController

-(NSArray *)aTitles{
    switch (self.locationPickerView.segmentedControl.selectedSegmentIndex) {
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
    
    aLatitudes = [[NSArray alloc] initWithObjects:
                  [NSNumber numberWithDouble:48.122101],
                  [NSNumber numberWithDouble:48.222201],
                  [NSNumber numberWithDouble:48.322301],
                  [NSNumber numberWithDouble:48.422401],
                  [NSNumber numberWithDouble:48.523101],
                  [NSNumber numberWithDouble:48.623201],
                  [NSNumber numberWithDouble:48.723301],
                  [NSNumber numberWithDouble:48.823401],
                  [NSNumber numberWithDouble:48.924101],
                  [NSNumber numberWithDouble:49.025101]
                  , nil];
    
    aLongitudes = [[NSArray alloc] initWithObjects:
                   [NSNumber numberWithDouble:11.601563],
                   [NSNumber numberWithDouble:11.701663],
                   [NSNumber numberWithDouble:11.801763],
                   [NSNumber numberWithDouble:11.901863],
                   [NSNumber numberWithDouble:12.001963],
                   [NSNumber numberWithDouble:12.101563],
                   [NSNumber numberWithDouble:12.201663],
                   [NSNumber numberWithDouble:12.301763],
                   [NSNumber numberWithDouble:12.401863],
                   [NSNumber numberWithDouble:12.501963],
                   [NSNumber numberWithDouble:12.602563]
                   , nil];
    
    noticias = [[NSArray alloc] initWithObjects:
                @"noticia 1",
                @"noticia 2",
                @"noticia 3",
                @"noticia 4",
                @"noticia 5",
                @"noticia 6",
                @"noticia 7",
                @"noticia 8",
                @"noticia 9",
                @"noticia 8",
                @"noticia 9",
                @"noticia 8",
                @"noticia 9",
                @"noticia 8",
                @"noticia 9",
                @"noticia 10"
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
    
    // The LocationPickerView can be created programmatically (see below) or
    // using Storyboards/XIBs (see Storyboard file).
    self.locationPickerView = [[LocationPickerView alloc] initWithFrame:self.view.bounds];
    self.locationPickerView.tableViewDataSource = self;
    self.locationPickerView.tableViewDelegate = self;
    
    // Optional parameters
    self.locationPickerView.delegate = self;
    self.locationPickerView.shouldCreateHideMapButton = YES;
    self.locationPickerView.pullToExpandMapEnabled = YES;
    self.locationPickerView.defaultMapHeight = 220.0; // larger than normal
    self.locationPickerView.parallaxScrollFactor = 0.3; // little slower than normal.
    
    [self.view addSubview:self.locationPickerView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:hidden
                                             animated:YES];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.tabBarController setTabBarHidden:hidden
//                                  animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource
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
    
    return cell;
}

#pragma mark - TableView Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LocationPicker Delegate
-(void)segmentedControlIndexChanged
{
    [self.locationPickerView.tableView reloadData];
}
-(NSArray *)segmentedControlItens{
    return [NSArray arrayWithObjects: @"Notícias", @"Trânsito", @"Usuários", nil];
}

#pragma mark - The Magic!

-(void)expand
{
    if(hidden)
        return;
    
    hidden = YES;
    
//    [self.tabBarController setTabBarHidden:YES
//                                  animated:YES];
    
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
}

-(void)contract
{
    if(!hidden)
        return;
    
    hidden = NO;
    
//    [self.tabBarController setTabBarHidden:NO
//                                  animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO
                                             animated:YES];
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
    //NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat differenceFromStart = startContentOffset - currentOffset;
    CGFloat differenceFromLast = lastContentOffset - currentOffset;
    lastContentOffset = currentOffset;
    
    
    
    if((differenceFromStart) < 0)
    {
        // scroll up
//        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self expand];
    }
    else {
//        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self contract];
    }
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [self contract];
    return YES;
}


@end

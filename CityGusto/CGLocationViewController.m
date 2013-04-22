//
//  CGLocationViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/27/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocationViewController.h"
#import "CGRestaurantParameter.h"

@interface CGLocationViewController ()

@end

@implementation CGLocationViewController

@synthesize locations;

@synthesize delegate = _delegate;


- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    self.locations = [[NSMutableArray alloc] init];
    [self.locations addObject:@"Current Location"];
    [self.locations addObject:@"Boston - All"];
    [self.locations addObject:@"Boston - Allston"];
    [self.locations addObject:@"Boston - Back Bay"];
    [self.locations addObject:@"Boston - Beacon Hill"];
    [self.locations addObject:@"Boston - Brighton"];
    [self.locations addObject:@"Boston - Charlestown"];
    [self.locations addObject:@"Boston - Chinatown"];
    [self.locations addObject:@"Boston - Downtown"];
    [self.locations addObject:@"Boston - East Boston"];
    [self.locations addObject:@"Boston - Fenway/Kenmore"];
    [self.locations addObject:@"Boston - North End"];
    [self.locations addObject:@"Boston - South Boston"];
    [self.locations addObject:@"Boston - South End"];
    [self.locations addObject:@"Brookline"];
    [self.locations addObject:@"Cambridge - All"];
    [self.locations addObject:@"Cambridge - Central Square"];
    [self.locations addObject:@"Cambridge - East Cambridge"];
    [self.locations addObject:@"Cambridge - Harvard Square"];
    [self.locations addObject:@"Cambridge - Huron Village"];
    [self.locations addObject:@"Cambridge - Inman Square"];
    [self.locations addObject:@"Cambridge - Kendall Square/MIT"];
    [self.locations addObject:@"Cambridge - North Cambridge"];
    [self.locations addObject:@"Cambridge - Porter Square"];
    [self.locations addObject:@"Somerville"];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.locations objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0){
        [CGRestaurantParameter shared].useCurrentLocation = YES;
    }else if (indexPath.row == 1){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:nil];
    }else if (indexPath.row == 2){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:9]];
    }else if (indexPath.row == 3){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:16]];
    }else if (indexPath.row == 4){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:17]];
    }else if (indexPath.row == 5){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:10]];
    }else if (indexPath.row == 6){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:19]];
    }else if (indexPath.row == 7){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:14]];
    }else if (indexPath.row == 8){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:15]];
    }else if (indexPath.row == 9){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:20]];
    }else if (indexPath.row == 10){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:13]];
    }else if (indexPath.row == 11){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:18]];
    }else if (indexPath.row == 12){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:12]];
    }else if (indexPath.row == 13){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:4] neighborhoodId:[NSNumber numberWithInt:11]];
    }else if (indexPath.row == 14){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:2] neighborhoodId:nil];
    }else if (indexPath.row == 15){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:3] neighborhoodId:[NSNumber numberWithInt:3]];
    }else if (indexPath.row == 16){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:3] neighborhoodId:[NSNumber numberWithInt:2]];
    }else if (indexPath.row == 17){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:3] neighborhoodId:[NSNumber numberWithInt:5]];
    }else if (indexPath.row == 18){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:3] neighborhoodId:[NSNumber numberWithInt:7]];
    }else if (indexPath.row == 19){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:3] neighborhoodId:[NSNumber numberWithInt:4]];
    }else if (indexPath.row == 20){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:3] neighborhoodId:[NSNumber numberWithInt:1]];
    }else if (indexPath.row == 21){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:3] neighborhoodId:[NSNumber numberWithInt:8]];
    }else if (indexPath.row == 22){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:3] neighborhoodId:[NSNumber numberWithInt:6]];
    }else if (indexPath.row == 23){
        [[CGRestaurantParameter shared] changeLocation:[NSNumber numberWithInt:1] neighborhoodId:nil];
    }
    
    [self.delegate locationChanged];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

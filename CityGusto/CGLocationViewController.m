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
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    params.useCurrentLocation = NO;

    if (indexPath.row == 0){
        [CGRestaurantParameter shared].useCurrentLocation = YES;
        [[CGRestaurantParameter shared] changeLocation];
    }else if (indexPath.row == 1){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = nil;
        [params changeLocation];
    }else if (indexPath.row == 2){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:9];
        [params changeLocation];
    }else if (indexPath.row == 3){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:16];
        [params changeLocation];
    }else if (indexPath.row == 4){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:17];
        [params changeLocation];
    }else if (indexPath.row == 5){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:10];
        [params changeLocation];
    }else if (indexPath.row == 6){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:19];
        [params changeLocation];
    }else if (indexPath.row == 7){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:14];
        [params changeLocation];
    }else if (indexPath.row == 8){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:15];
        [params changeLocation];
    }else if (indexPath.row == 9){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:20];
        [params changeLocation];
    }else if (indexPath.row == 10){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:13];
        [params changeLocation];
    }else if (indexPath.row == 11){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:18];
        [params changeLocation];
    }else if (indexPath.row == 12){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:12];
        [params changeLocation];
    }else if (indexPath.row == 13){
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:11];
        [params changeLocation];
    }else if (indexPath.row == 14){
        params.cityId = [NSNumber numberWithInt:2];
        params.neighborhoodId = nil;
        [params changeLocation];
    }else if (indexPath.row == 15){
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:3];
        [params changeLocation];
    }else if (indexPath.row == 16){
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:2];
        [params changeLocation];
    }else if (indexPath.row == 17){
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:5];
        [params changeLocation];
    }else if (indexPath.row == 18){
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:7];
        [params changeLocation];
    }else if (indexPath.row == 19){
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:4];
        [params changeLocation];
    }else if (indexPath.row == 20){
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:1];
        [params changeLocation];
    }else if (indexPath.row == 21){
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:8];
        [params changeLocation];
    }else if (indexPath.row == 22){
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:6];
        [params changeLocation];
    }else if (indexPath.row == 23){
        params.cityId = [NSNumber numberWithInt:1];
        params.neighborhoodId = nil;
        [params changeLocation];
    }
    
    [self.delegate locationChanged];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

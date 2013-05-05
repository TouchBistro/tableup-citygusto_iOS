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
    [self.locations addObject:@"Current Location"]; // 0
    [self.locations addObject:@"Boston - All"]; // 1
    [self.locations addObject:@"Boston - Allston"]; // 2
    [self.locations addObject:@"Boston - Back Bay"]; // 3
    [self.locations addObject:@"Boston - Beacon Hill"]; // 4
    [self.locations addObject:@"Boston - Brighton"]; // 5
    [self.locations addObject:@"Boston - Charlestown"]; // 6
    [self.locations addObject:@"Boston - Chinatown"]; // 7
    [self.locations addObject:@"Boston - Downtown"]; // 8
    [self.locations addObject:@"Boston - East Boston"]; // 9
    [self.locations addObject:@"Boston - Fenway/Kenmore"]; // 10
    [self.locations addObject:@"Boston - North End"]; // 11
    [self.locations addObject:@"Boston - South Boston"]; // 12
    [self.locations addObject:@"Boston - South End"]; // 13
    [self.locations addObject:@"Brookline"]; // 14
    [self.locations addObject:@"Cambridge - All"]; // 15
    [self.locations addObject:@"Cambridge - Central Square"]; // 16
    [self.locations addObject:@"Cambridge - East Cambridge"]; // 17
    [self.locations addObject:@"Cambridge - Harvard Square"]; // 18
    [self.locations addObject:@"Cambridge - Huron Village"]; // 19
    [self.locations addObject:@"Cambridge - Inman Square"]; // 20
    [self.locations addObject:@"Cambridge - Kendall Square/MIT"]; // 21
    [self.locations addObject:@"Cambridge - North Cambridge"]; // 22
    [self.locations addObject:@"Cambridge - Porter Square"]; // 23
    [self.locations addObject:@"Somerville"]; // 24
    
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

    if (indexPath.row == 0){ //current location
        [CGRestaurantParameter shared].useCurrentLocation = YES;
        [[CGRestaurantParameter shared] changeLocation];
    }else if (indexPath.row == 1){ //boston all
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = nil;
        [params changeLocation];
    }else if (indexPath.row == 2){ //allston
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:9];
        [params changeLocation];
    }else if (indexPath.row == 3){ //back bacy
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:16];
        [params changeLocation];
    }else if (indexPath.row == 4){ //beacon hill
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:17];
        [params changeLocation];
    }else if (indexPath.row == 5){ //brighton
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:10];
        [params changeLocation];
    }else if (indexPath.row == 6){ //charlestown
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:19];
        [params changeLocation];
    }else if (indexPath.row == 7){ //chinatown
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:14];
        [params changeLocation];
    }else if (indexPath.row == 8){ //downtown
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:15];
        [params changeLocation];
    }else if (indexPath.row == 9){ //east boston
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:20];
        [params changeLocation];
    }else if (indexPath.row == 10){ //fenway
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:13];
        [params changeLocation];
    }else if (indexPath.row == 11){ //north end
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:18];
        [params changeLocation];
    }else if (indexPath.row == 12){ //south boston
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:12];
        [params changeLocation];
    }else if (indexPath.row == 13){ //south end
        params.cityId = [NSNumber numberWithInt:4];
        params.neighborhoodId = [NSNumber numberWithInt:11];
        [params changeLocation];
    }else if (indexPath.row == 14){ //brookline
        params.cityId = [NSNumber numberWithInt:2];
        params.neighborhoodId = nil;
        [params changeLocation];
    }else if (indexPath.row == 15){ //cambride all
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = nil;
        [params changeLocation];
    }else if (indexPath.row == 16){ //central square
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:3];
        [params changeLocation];
    }else if (indexPath.row == 17){ // east cambridge
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:2];
        [params changeLocation];
    }else if (indexPath.row == 18){ // harvard square
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:5];
        [params changeLocation];
    }else if (indexPath.row == 19){ //huron village
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:7];
        [params changeLocation];
    }else if (indexPath.row == 20){ //inman square
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:4];
        [params changeLocation];
    }else if (indexPath.row == 21){ //kendall/mit
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:1];
        [params changeLocation];
    }else if (indexPath.row == 22){ //north cambridge
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:8];
        [params changeLocation];
    }else if (indexPath.row == 23){ //porter square
        params.cityId = [NSNumber numberWithInt:3];
        params.neighborhoodId = [NSNumber numberWithInt:6];
        [params changeLocation];
    }else if (indexPath.row == 24){ //somerville
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

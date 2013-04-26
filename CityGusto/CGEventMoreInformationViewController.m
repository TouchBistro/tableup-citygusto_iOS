//
//  CGEventMoreInformationViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGInformationCell.h"
#import "CGInformation.h"
#import "CGEventMoreInformationViewController.h"

@interface CGEventMoreInformationViewController ()

@end

@implementation CGEventMoreInformationViewController

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    self.rows = [[NSMutableArray alloc] init];
    if (self.selectedEvent.description){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Description" value:self.selectedEvent.description]];
    }
    
    if (self.selectedEvent.eventCategoryString){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Categories" value:self.selectedEvent.eventCategoryString]];
    }
    
    if (self.selectedEvent.eventTagString){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Tags" value:self.selectedEvent.eventTagString]];
    }
    
    if (self.selectedEvent.price){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Price" value:self.selectedEvent.price]];
    }
    
    if (self.selectedEvent.occurrenceString){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Occurrences" value:self.selectedEvent.occurrenceString]];
    }
    
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
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventInfoCell";
    CGInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *viewsToRemove = [cell.valueView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    cell.headerLabel.text = @"";
    cell.valueLabel.text = @"";
    
    CGInformation *info = [self.rows objectAtIndex:indexPath.row];
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 194, 180)];
    valueLabel.text = info.value;
    valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [valueLabel setFont:[UIFont systemFontOfSize:13]];
    [valueLabel setBackgroundColor:[UIColor clearColor]];
    
    CGSize size = [info.value sizeWithFont:[UIFont systemFontOfSize:13]
                         constrainedToSize:CGSizeMake(194, 5000.0f)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect newFrame = valueLabel.frame;
    newFrame.size.height = size.height;
    valueLabel.frame = newFrame;
    valueLabel.numberOfLines = 0;
    [valueLabel sizeToFit];
    [cell.valueView addSubview:valueLabel];
    
    cell.headerLabel.text = info.header;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGInformation *info = [self.rows objectAtIndex:indexPath.row];
    
    CGSize size = [info.value sizeWithFont:[UIFont systemFontOfSize:13]
                         constrainedToSize:CGSizeMake(194, 5000.0f)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return tableView.rowHeight + size.height;
}

@end

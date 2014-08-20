//
//  ViewController.m
//  SwipeToDeleteNotReloading
//
//  Created by Kyle Sluder on 8/19/14.
//  Copyright (c) 2014 The Omni Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableIndexSet *_indices;
}

- (void)viewDidLoad;
{
    _indices = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 6)];
    self.tableView.allowsSelection = NO;
    [self.tableView reloadData];
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _indices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"Vending cell for index path %@", indexPath);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseIdentifier"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReuseIdentifier"];
    
    NSUInteger indexForRowInSet = [_indices indexPassingTest:^BOOL(NSUInteger idx, BOOL *stop) {
        return idx == indexPath.row;
    }];
    
    if (indexForRowInSet == 0)
        cell.textLabel.text = @"Swipe to delete any of the following rows.";
    else
        cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (unsigned long)indexForRowInSet];
    
    cell.backgroundColor = self.editing ? [UIColor lightGrayColor] : [UIColor whiteColor];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_indices removeIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
{
    [super setEditing:editing animated:animated];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

@end

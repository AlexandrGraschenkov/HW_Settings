//
//  SettingsController.m
//  HW_Settings
//
//  Created by Alexander on 05.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "SettingsController.h"
#import "DetailSettingsController.h"
#import "SelectNode.h"
#import "GroupNode.h"
#import "BoolNode.h"
#import "SettingsDataProvider.h"
#import "FirstCell.h"
#import "SecondCell.h"
#import "SwitchCell.h"

@interface SettingsController ()


@end

@implementation SettingsController


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([segue.identifier isEqualToString:@"segueToSettingsController"]) {
        SettingsController *settingsController = segue.destinationViewController;
        GroupNode *groupNode = self.nodes[indexPath.row];
        settingsController.nodes = groupNode.nodes;
    }
    if ([segue.identifier isEqualToString:@"segueToDetail"]) {
        DetailSettingsController *detail = segue.destinationViewController;
        SelectNode *selectNode = self.nodes[indexPath.row];
        detail.node = selectNode;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *defaultCell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
    if ([self.nodes[indexPath.row] isKindOfClass:[GroupNode class]]) {
        GroupNode *groupNode = self.nodes[indexPath.row];
        FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
        cell.title.text = groupNode.title;
        return cell;
    }
    if ([self.nodes[indexPath.row] isKindOfClass:[SelectNode class]]) {
        SelectNode *selectNode = self.nodes[indexPath.row];
        SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
        cell.title.text = (selectNode.title ? selectNode.title : @"No title");
        cell.detailTitle.text = (selectNode.value ? [NSString stringWithFormat:@"%@", selectNode.value] : @"not selected");
        return cell;
    }
    if ([self.nodes[indexPath.row] isKindOfClass:[BoolNode class]]) {
        BoolNode *boolNode = self.nodes[indexPath.row];
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
        cell.title.text = (boolNode.title ? boolNode.title : @"No title");
        [cell.switcher setOn:boolNode.value];
        return cell;
    }
    return defaultCell;
}

- (IBAction)switchMemorize:(UISwitch *)swtch {
    UITableViewCell *switchCell = (UITableViewCell *)swtch.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:switchCell];
    BoolNode *boolNode = self.nodes[indexPath.row];
    boolNode.value = swtch.on;
    [[SettingsDataProvider shared] saveNodes];
}


@end

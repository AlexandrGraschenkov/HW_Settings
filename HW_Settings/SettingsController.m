//
//  SettingsController.m
//  HW_Settings
//
//  Created by Alexander on 05.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "SettingsController.h"
#import "SelectNode.h"
#import "GroupNode.h"
#import "BoolNode.h"
#import "SettingsDataProvider.h"
#import "BaseCell.h"
#import "DetailCell.h"
#import "SwitchCell.h"
#import "DetailsSettingController.h"


@interface SettingsController ()
@end

@implementation SettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *defaultCell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    if ([self.nodes[indexPath.row] isKindOfClass:[GroupNode class]]) {
        GroupNode *groupNode = self.nodes[indexPath.row];
        BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
        cell.tittle.text = (groupNode.title ? groupNode.title : @"No title");
        return cell;
    }
    if ([self.nodes[indexPath.row] isKindOfClass:[SelectNode class]]) {
        SelectNode *selectNode = self.nodes[indexPath.row];
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        cell.textLabel.text = (selectNode.title ? selectNode.title : @"No title");
        cell.titleDetail.text = (selectNode.value ? [NSString stringWithFormat:@"%@", selectNode.value] : @"not selected");
        return cell;
    }
    if ([self.nodes[indexPath.row] isKindOfClass:[BoolNode class]]) {
        BoolNode *boolNode = self.nodes[indexPath.row];
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
        cell.textLabel.text = (boolNode.title ? boolNode.title : @"No title");
        [cell.switcher setOn:boolNode.value];
        return cell;
    }
    return defaultCell;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nodes.count;
}


- (IBAction)switchToggled:(UISwitch *)switcher {
    UITableViewCell *switchCell = (UITableViewCell *)switcher.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:switchCell];
    BoolNode *boolNode = self.nodes[indexPath.row];
    boolNode.value = switcher.on;
    [[SettingsDataProvider shared] saveNodes];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if ([segue.identifier isEqualToString:@"segueToSettingsController"]) {
        SettingsController *settingsController = segue.destinationViewController;
        GroupNode *groupNode = self.nodes[indexPath.row];
        settingsController.nodes = groupNode.nodes;
    }
    if ([segue.identifier isEqualToString:@"segueToDetail"]) {
        DetailsSettingController *detail = segue.destinationViewController;
        SelectNode *selectNode = self.nodes[indexPath.row];
        detail.node = selectNode;
    }
}


@end

//
//  DetailSettingsController.m
//  HW_Settings
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "DetailSettingsController.h"
#import "SettingsDataProvider.h"

@interface DetailSettingsController ()

@end

@implementation DetailSettingsController

-(void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.node.allowedValues.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if ([self.node.value isEqual:self.node.allowedValues[indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    id title = self.node.allowedValues[indexPath.row];
    cell.textLabel.text = (!title ? @"No title" : [NSString stringWithFormat:@"%@", title]);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.node.value isEqual: self.node.allowedValues[indexPath.row]]) {
        self.node.value = nil;
    } else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        self.node.value = self.node.allowedValues[indexPath.row];
    }
    [[SettingsDataProvider shared] saveNodes];
    [self.navigationController popViewControllerAnimated:YES];
}
@end

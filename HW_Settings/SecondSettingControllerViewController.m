//
//  SecondSettingControllerViewController.m
//  HW_Settings
//
//  Created by Admin on 18.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "SecondSettingControllerViewController.h"
#import "SettingsDataProvider.h"
#import "SettingsController.h"

@interface SecondSettingControllerViewController ()

@end

@implementation SecondSettingControllerViewController

- (void)viewDidLoad {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

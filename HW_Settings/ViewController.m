//
//  ViewController.m
//  HW_Settings
//
//  Created by Alexander on 07.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "SettingsDataProvider.h"
#import "SettingsController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"settings"]) {
        SettingsController *settings = segue.destinationViewController;
        settings.nodes = [SettingsDataProvider shared].getNodesModel;
    }
}

@end
//
//  SettingsDataProvider.h
//  HW_Settings
//
//  Created by Alexander on 05.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectNode.h"
#import "BoolNode.h"
#import "GroupNode.h"

@interface SettingsDataProvider : NSObject

+ (instancetype)shared;

- (NSArray *)getNodesModel;
- (void)saveNodes;

@end

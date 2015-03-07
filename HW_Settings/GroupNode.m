//
//  GroupNode.m
//  HW_Settings
//
//  Created by Alexander on 05.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "GroupNode.h"

@implementation GroupNode

- (NSDictionary *)saveValue {
    NSMutableDictionary *saveValuesArray = [NSMutableDictionary new];
    for (BaseNode *n in self.nodes) {
        id saveVal = n.saveValue;
        if (saveVal) {
            [saveValuesArray setObject:n.saveValue forKey:n.userDefaultsKey];
        }
    }
    return saveValuesArray;
}

@end

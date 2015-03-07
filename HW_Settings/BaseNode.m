//
//  BaseObject.m
//  HW_Settings
//
//  Created by Alexander on 05.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "BaseNode.h"

@implementation BaseNode

- (id)initWithKey:(NSString *)userDefKey title:(NSString *)title {
    self = [super init];
    if (self) {
        self.userDefaultsKey = userDefKey;
        self.title = title;
    }
    return self;
}

- (id)saveValue {
    assert(@"Абстрактный метод, необходимо переопределить при наследовании");
    return nil;
}

@end

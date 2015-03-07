//
//  BaseNode.h
//  HW_Settings
//
//  Created by Alexander on 05.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNode : NSObject

- (id)initWithKey:(NSString *)userDefKey title:(NSString *)title;

@property (nonatomic, strong) NSString *userDefaultsKey;
@property (nonatomic, strong) NSString *title;

- (id)saveValue;

@end

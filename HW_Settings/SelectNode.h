//
//  SelectNode.h
//  HW_Settings
//
//  Created by Alexander on 05.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "BaseNode.h"


@interface SelectNode : BaseNode

@property (nonatomic, strong) id value;
@property (nonatomic, strong) NSArray *allowedValues;

@end

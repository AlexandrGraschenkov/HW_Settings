//
//  SettingsDataProvider.m
//  HW_Settings
//
//  Created by Alexander on 05.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "SettingsDataProvider.h"


@implementation SettingsDataProvider
{
    NSArray *_nodes;
}

+ (instancetype)shared
{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

#pragma mark - Save nodes
- (void)saveNodes {
    GroupNode *tempGroup = [GroupNode new];
    tempGroup.nodes = _nodes;
    NSDictionary *saveValue = tempGroup.saveValue;
    
    [[NSUserDefaults standardUserDefaults] setObject:saveValue forKey:@"settings"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Load nodes
- (NSArray *)getNodesModel {
    if (!_nodes) {
        _nodes = [self generateNodesModel];
        NSDictionary *savedValues = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"settings"];
        [self parseDictionary:savedValues toNodes:_nodes];
    }
    return _nodes;
}

- (void)parseDictionary:(NSDictionary *)dic toNodes:(NSArray *)nodes {
    for (BaseNode *n in nodes) {
        [self parseObject:dic[n.userDefaultsKey] toNode:n];
    }
}

- (void)parseObject:(id)obj toNode:(BaseNode *)node {
    if ([obj isKindOfClass:[NSNull class]])
        obj = nil;
    
    if ([node isKindOfClass:[GroupNode class]] && [obj isKindOfClass:[NSDictionary class]]) {
        [self parseDictionary:obj toNodes:((GroupNode *)node).nodes];
    } else if ([node isKindOfClass:[SelectNode class]]) {
        ((SelectNode *)node).value = obj;
    } else if ([node isKindOfClass:[BoolNode class]]) {
        ((BoolNode *)node).value = [obj boolValue];
    }
}

#pragma mark model
- (NSArray *)generateNodesModel {
    GroupNode *groupVideo = [[GroupNode alloc] initWithKey:@"video_settings" title:@"Настройки видео"];
    SelectNode *resolutionSelect = [[SelectNode alloc] initWithKey:@"resolution" title:@"Разрешение"];
    resolutionSelect.allowedValues = @[@"1280x720", @"1024x768", @"800x600"];
    SelectNode *qualitySelect = [[SelectNode alloc] initWithKey:@"quality" title:@"Качество"];
    qualitySelect.allowedValues = @[@"Шикарное", @"Сойдет", @"Не очень"];
    BoolNode *verticalSynchronization = [[BoolNode alloc] initWithKey:@"vert_sync" title:@"Вертикальная синхронизация"];
    groupVideo.nodes = @[resolutionSelect, qualitySelect, verticalSynchronization];
    

    GroupNode *groupAudio = [[GroupNode alloc] initWithKey:@"autdio_settings" title:@"Настройки звука"];
    BoolNode *enableAudio = [[BoolNode alloc] initWithKey:@"enable" title:@"Звук включен"];
    SelectNode *doesntMatter = [[SelectNode alloc] initWithKey:@"sami_pridumaite" title:@"Че нить"];
    doesntMatter.allowedValues = @[@"Тут", @"можно", @"написать", @"много", @"вариантов", @"но", @"мы", @"остановимся", @"на", @"десяти"];
    
    GroupNode *secredtGroup = [[GroupNode alloc] initWithKey:@"secret" title:@"Секретная вкладка"];
    SelectNode *selectMostBeatifull = [[SelectNode alloc] initWithKey:@"choosed_someone" title:@"Кто красивше?"];
    selectMostBeatifull.allowedValues = @[@"Natalie Portman", @"Keira Knightley", @"Charlize Theron", @"Emmanuelle Vaugier", @"Angelina Jolie", @"Lizzy Caplan", @"Marion Cotillard", @"Путин"];
    SelectNode *fuckingDress = [[SelectNode alloc] initWithKey:@"dress_color" title:@"Какого цвета платье?"];
    fuckingDress.allowedValues = @[@"Ваще пофигу"];
    secredtGroup.nodes = @[selectMostBeatifull, fuckingDress];
    
    groupAudio.nodes = @[enableAudio, doesntMatter, secredtGroup];
    
    BoolNode *geoBoolNode = [[BoolNode alloc] initWithKey:@"geo" title:@"Определять геопозицию"];
    
    return @[groupVideo, groupAudio, geoBoolNode];
}

@end

//
//  QiushiComentsModel.h
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiushiComentsModel : NSObject
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userIcon;
@property(nonatomic,retain)UIImage  *iconImage;
@property int floor;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

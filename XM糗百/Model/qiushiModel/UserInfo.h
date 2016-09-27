//
//  UserInfo.h
//  qiushibaikeProject
//
//  Created by  on 14-9-21.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
{
    NSString *userID;
}
@property(nonatomic,strong)NSString *userName;      //用户名
@property(nonatomic,strong)NSString *signature;     //个性签名
@property(nonatomic,strong)NSString *gender;        //性别
@property(nonatomic,strong)NSString *astrology;     //星座
@property(nonatomic,strong)NSString *hobby;         //兴趣爱好
@property(nonatomic,strong)NSString *location;      //位置
@property(nonatomic,strong)NSString *haunt;         //常出没地
@property(nonatomic,strong)NSString *hometown;      //家乡
@property(nonatomic,strong)NSString *introduce;     //介绍
@property(nonatomic,strong)NSString *mobile_brand;  //手机品牌
@property (nonatomic,copy) UIImage *userIcon;       //用户他头像
@property int age;                                  //年龄
@property(nonatomic,retain)NSNumber *createTime;    //创建账号时间
@property (nonatomic, assign)NSInteger qb_age;      //糗龄  -- 计量为1个月  12个月以上按年算  一年以下按月算
@property (nonatomic, assign)NSInteger qs_count;    //发表糗事条数
@property(nonatomic,strong)NSString *job;           //工作
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

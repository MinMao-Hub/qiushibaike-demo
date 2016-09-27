//
//  QiuShi.h
//

#import <Foundation/Foundation.h>

@interface QiuShi : NSObject
{
    //小图片链接地址
    NSString *imageURL;
    //大图片链接地址
    NSString *largeImageURL;
    //图片
    UIImage  *contentImage;
    //糗事id
    NSString *qiushiID;
    //内容
    NSString *content;
    //评论数量
    int commentsCount;
    //顶的数量
    int upCount;
    //踩的数量
    int downCount;
    //作者
    NSString *userName;
    NSString *userID;
    NSString *userIcon;
    UIImage *iconImage;
    //image大小
    int imageWidth;
    int imageHeight;
    
 
    
}

@property (nonatomic,copy) NSString *imageURL;
@property (nonatomic,copy) NSString *largeImageURL;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *qiushiID;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) int commentsCount;
@property (nonatomic,assign) int downCount;
@property (nonatomic,assign) int upCount;
@property (nonatomic,copy) NSString *userIcon;
@property (nonatomic,assign) int imageWidth;
@property (nonatomic,assign) int imageHeight;
@property (nonatomic,retain) UIImage *iconImage;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

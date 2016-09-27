//
//  QiuShi.m
//
//

#import "QiuShi.h"
#import "ASIFormDataRequest.h"

@implementation QiuShi
@synthesize userName;
@synthesize imageURL;
@synthesize largeImageURL;
@synthesize userID;
@synthesize qiushiID;
@synthesize content;
@synthesize commentsCount;
@synthesize downCount,upCount;
@synthesize userIcon;
@synthesize imageWidth;
@synthesize imageHeight;
@synthesize iconImage;


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.qiushiID = [[dictionary objectForKey:@"id"] stringValue];
        self.content = [dictionary objectForKey:@"content"];
        self.commentsCount = [[dictionary objectForKey:@"comments_count"] intValue];
        
        id image = [dictionary objectForKey:@"image"];
        if ((NSNull *)image != [NSNull null]) 
        {
            NSInteger index = 3;
            if (qiushiID.length == 7) {
                index = 3;
            }else if (qiushiID.length == 8){
                index = 4;
            }else if (qiushiID.length == 9){
                index = 5;
            }else if (qiushiID.length == 10){
                index = 6;
            }
            NSString *headString=[qiushiID substringToIndex:index];
            NSString *newImageURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/pictures/%@/%@/small/%@",headString,qiushiID,image];
/*            NSURL *url=[NSURL URLWithString:newImageURL];
            __weak ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
            request.requestMethod=@"GET";
            request.timeOutSeconds=60;
            [request setCompletionBlock:^{
                NSData *data= request.responseData;
                UIImage *imagecontent=[UIImage imageWithData:data];
                self.contentImage=imagecontent;

            }];
            [request startAsynchronous];
            
*/
            self.imageURL = newImageURL;
            
            
            NSString *largeHeadString=[qiushiID substringToIndex:index];
            NSString *newLargeImageURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/pictures/%@/%@/medium/%@",largeHeadString,qiushiID,image];
            self.largeImageURL = newLargeImageURL;
        }
        
        NSDictionary *vote = [NSDictionary dictionaryWithDictionary:[dictionary objectForKey:@"votes"]];
        self.downCount = [[vote objectForKey:@"down"]intValue];
        self.upCount = [[vote objectForKey:@"up"]intValue];
        
        //用户
        id user = [dictionary objectForKey:@"user"];
        if ((NSNull *)user != [NSNull null]) 
        {
            NSDictionary *user = [NSDictionary dictionaryWithDictionary:[dictionary objectForKey:@"user"]];
            self.userName=[user objectForKey:@"login"];
            self.userID=[[user objectForKey:@"id"] stringValue];
            //头像
            if ((NSNull *)[user objectForKey:@"icon"] != [NSNull null])
            {
                NSString *headString=nil;;
                if (userID.length == 7) {
                    headString=[userID substringToIndex:3];
                }else if (userID.length == 8){
                    headString=[userID substringToIndex:4];
                }else if (qiushiID.length == 9){
                    headString=[userID substringToIndex:5];
                }else if (qiushiID.length == 10){
                    headString=[userID substringToIndex:6];
                }
                
                NSString *newUserURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@",headString,userID,[user objectForKey:@"icon"]];
/*                NSURL *url=[NSURL URLWithString:newUserURL];
                __weak ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
                request.requestMethod=@"GET";
                request.timeOutSeconds=60;
                [request setCompletionBlock:^{
                NSData *data= request.responseData;
                UIImage *imageHead=[UIImage imageWithData:data];
                self.iconImage=imageHead;
                    }];
                [request startAsynchronous];
*/
                self.userIcon=newUserURL;
            }else{
                self.userIcon = nil;
            }
        }
        //图片大小
        NSDictionary *imagDic=[dictionary objectForKey:@"image_size"];
        if ((NSNull *)imagDic != [NSNull null]) 
        {   NSArray *imageMinArr=[imagDic objectForKey:@"s"];
            self.imageWidth=[[imageMinArr objectAtIndex:0] intValue];
            self.imageHeight=[[imageMinArr objectAtIndex:1]intValue];
        }
    }
    return self;
}




@end

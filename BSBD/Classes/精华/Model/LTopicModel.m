//
//  LTopicModel.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/10.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LTopicModel.h"

@implementation LTopicModel
{
    CGFloat _cellHeight;
}
/**
 * 这个方法去判断时间显示的格式，写在get方法里面主要是时间改变，会自动的刷新对应的格式
 */
- (NSString *)create_time{
    //NSdate
    //创建如期
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //日期格式化
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //发帖时间
    NSDate *create = [fmt dateFromString:_create_time];
    /**
     *  今年
     今天
     几小时前 ->xx小时前
     几分钟前 ->xx分钟前
     几秒前 ->刚刚
     昨天
     昨天 HH:mm:ss
     其他
     MM-dd HH:mm:ss
     非今年
     直接返回服务器的时间->yyyy-MM-dd HH:mm:ss
     */
    if (create.isThisYear) {
        if (create.isToday) {
            //
            NSDateComponents *cmps = [[NSDate date] time_intervalFrom:create];
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if (create.isYesterday){
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else{
        //不是今年
        return _create_time;
    }
}


- (CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * Cell_Margin, MAXFLOAT);
        CGFloat text_height = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]} context:nil].size.height;
        _cellHeight = Cell_TextY+text_height+Cell_Margin/2;//这个添加主要是cell的内容会自动的压缩，防止显示不全(服务器返回的数据，还是会出现一点小小的问题)
        //根据段子的类型来判断高度
        if (self.type == TopicTypePicture) {
            if (self.width!=0 && self.height!=0) {
            
            CGFloat imageW = maxSize.width;
            CGFloat imageH = self.height * imageW /self.width;
            //判断是否为大图
            if (imageH >= Cell_MaxHeight) {
                imageH = Cell_DefaultHeight;
                self.bigPicture = YES;
            }
            CGFloat pictureX = Cell_Margin;
            CGFloat pictureY = Cell_TextY + text_height + Cell_Margin;
            _pictureFrame = CGRectMake(pictureX, pictureY, imageW, imageH);
            _cellHeight += imageH + Cell_Margin;
            
            }
        }else if (self.type == TopicTypeVideo){
            CGFloat videoW = maxSize.width;
            CGFloat videoH = self.height * videoW /self.width;
            CGFloat videoX = Cell_Margin;
            CGFloat videoY = Cell_TextY + text_height + Cell_Margin;
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + Cell_Margin;
        }else if (self.type == TopicTypeVoice){
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = self.height * voiceW /self.width;
            CGFloat voiceX = Cell_Margin;
            CGFloat voiceY = Cell_TextY + text_height + Cell_Margin;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + Cell_Margin;
        }
        _cellHeight += Cell_BottonBarH + Cell_Margin;
    }
    
    return _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image" :@"image0",
             @"middle_image" :@"image2",
             @"large_image" :@"image1",
             @"ID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : @"LTopicNewModel"};
}
/** readOnly的时候，只会生成的对应的get方法不会生成对应的带下划线的实例变量 */
@end

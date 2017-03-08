//
//  LTopicModel.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/10.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LTopicNewModel;
@interface LTopicModel : NSObject

/*! @brief id  */
@property (nonatomic ,copy) NSString *ID;
/*! @brief 名称  */
@property (nonatomic ,copy) NSString *name;
/*! @brief 创建时间 */
@property (nonatomic ,copy) NSString *create_time;
/*! @brief 头像的URL  */
@property (nonatomic ,copy) NSString *profile_image;
/*! @brief 内容  */
@property (nonatomic ,copy) NSString *text;
/*! @brief 顶  */
@property (nonatomic ,assign) NSInteger ding;
/*! @brief 踩  */
@property (nonatomic ,assign) NSInteger cai;
/*! @brief 转发的数量  */
@property (nonatomic ,assign) NSInteger repost;
/*! @brief 评论的数量  */
@property (nonatomic ,assign) NSInteger comment;
/*! @brief V  */
@property (nonatomic ,assign,getter=isJie_v) BOOL jie_v;
/*! @brief 图片宽度  */
@property (nonatomic ,assign) CGFloat width;
/*! @brief 图片高度  */
@property (nonatomic ,assign) CGFloat height;
/*! @brief 小图片  */
@property (nonatomic ,copy) NSString *small_image;
/*! @brief 小图片  */
@property (nonatomic ,copy) NSString *middle_image;
/*! @brief 小图片  */
@property (nonatomic ,copy) NSString *large_image;
/*! @brief 段子类型  */
@property (nonatomic ,assign) TopicType type;
/** 播放次数  */
@property (nonatomic ,assign) NSInteger playcount;
/** 音频的时长  */
@property (nonatomic ,assign) NSInteger voicetime;
/** 音频时长  */
@property (nonatomic ,assign) NSInteger videotime;
/** 真实播放次数  */
@property (nonatomic ,assign) NSInteger playfcount;
/** 热门评论  */
@property (nonatomic ,strong) NSArray *top_cmt;
/** 视频url  */
@property (nonatomic ,copy) NSString *videouri;
/** 音频url  */
@property (nonatomic ,copy) NSString *voiceuri;


/** 辅助：返回cell的高度*/
@property (nonatomic ,assign ,readonly) CGFloat cellHeight;
/*! @brief 图片控件的frame  */
@property (nonatomic ,assign ,readonly) CGRect pictureFrame;
/** 是否为大图  */
@property (nonatomic ,assign ,getter=isBigPicture) BOOL bigPicture;
/** @brief 进度值  */
@property (nonatomic ,assign) CGFloat pictureProgress;
/*! @brief 视频控件的frame  */
@property (nonatomic ,assign ,readonly) CGRect videoFrame;
/*! @brief 视频控件的frame  */
@property (nonatomic ,assign ,readonly) CGRect voiceFrame;
/** 是否音频在播放  */
@property (nonatomic ,assign) BOOL isVideoPlaying;
@end

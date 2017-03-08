
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TopicTypeAll = 1,
    TopicTypePicture = 10,
    TopicTypeWord =29 ,
    TopicTypeVoice = 31,
    TopicTypeVideo = 41
} TopicType;

UIKIT_EXTERN CGFloat const TitlesViewH ;
UIKIT_EXTERN CGFloat const TitlesViewY ;
UIKIT_EXTERN CGFloat const Cell_TextY ;
UIKIT_EXTERN CGFloat const Cell_BottonBarH ;
UIKIT_EXTERN CGFloat const Cell_Margin ;

/** 图片设置的最大的尺寸 */
UIKIT_EXTERN CGFloat const Cell_MaxHeight ;
/** 超过最大尺寸设置为默认的高度 */
UIKIT_EXTERN CGFloat const Cell_DefaultHeight ;

/** 人们评论男女  */
UIKIT_EXTERN NSString *const TopCommentSexM ;
UIKIT_EXTERN NSString *const TopCommentSexF;


/** 添加标签margin  */
UIKIT_EXTERN CGFloat const addTags_margin;
/** 标签按钮的高度  */
UIKIT_EXTERN CGFloat const TagsButton_Height;
//视频播放
UIKIT_EXTERN NSString * const NSNotificationVideoPlaying;

//我的模块方块的列数
UIKIT_EXTERN int const maxCols;

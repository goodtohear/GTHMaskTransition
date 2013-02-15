//
//  GTHMaskTransition.h
//  Pods
//
//  Created by Michael Forrest on 14/02/2013.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    GTHMaskTransitionOriginLeft,
    GTHMaskTransitionOriginRight
} GTHMaskTransitionOrigin;

@interface GTHMaskTransition : NSObject
@property (nonatomic, strong) UIView  * view;
@property (copy) void (^completion)();
@property (nonatomic, strong) NSValue * startBounds;
@property (nonatomic, strong) NSValue * endBounds;
@property (readwrite) CGPoint anchorPoint;
@property (readwrite) CGPoint position;


+(GTHMaskTransition*) reveal:(UIView*)view from:(GTHMaskTransitionOrigin)origin complete: (void(^)())completion;
+(GTHMaskTransition*) hide:(UIView*)view from:(GTHMaskTransitionOrigin)origin complete: (void(^)())completion;


- (id)initWithView: (UIView *)view andCompletion:(void (^)())completion;
@end

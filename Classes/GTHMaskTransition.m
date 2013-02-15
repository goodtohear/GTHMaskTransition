//
//  GTHMaskTransition.m
//  Pods
//
//  Created by Michael Forrest on 14/02/2013.
//
//

#import "GTHMaskTransition.h"
#import <QuartzCore/QuartzCore.h>
@implementation GTHMaskTransition{
    CALayer * mask;
}

- (id)initWithView: (UIView *)view andCompletion:(void (^)())completion
{
    self = [super init];
    if (self) {
        self.view = view;
        self.completion = completion;
    }
    return self;
}
-(void)run{
    mask = [CALayer layer];
    mask.backgroundColor = [UIColor redColor].CGColor;
    mask.anchorPoint = self.anchorPoint;
    mask.position = self.position;
    self.view.layer.mask = mask;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.duration = 0.3;
    animation.fromValue = self.startBounds;
    animation.toValue = self.endBounds;
    animation.delegate = self;
    
    mask.bounds = [self.endBounds CGRectValue];
    [mask addAnimation:animation forKey:@"bounds"];


}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.completion();
    [mask removeFromSuperlayer];
}
-(void)setOrigin:(GTHMaskTransitionOrigin)origin{
    if(origin == GTHMaskTransitionOriginRight){
        self.anchorPoint = CGPointMake(1.0, 0);
        self.position = CGPointMake(self.view.frame.size.width, 0);
    }else{
        self.anchorPoint = CGPointZero;
        self.position = CGPointZero;
    }
}

+(GTHMaskTransition*)reveal:(UIView *)view from:(GTHMaskTransitionOrigin)origin complete:(void (^)())completion{
    GTHMaskTransition * result = [[GTHMaskTransition alloc] initWithView: view andCompletion: completion];
    result.startBounds = [NSValue valueWithCGRect:(CGRect){CGPointZero, CGSizeMake(0, view.frame.size.height)}];
    result.endBounds =  [NSValue valueWithCGRect:(CGRect){CGPointZero, view.frame.size}];
    [result setOrigin: origin];
    [result run];
    return  result;
}

+(GTHMaskTransition*)hide:(UIView *)view from:(GTHMaskTransitionOrigin)origin complete:(void (^)())completion{
    GTHMaskTransition * result = [[GTHMaskTransition alloc] initWithView: view andCompletion: completion];
    result.startBounds =  [NSValue valueWithCGRect:(CGRect){CGPointZero, view.frame.size}];
    result.endBounds =  [NSValue valueWithCGRect:(CGRect){CGPointZero, CGSizeMake(0, view.frame.size.height)}];
    [result setOrigin: origin];
    [result run];
    return  result;
}
@end

/*
* This header is generated by classdump-dyld 1.0
* on Wednesday, November 15, 2023 at 5:37:02â€¯PM Eastern European Standard Time
* Operating System: Version 17.1 (Build 21B74)
* Image Source: /System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore
* classdump-dyld is licensed under GPLv3, Copyright Â© 2013-2016 by Elias Limneos.
*/

#import "_UIVisualEffectSubview.h"

@class _UIVisualEffectViewBackdropCaptureGroup, CABackdropLayer;

@interface _UIVisualEffectBackdropView : _UIVisualEffectSubview {

	_UIVisualEffectViewBackdropCaptureGroup* _captureGroup;

}

@property (assign,nonatomic) long long renderMode; 
@property (nonatomic,retain) _UIVisualEffectViewBackdropCaptureGroup * captureGroup; 
@property (nonatomic,readonly) CABackdropLayer * backdropLayer; 
+(Class)layerClass;
-(BOOL)isTransparentFocusItem;
-(_UIVisualEffectViewBackdropCaptureGroup *)captureGroup;
-(void)setCaptureGroup:(_UIVisualEffectViewBackdropCaptureGroup *)arg1 ;
-(long long)renderMode;
-(BOOL)_shouldAnimatePropertyWithKey:(id)arg1 ;
-(void)removeFromCurrentCaptureGroup;
-(void)applyIdentityFilterEffects;
-(void)applyRequestedFilterEffects;
-(void)setRenderMode:(long long)arg1 ;
-(void)willMoveToWindow:(id)arg1 ;
-(CABackdropLayer *)backdropLayer;
-(void)_applyScaleHintAsRequested:(BOOL)arg1 ;
@end


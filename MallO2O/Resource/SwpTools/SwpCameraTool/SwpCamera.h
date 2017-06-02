//
//  SwpCamera.h
//  Swp_song
//
//  Created by songweiping on 16/1/7.
//  Copyright © 2016年 songweiping. All rights reserved.
//
//  @author             --->    swp_song    ( 调用 相机 / 相册  )
//
//  @modification Time  --->    2016-01-08 11:15:11
//
//  @since              --->    1.0.1
//
//  @warning            --->    !!! < SwpCamera 调用 相机 / 相册, plist 文件中 设置 Localized resources can be mixed = YES > !!!

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SwpCamera;


NS_ASSUME_NONNULL_BEGIN

/*! 获取照片成功回调Block !*/
typedef void(^SwpCameraChooseImageSuccessHandle)(SwpCamera *swpCamera, UIImagePickerController * picker, NSDictionary *info, UIImage *chooseImage);
/*! 获取照片成 相册 / 照片 控制器关闭之后 成功回调Block !*/
typedef void(^SwpCameraChooseImagePickerControllerCloseHandle)(SwpCamera *swpCamera, UIImagePickerController *picker, UIImage *chooseImage);

/*! 相册 / 照片 点击取消按钮 回调Block !*/
typedef void(^SwpCameraDidCancelHandle)(SwpCamera *swpCamera, UIImagePickerController *picker);

@protocol SwpCameraDelegate <NSObject>

@optional

/*!
 *  @author swp_song, 2016-01-08 01:57:07
 *
 *  @brief  swpCamera Delegate  ( swpCamera 代理方法 获取 照片 / 相册 成功 调用代理方法 )
 *
 *  @param  swpCamera
 *
 *  @param  picker
 *
 *  @param  info
 *
 *  @param  chooseImage
 *
 *  @since  1.0.1
 */
- (void)swpCamera:(SwpCamera *)swpCamera imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info chooseImageSuccess:(UIImage *)chooseImage;

/*!
 *  @author swp_song, 2016-01-08 01:58:51
 *
 *  @brief  swpCamera Delegate  ( swpCamera 代理方法 获取 照片 / 相册 成功 关闭控制器 调用代理方法 )
 *
 *  @param  swpCamera
 *
 *  @param  picker
 *
 *  @param  chooseImage
 *
 *  @since  1.0.1
 */
- (void)swpCamera:(SwpCamera *)swpCamera pickerControllerClose:(UIImagePickerController *)picker chooseImageSuccess:(UIImage *)chooseImage;

/*!
 *  @author swp_song, 2016-01-08 01:59:12
 *
 *  @brief  swpCamera Delegate  ( swpCamera 代理方法 获取 照片 / 相册 点击取消按钮 调用代理方法 )
 *
 *  @param  swpCamera
 *
 *  @param  picker
 *
 *  @since  1.0.1
 */
- (void)swpCamera:(SwpCamera *)swpCamera imagePickerControllerDidCancel:(UIImagePickerController *)picker;

/*!
 *  @author swp_song, 16-01-08 01:01:46
 *
 *  @brief  swpCamera Delegate  ( swpCamera 代理方法 获取 照片 / 相册 点击取消按钮 关闭控制器 调用代理方法 )
 *
 *  @param  swpCamera
 *
 *  @param  picker
 *
 *  @since  1.0.1
 */
- (void)swpCamera:(SwpCamera *)swpCamera didCancelPickerControllerClose:(UIImagePickerController *)picker;



@end


@interface SwpCamera : NSObject

/*!
 *  @author swp_song, 16-03-16 11:03:00
 *
 *  @brief  swpCameraDisplay:title:cameraTitle:photoAlbumTitle:cancelTitle: ( 显示 相机 / 相册 提示框  )
 *
 *  @param  controller
 *
 *  @param  title
 *
 *  @param  cameraTitle
 *
 *  @param  photoAlbumTitle
 *
 *  @param  cancelTitle
 *
 *  @since  1.0.1
 */
- (void)swpCameraDisplay:(UIViewController *)controller title:(nullable NSString *)title cameraTitle:(nullable NSString *)cameraTitle photoAlbumTitle:(nullable NSString *)photoAlbumTitle cancelTitle:(nullable NSString *)cancelTitle;

/*! SwpCamera Delegate !*/
@property (nullable, nonatomic, weak) id<SwpCameraDelegate>delegate;

/*! SwpCamera 设置 系统 相册 导航条 颜色      !*/
@property (nullable, nonatomic, strong) UIColor *swpCameraNavigationBackgroundColor;
/*! SwpCamera 设置 系统 相册 导航条 按钮颜色  !*/
@property (nullable, nonatomic, strong) UIColor *swpCameraNavigationTintColor;

/*!
 *  @author swp_song, 2016-01-08 01:47:19
 *
 *  @brief  setSwpCameraNavigationBackgroundColor   ( SwpCamera 设置 系统 相册 导航条 颜色 )
 *
 *  @param  swpCameraNavigationBackgroundColor
 *
 *  @since  1.0.1
 */
- (void)setSwpCameraNavigationBackgroundColor:(UIColor *)swpCameraNavigationBackgroundColor;
/*!
 *  @author swp_song, 2016-01-08 01:48:06
 *
 *  @brief  setSwpCameraNavigationTintColor     ( SwpCamera 设置 系统 相册 导航条 按钮颜色 )
 *
 *  @param  swpCameraNavigationTintColor
 *
 *  @since  1.0.1
 */
- (void)setSwpCameraNavigationTintColor:(UIColor *)swpCameraNavigationTintColor;

/*!
 *  @author swp_song, 2016-01-08 01:48:44
 *
 *  @brief  swpCameraChooseImageSuccess         ( 获取 照片 成功 回调 )
 *
 *  @param  swpCameraChooseImageSuccessHandle
 *
 *  @since  1.0.1
 */
- (void)swpCameraChooseImageSuccess:(SwpCameraChooseImageSuccessHandle)swpCameraChooseImageSuccessHandle;

/*!
 *  @author swp_song, 2016-01-08 01:50:23
 *
 *  @brief  swpCameraChooseImageSuccessPickerControllerClose    ( 获取 照片 成功 相册 / 相机 关闭之后 回调 )
 *
 *  @param  swpCameraChooseImagePickerControllerCloseHandle
 *
 *  @since  1.0.1
 */
- (void)swpCameraChooseImageSuccessPickerControllerClose:(SwpCameraChooseImagePickerControllerCloseHandle)swpCameraChooseImagePickerControllerCloseHandle;

/*!
 *  @author swp_song, 2016-01-08 01:50:45
 *
 *  @brief  swpCameraDidCancel              ( 相册 / 相机 点击取消 按钮 回调 )
 *
 *  @param  swpCameraDidCancelHandle
 *
 *  @since  1.0.1
 */
- (void)swpCameraDidCancel:(SwpCameraDidCancelHandle)swpCameraDidCancelHandle;

/*!
 *  @author swp_song, 2016-01-08 01:52:18
 *
 *  @brief  swpCameraDidCancelPickerControllerClose     ( 相册 / 相机 点击取消 按钮 关闭之后 回调 )
 *
 *  @param  swpCameraDidCancelPickerControllerCloseHandle
 *
 *  @since  1.0.1
 */
- (void)swpCameraDidCancelPickerControllerClose:(SwpCameraDidCancelHandle)swpCameraDidCancelPickerControllerCloseHandle;

@end
NS_ASSUME_NONNULL_END

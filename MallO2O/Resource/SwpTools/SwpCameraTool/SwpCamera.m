//
//  SwpCamera.m
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


#import "SwpCamera.h"
/*! ---------------------- Tool       ---------------------- !*/
#import "UIColor+SwpColor.h"            // 颜色分类
/*! ---------------------- Tool       ---------------------- !*/

@interface SwpCamera () <UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 添加到当前控制器 !*/
@property (nonatomic, weak  ) UIViewController        *controller;
/*! 相机相册控制器   !*/
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
/*! ---------------------- UI   Property  ---------------------- !*/
#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 截取照片成功 回调block !*/
@property (nonatomic, copy  ) SwpCameraChooseImageSuccessHandle swpCameraChooseImageSuccessHandle;
/*! 截取照片成功 关闭控制器 回调block !*/
@property (nonatomic, copy  ) SwpCameraChooseImagePickerControllerCloseHandle swpCameraChooseImagePickerControllerCloseHandle;
/*! 截取照片点击取消按钮 回调block !*/
@property (nonatomic, copy  ) SwpCameraDidCancelHandle  swpCameraDidCancelHandle;
/*! 截取照片点击取消按钮 关闭控制器 回调block !*/
@property (nonatomic, copy  ) SwpCameraDidCancelHandle  swpCameraDidCancelPickerControllerCloseHandle;
/*! ---------------------- Data Property  ---------------------- !*/
@end

@implementation SwpCamera

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
- (void)swpCameraDisplay:(UIViewController *)controller title:(NSString *)title cameraTitle:(NSString *)cameraTitle photoAlbumTitle:(NSString *)photoAlbumTitle cancelTitle:(NSString *)cancelTitle {
    self.controller = controller;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self showAlertControllerWithTitle:title cameraTitle:cameraTitle photoAlbumTitle:photoAlbumTitle cancelTitle:cancelTitle];
    } else {
        [self showActionSheetWithTitle:title cameraTitle:cameraTitle photoAlbumTitle:photoAlbumTitle cancelTitle:cameraTitle];
    }
}


/*!
 *  @author swp_song
 *
 *  @brief  showActionSheet ( 显示 actionSheet )
 *
 *  @since  1.0.1
 */
- (void)showActionSheetWithTitle:(NSString *)title cameraTitle:(NSString *)cameraTitle photoAlbumTitle:(NSString *)photoAlbumTitle cancelTitle:(NSString *)cancelTitle {
    
    title           = [self checkStringNULL:title defaultValue:@"请选择"];
    cameraTitle     = [self checkStringNULL:cameraTitle defaultValue:@"相机"];
    photoAlbumTitle = [self checkStringNULL:photoAlbumTitle defaultValue:@"相册"];
    cancelTitle     = [self checkStringNULL:cancelTitle defaultValue:@"取消"];
    UIActionSheet *actionSheet   = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cameraTitle destructiveButtonTitle:nil otherButtonTitles:photoAlbumTitle, cancelTitle, nil];
    actionSheet.actionSheetStyle = UIBarStyleBlack;
    [actionSheet showInView:self.controller.view];
}

/*!
 *  @author swp_song
 *
 *  @brief  showAlertController ( 显示 alertController )
 *
 *  @since  1.0.1
 */
- (void)showAlertControllerWithTitle:(NSString *)title cameraTitle:(NSString *)cameraTitle photoAlbumTitle:(NSString *)photoAlbumTitle cancelTitle:(NSString *)cancelTitle {
    
    title           = [self checkStringNULL:title defaultValue:@"请选择"];
    cameraTitle     = [self checkStringNULL:cameraTitle defaultValue:@"相机"];
    photoAlbumTitle = [self checkStringNULL:photoAlbumTitle defaultValue:@"相册"];
    cancelTitle     = [self checkStringNULL:cancelTitle defaultValue:@"取消"];
    
    __weak __typeof(self) vc = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:cameraTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [vc swpCamerashowImagePickerWithType:UIImagePickerControllerSourceTypeCamera openController:vc.controller];
    }];
    
    UIAlertAction *photo  = [UIAlertAction actionWithTitle:photoAlbumTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [vc swpCamerashowImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary openController:vc.controller];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];

    

    [alertController addAction:camera];
    [alertController addAction:photo];
    [alertController addAction:cancel];
                                          
    [self.controller presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UIActionSheet Delegate Methods

/*!
 *  @author swp_song, 2016-01-08 01:39:46
 *
 *  @brief  actionSheet Delegate ( actionSheet 代理方法 点击 对应按钮 调取 相机 / 相册 )
 *
 *  @param  actionSheet
 *
 *  @param  buttonIndex
 *
 *  @since  1.0.1
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // 相机
    if (buttonIndex == 0) [self swpCamerashowImagePickerWithType:UIImagePickerControllerSourceTypeCamera openController:self.controller];
    
    // 相册
    if (buttonIndex == 1) [self swpCamerashowImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary openController:self.controller];
}


/*!
 *  @author swp_song, 2016-01-08 01:41:50
 *
 *  @brief  swpCamerashowImagePickerWithType    ( 打开 相机 或者 相册 )
 *
 *  @param  sourceType
 *
 *  @param  controller
 *
 *  @since  1.0.1
 */
- (void)swpCamerashowImagePickerWithType:(UIImagePickerControllerSourceType)sourceType openController:(UIViewController *)controller {
    
    if (![UIImagePickerController isSourceTypeAvailable:sourceType] ) {
        NSLog(@"使用模拟器无法打开相机");
        return;
    }
    
    self.imagePickerController.sourceType = sourceType;
    [controller presentViewController:self.imagePickerController animated:YES completion:^{}];
}


#pragma mark - UIImagePickerController Delegate Methods
/*!
 *  @author swp_song, 2016-01-08 01:43:05
 *
 *  @brief  imagePickerController Delegate ( imagePickerController 代理方法 照相，选择找照片 成功调用 )
 *
 *  @param  picker
 *
 *  @param  info
 *
 *  @since  1.0.1
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __weak __typeof(self) vc = self;
    if (self.swpCameraChooseImageSuccessHandle) self.swpCameraChooseImageSuccessHandle(self, picker, info, info[UIImagePickerControllerEditedImage]);
    
    if ([self.delegate respondsToSelector:@selector(swpCamera:imagePickerController:didFinishPickingMediaWithInfo:chooseImageSuccess:)]) {
        [vc.delegate swpCamera:vc imagePickerController:picker didFinishPickingMediaWithInfo:info chooseImageSuccess:info[UIImagePickerControllerEditedImage]];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (vc.swpCameraChooseImagePickerControllerCloseHandle) vc.swpCameraChooseImagePickerControllerCloseHandle(vc, picker, info[UIImagePickerControllerEditedImage]);
        if ([vc.delegate respondsToSelector:@selector(swpCamera:pickerControllerClose:chooseImageSuccess:)]) {
            [vc.delegate swpCamera:vc pickerControllerClose:picker chooseImageSuccess:info[UIImagePickerControllerEditedImage]];
        }
    }];
}

/*!
 *  @author swp_song, 2016-01-08 01:44:25
 *
 *  @brief  imagePickerController Delegate ( imagePickerController 代理方法 相机, 相册 关闭之后调用 )
 *
 *  @param  picker
 *
 *  @since  1.0.1
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    __weak __typeof(self) vc = self;
    
    if (self.swpCameraDidCancelHandle) self.swpCameraDidCancelHandle(self, picker);
    if ([self.delegate respondsToSelector:@selector(swpCamera:imagePickerControllerDidCancel:)]) {
        [self.delegate swpCamera:self imagePickerControllerDidCancel:picker];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (vc.swpCameraDidCancelPickerControllerCloseHandle) vc.swpCameraDidCancelPickerControllerCloseHandle(vc, picker);
        if ([vc.delegate respondsToSelector:@selector(swpCamera:didCancelPickerControllerClose:)]) {
            [self.delegate swpCamera:vc didCancelPickerControllerClose:picker];
        }
    }];
}


/*!
 *  @author swp_song, 16-03-16 10:03:11
 *
 *  @brief
 *
 *  @param  checkString
 *
 *  @param  defaultValue
 *
 *  @return
 *
 *  @since  1.0.1
 */
- (NSString *)checkStringNULL:(NSString *)checkString defaultValue:(NSString *)defaultValue {
   return  checkString == nil ? defaultValue : checkString;
}

#pragma mark - Public Tools Methods
/*!
 *  @author swp_song, 2016-01-08 01:47:19
 *
 *  @brief  setSwpCameraNavigationBackgroundColor   ( SwpCamera 设置 系统 相册 导航条 颜色 )
 *
 *  @param  swpCameraNavigationBackgroundColor
 *
 *  @since  1.0.1
 */
- (void)setSwpCameraNavigationBackgroundColor:(UIColor *)swpCameraNavigationBackgroundColor {
    _swpCameraNavigationBackgroundColor                   = swpCameraNavigationBackgroundColor;
    self.imagePickerController.navigationBar.barTintColor = _swpCameraNavigationBackgroundColor;
}

/*!
 *  @author swp_song, 2016-01-08 01:48:06
 *
 *  @brief  setSwpCameraNavigationTintColor     ( SwpCamera 设置 系统 相册 导航条 按钮颜色 )
 *
 *  @param  swpCameraNavigationTintColor
 *
 *  @since  1.0.1
 */
- (void)setSwpCameraNavigationTintColor:(UIColor *)swpCameraNavigationTintColor {
    _swpCameraNavigationTintColor                      = swpCameraNavigationTintColor;
    self.imagePickerController.navigationBar.tintColor = _swpCameraNavigationTintColor;
}


/*!
 *  @author swp_song, 2016-01-08 01:48:44
 *
 *  @brief  swpCameraChooseImageSuccess         ( 获取 照片 成功 回调 )
 *
 *  @param  swpCameraChooseImageSuccessHandle
 *
 *  @since  1.0.1
 */
- (void)swpCameraChooseImageSuccess:(SwpCameraChooseImageSuccessHandle)swpCameraChooseImageSuccessHandle {
    self.swpCameraChooseImageSuccessHandle = swpCameraChooseImageSuccessHandle;
}

/*!
 *  @author swp_song, 2016-01-08 01:50:23
 *
 *  @brief  swpCameraChooseImageSuccessPickerControllerClose    ( 获取 照片 成功 相册 / 相机 关闭之后 回调 )
 *
 *  @param  swpCameraChooseImagePickerControllerCloseHandle
 *
 *  @since  1.0.1
 */
- (void)swpCameraChooseImageSuccessPickerControllerClose:(SwpCameraChooseImagePickerControllerCloseHandle)swpCameraChooseImagePickerControllerCloseHandle {
    self.swpCameraChooseImagePickerControllerCloseHandle = swpCameraChooseImagePickerControllerCloseHandle;
}

/*!
 *  @author swp_song, 2016-01-08 01:50:45
 *
 *  @brief  swpCameraDidCancel              ( 相册 / 相机 点击取消 按钮 回调 )
 *
 *  @param  swpCameraDidCancelHandle
 *
 *  @since  1.0.1
 */
- (void)swpCameraDidCancel:(SwpCameraDidCancelHandle)swpCameraDidCancelHandle {
    self.swpCameraDidCancelHandle = swpCameraDidCancelHandle;
}

/*!
 *  @author swp_song, 2016-01-08 01:52:18
 *
 *  @brief  swpCameraDidCancelPickerControllerClose     ( 相册 / 相机 点击取消 按钮 关闭之后 回调 )
 *
 *  @param  swpCameraDidCancelPickerControllerCloseHandle
 *
 *  @since  1.0.1
 */
- (void)swpCameraDidCancelPickerControllerClose:(SwpCameraDidCancelHandle)swpCameraDidCancelPickerControllerCloseHandle {
    self.swpCameraDidCancelPickerControllerCloseHandle = swpCameraDidCancelPickerControllerCloseHandle;
}


#pragma mark - Init Data Methods
- (UIImagePickerController *)imagePickerController {
    
    if (!_imagePickerController) {
        _imagePickerController                            = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate                   = self;
        _imagePickerController.allowsEditing              = YES;
        _imagePickerController.navigationBar.barTintColor = [UIColor whiteColor];
        _imagePickerController.navigationBar.tintColor    = [UIColor blackColor];
        [_imagePickerController.navigationBar setBarStyle:UIBarStyleDefault];
        
    }
    return _imagePickerController;
}

- (void)dealloc {
    self.controller            = nil;
    self.imagePickerController = nil;
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Test Methods
- (UIImage *)compressImage:(UIImage *)image scaleToSize:(CGSize)size  {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat     compression     = 0.5f;
    CGFloat     maxCompression  = 0.1f;
    NSUInteger  maxLength       = 1024 * 200;
    
    NSData     *imageData       = UIImageJPEGRepresentation(scaledImage, compression);
    while (imageData.length > maxLength && compression > maxCompression) {
        compression -= 0.1;
        imageData   =  UIImageJPEGRepresentation(scaledImage, compression);
    };
    
    return [UIImage imageWithData:imageData];
}


@end

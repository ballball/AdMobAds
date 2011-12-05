/*
 * iphone-specific implementation of the AdmobAds extension.
 * Add any platform-specific functionality here.
 */
/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */
#include "AdmobAds_internal.h"


#include "GADBannerView.h"
#include "s3eEdk_iphone.h"


struct AdmobAds_Global{
       GADBannerView * bannerView_;
       CGSize size;
} AdmobAds_Global_;



s3eResult AdmobAdsInit_platform()
{
    return S3E_RESULT_SUCCESS;
}

void AdmobAdsTerminate_platform()
{
}

s3eResult AdmobAds_InitAds_platform(const char* pub_id, int ad_type, int orientation, int x, int y)
{
    NSString * sPubId = [NSString stringWithUTF8String:pub_id];

    s3eEdkGetUIView();
    //CGRect rect = CGRectMake(0,0,320,50);

    CGRect screenRect = [[UIScreen mainScreen] bounds];

//    CGRect rect = CGRectMake(screenRect.size.width - GAD_SIZE_728x90.height, 0, GAD_SIZE_728x90.height, GAD_SIZE_728x90.width);

    CGSize size;

    if(ad_type == AdmobAds_GAD_SIZE_320x50)
      size = GAD_SIZE_320x50;
    else if(ad_type == AdmobAds_GAD_SIZE_300x250)
      size = GAD_SIZE_300x250;
    else if(ad_type == AdmobAds_GAD_SIZE_468x60)
      size = GAD_SIZE_468x60;
    else if(ad_type == AdmobAds_GAD_SIZE_728x90)
      size = GAD_SIZE_728x90;

    else
     return S3E_RESULT_ERROR;

    AdmobAds_Global_.size = size;

    CGRect rect = CGRectMake(0, 0, size.width, size.height);

    AdmobAds_Global_.bannerView_ = [[[GADBannerView alloc] initWithFrame:rect] autorelease];
    //bannerView_.center = CGPointZero;
    AdmobAds_Global_.bannerView_.adUnitID = sPubId;
    AdmobAds_Global_.bannerView_.rootViewController = s3eEdkGetUIViewController();
    //[s3eEdkGetUIView() addSubview:bannerView_];
    [s3eEdkGetUIWindow() addSubview:AdmobAds_Global_.bannerView_];

    AdmobAds_Global_.bannerView_.hidden = YES;

    [AdmobAds_Global_.bannerView_ loadRequest:[GADRequest request]];

    AdmobAds_Move_platform(orientation, x, y);

    return S3E_RESULT_SUCCESS;
}

s3eResult AdmobAds_ShowAds_platform()
{
    AdmobAds_Global_.bannerView_.hidden = NO;
//    bannerView_.transform = CGAffineTransformMakeRotation(M_PI * 90.0 / 180.0);
    return S3E_RESULT_SUCCESS;
}

s3eResult AdmobAds_HideAds_platform()
{
    AdmobAds_Global_.bannerView_.hidden = YES;
    return S3E_RESULT_SUCCESS;
}

s3eResult AdmobAds_Move_platform(int orientation, int x, int y)
{
  AdmobAds_Global_.bannerView_.transform = CGAffineTransformMakeRotation(M_PI * orientation / 2.0);
  AdmobAds_Global_.bannerView_.center = CGPointMake(AdmobAds_Global_.size.width / 2 + x, AdmobAds_Global_.size.height / 2 + y);
  return S3E_RESULT_ERROR;
}

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



GADBannerView * bannerView_;



s3eResult AdmobAdsInit_platform()
{
    // Add any platform-specific initialisation code here
    return S3E_RESULT_SUCCESS;
}

void AdmobAdsTerminate_platform()
{
    // Add any platform-specific termination code here
}




s3eResult InitAds_platform(const char* pub_id)
{
    
    NSString * sPubId = [NSString stringWithUTF8String:pub_id];
    
    s3eEdkGetUIView();
    CGRect rect = CGRectMake(0,0,320,50);
    bannerView_ = [[[GADBannerView alloc] initWithFrame:rect] autorelease];
    bannerView_.adUnitID = sPubId;
    bannerView_.rootViewController = s3eEdkGetUIViewController();
    [s3eEdkGetUIView() addSubview:bannerView_];
    
    [bannerView_ loadRequest:[GADRequest request]];
    
    return S3E_RESULT_SUCCESS;
}

s3eResult ShowAds_platform()
{
    bannerView_.hidden = NO;
    return S3E_RESULT_SUCCESS;
//    return S3E_RESULT_ERROR;
}

s3eResult HideAds_platform()
{
    bannerView_.hidden = YES;
    return S3E_RESULT_SUCCESS;
    //    return S3E_RESULT_ERROR;
}

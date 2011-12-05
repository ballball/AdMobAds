/*
Generic implementation of the AdmobAds extension.
This file should perform any platform-indepedentent functionality
(e.g. error checking) before calling platform-dependent implementations.
*/

/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */


#include "AdmobAds_internal.h"
s3eResult AdmobAdsInit()
{
    //Add any generic initialisation code here
    return AdmobAdsInit_platform();
}

void AdmobAdsTerminate()
{
    //Add any generic termination code here
    AdmobAdsTerminate_platform();
}

s3eResult AdmobAds_InitAds(const char* pub_id, int ad_type, int orientation, int x, int y)
{
	return AdmobAds_InitAds_platform(pub_id, ad_type, orientation, x, y);
}

s3eResult AdmobAds_ShowAds()
{
	return AdmobAds_ShowAds_platform();
}

s3eResult AdmobAds_HideAds()
{
	return AdmobAds_HideAds_platform();
}

s3eResult AdmobAds_Move(int orientation, int x, int y)
{
	return AdmobAds_Move_platform(orientation, x, y);
}

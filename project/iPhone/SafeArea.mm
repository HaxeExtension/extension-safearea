#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

namespace safearea
{

	void get_safeAreaInsets(double *top, double *bottom, double *left, double *right)
	{
		if (@available(iOS 11, *))
		{
			UIWindow *window = [[UIApplication sharedApplication] keyWindow];
			UIView *view = window.rootViewController.view;
			UIEdgeInsets safeAreaInsets = view.safeAreaInsets;

			*top = safeAreaInsets.top * view.contentScaleFactor;
			*bottom = safeAreaInsets.bottom * view.contentScaleFactor;
			*left = safeAreaInsets.left * view.contentScaleFactor;
			*right = safeAreaInsets.right * view.contentScaleFactor;

			return;
		}

		*top = 0.0;
		*bottom = 0.0;
		*left = 0.0;
		*right = 0.0;
	}

}

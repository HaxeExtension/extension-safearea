package org.haxe.extension;

import android.util.Log;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import org.haxe.lime.HaxeObject;
import android.view.WindowInsets;
import android.view.WindowManager;
import android.view.DisplayCutout;
import android.view.View.OnApplyWindowInsetsListener;


public class NotchAndroid extends Extension {

	public static NotchAndroid inst = null;
	public float[] insets;

	public NotchAndroid(){
		super();
		inst = this;
	}

	public void onCreate (Bundle savedInstanceState) {
		insets = new float[4];
		
		if (Build.VERSION.SDK_INT >= 28) {
			Window win = mainActivity.getWindow();
			win.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
			win.getAttributes().layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
		}
	}

	public float[] updateSafeArea(){
		if (Build.VERSION.SDK_INT >= 28) {
			Window win = mainActivity.getWindow();
			if(win == null) return null;

			View root = win.getDecorView().getRootView();
			if(root == null) return null;

			WindowInsets ins = root.getRootWindowInsets();
			if(ins == null) return null;

			DisplayCutout cutout = ins.getDisplayCutout();

			if(cutout != null){
				insets[0] = (float) cutout.getSafeInsetTop();
				insets[1] = (float) cutout.getSafeInsetBottom();
				insets[2] = (float) cutout.getSafeInsetLeft();
				insets[3] = (float) cutout.getSafeInsetRight();
			}else{
				//no cutout
				insets[0] = 0;
				insets[1] = 0;
				insets[2] = 0;
				insets[3] = 0;
			}
		}

		return insets;
	}
}
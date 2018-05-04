#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include "SafeArea.h"

using namespace safearea;

static value safearea_get_safeAreaInsets()
{
	double top = 0.0, bottom = 0.0, left = 0.0, right = 0.0;
	
	#ifdef IPHONE
	get_safeAreaInsets(&top, &bottom, &left, &right);
	#endif

	value insets = alloc_empty_object();
	alloc_field(insets, val_id("top"), alloc_float(top));
	alloc_field(insets, val_id("bottom"), alloc_float(bottom));
	alloc_field(insets, val_id("left"), alloc_float(left));
	alloc_field(insets, val_id("right"), alloc_float(right));
	return insets;
}
DEFINE_PRIM(safearea_get_safeAreaInsets, 0);

extern "C" void safearea_main ()
{
	val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT(safearea_main);

extern "C" int safearea_register_prims()
{
	return 0;
}

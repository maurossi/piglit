LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# piglit_top := $(LOCAL_PATH)/../..

piglit_major_version := 1
piglit_minor_version := 0
piglit_patch_version := 0

LOCAL_MODULE := libpiglitutil_gles2
LOCAL_MODULE_TAG := eng

LOCAL_CFLAGS := -DPIGLIT_USE_WAFFLE \
	-DPIGLIT_USE_OPENGL_ES2 \
	-DPIGLIT_HAS_ANDROID \
	-DSOURCE_DIR='"piglit";' \

LOCAL_C_INCLUDES := . \
	external/stlport/stlport \
	bionic \
	$(piglit_top)/src \
	$(piglit_top)/tests/util \
	external/waffle/include/waffle \

$(pigit_top)/tests/util/generated_dispatch.h: \
     $(piglit_top)/Android.mk \
     $(LOCAL_PATH)/config.h.in
	@echo "target  Generated dispatch tables"
	python $(piglit_top)/glapi/parse_glspec.py $(piglit_top)/glapi/gl.tm $(piglit_top)/glapi/gl.spec $(piglit_top)/glapi/enumext.spec $(piglit_top)/glapi/glapi.json
	python $(LOCAL_PATH)/gen_dispatch.py $(piglit_top)/glapi/glapi.json $(LOCAL_PATH)/generated_dispatch.c $(LOCAL_PATH)/generated_dispatch.h
	@sed -e 's/#cmakedefine HAVE_STRCHRNUL/#define HAVE_STRCHRNUL/' \
         -e 's/#cmakedefine HAVE_FOPEN_S//' \
         -e 's/#cmakedefine HAVE_SETRLIMIT/#define HAVE_SETRLIMIT/' \
         -e 's/#cmakedefine HAVE_FCNTL_H/#define HAVE_FCNTL_H/' \
         -e 's/#cmakedefine HAVE_SYS_STAT_H/#define HAVE_SYS_STAT_H/' \
         -e 's/#cmakedefine HAVE_SYS_TYPES_H/#define HAVE_SYS_TYPES_H/' \
         -e 's/#cmakedefine HAVE_SYS_TIME_H/#define HAVE_TIME_H/' \
         -e 's/#cmakedefine HAVE_SYS_RESOURCE_H/#define HAVE_SYS_RESOURCE_H/' \
         -e 's/#cmakedefine HAVE_UNISTD_H/#define HAVE_UNISTD_H/' \
		       $(LOCAL_PATH)/config.h.in \
		      > $(LOCAL_PATH)/config.h

LOCAL_SRC_FILES := \
	piglit-vbo.cpp \
    piglit-shader.c \
    piglit-shader-gles2.c \
    piglit-util-gl-enum.c \
    piglit-util-gles.c \
    minmax-test.c \
    piglit-util.c \
    fdo-bitmap.c \
    piglit-util-gl-common.c \
	piglit-framework-gl/piglit_gl_framework.c \
	piglit-framework-gl.c \
	piglit_ktx.c \
	rgb9e5.c \
	piglit-framework-gl/piglit_android_framework.c \
	piglit-framework-gl/piglit_gbm_framework.c \
	piglit-framework-gl/piglit_fbo_framework.c \
	piglit-framework-gl/piglit_wfl_framework.c \
	piglit-framework-gl/piglit_winsys_framework.c \
	piglit-framework-gl/piglit_wl_framework.c \
	piglit-util-waffle.c \

LOCAL_SHARED_LIBRARIES := \
	libGLESv2 \
	libwaffle-1 \
	libstdc++ \
	libstlport \

LOCAL_COPY_HEADERS := \
	glxew.h \
	piglit-framework-gl.h \
	piglit-util-egl.h \
	minmax-test.h \
	piglit-glx-util.h \
	piglit-util-gl-common.h \
	piglit-dispatch.h \
	piglit_ktx.h \
	piglit-util.h \
	piglit-framework-cl-api.h \
	piglit-shader.h \
	piglit-util-waffle.h \
	piglit-framework-cl-custom.h \
	piglit-util-cl-enum.h \
	piglit-vbo.h \
	piglit-framework-cl.h \
	piglit-util-cl.h \
	rgb9e5.h \
	piglit-framework-cl-program.h \
	piglit-util-compressed-grays.h \
	sized-internalformats.h \
	generated_dispatch.h \

LOCAL_COPY_HEADERS_TO := piglit-$(piglit_major_version)

include $(BUILD_SHARED_LIBRARY)

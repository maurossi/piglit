LOCAL_PATH:= $(call my-dir)

piglit_shared_libs := libGLESv2 \
                      libwaffle-1 \
					  libpiglitutil_gles2 \

piglit_c_includes := $(piglit_top)/tests/util \
	bionic \
	$(piglit_top)/src \
	external/waffle/include/waffle \
	external/mesa/include \

include $(CLEAR_VARS)
LOCAL_SHARED_LIBRARIES := libGLESv2 libwaffle-1 libpiglitutil_gles2
LOCAL_C_INCLUDES := $(piglit_c_includes)
LOCAL_CFLAGS := -DPIGLIT_USE_WAFFLE -DPIGLIT_USE_OPENGL_ES2 -DPIGLIT_HAS_ANDROID
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE := glslparsertest_gles2
systemtarball: glslparsertest_gles2
LOCAL_SRC_FILES := glslparsertest.c
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)/piglit/glslparsertest
include $(BUILD_EXECUTABLE)

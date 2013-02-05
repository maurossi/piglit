LOCAL_PATH:= $(call my-dir)

piglit_shared_libs := libGLESv2 \
                      libwaffle-1 \
					  libpiglitutil_gles2 \

piglit_c_includes := $(piglit_top)/tests/util \
	bionic \
	$(piglit_top)/src \
	external/waffle/include/waffle \
	external/mesa3d/include \

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

define all-vert-frag-files-under
$(patsubst ./%,%, \
  $(shell cd $(1) ; \
    find $(2) -name "*.vert" -or -name "*.frag" -and -not -name ".*" -printf "%P\n" ) \
   )
endef

define glsl2_add_test_data
include $(CLEAR_VARS)
LOCAL_SRC_FILES := glsl2/$1
LOCAL_MODULE:= $1
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := data
LOCAL_MODULE_PATH:=$(TARGET_OUT_DATA)/glslparser-data/glsl2
datatarball: $1
include $(BUILD_PREBUILT)
endef

glsl2_files := $(call all-vert-frag-files-under, external/piglit/tests/glslparsertest/glsl2)
$(foreach item,$(glsl2_files),$(eval $(call glsl2_add_test_data,$(item))))

define shaders_add_test_data
include $(CLEAR_VARS)
LOCAL_SRC_FILES := shaders/$1
LOCAL_MODULE:= $1
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := data
LOCAL_MODULE_PATH:=$(TARGET_OUT_DATA)/glslparser-data/shaders
datatarball: $1
include $(BUILD_PREBUILT)
endef

shader_files := $(call all-vert-frag-files-under, external/piglit/tests/glslparsertest/shaders)
$(foreach item,$(shader_files),$(eval $(call shaders_add_test_data,$(item))))

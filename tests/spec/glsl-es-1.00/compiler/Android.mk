LOCAL_PATH:= $(call my-dir)

define all-vert-frag-files-under
$(patsubst ./%,%, \
  $(shell cd $(1) ; \
    find $(2)  -regex ".*\.\(vert\|frag\)" -printf "%P\n" ) \
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

glsl2_files := $(call all-vert-frag-files-under, external/piglit/tests/spec/glsl-es-1.00/compiler/glsl2)
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

shader_files := $(call all-vert-frag-files-under, external/piglit/tests/spec/glsl-es-1.00/compiler/shaders)
$(foreach item,$(shader_files),$(eval $(call shaders_add_test_data,$(item))))

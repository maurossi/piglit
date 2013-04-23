LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE:= sanity.shader_test
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := data
LOCAL_MODULE_PATH:=$(TARGET_OUT_DATA)/shader-data/execution
LOCAL_SRC_FILES := sanity.shader_test
userdatatarball: $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

define all-shader-test-files-under
$(patsubst ./%,%, \
  $(shell cd $(1) ; \
    find $(2) -name "*.shader_test" -and -not -name ".*" -printf "%P\n" ) \
   )
endef

define maximums_add_test_data
include $(CLEAR_VARS)
LOCAL_SRC_FILES := maximums/$1
$(warning $(LOCAL_SRC_FILES))
LOCAL_MODULE:= $1
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := data
LOCAL_MODULE_PATH:=$(TARGET_OUT_DATA)/shader-data/execution/maximums
userdatatarball: $(LOCAL_MODULE)
include $(BUILD_PREBUILT)
endef

maximums_files := $(call all-shader-test-files-under, external/piglit/tests/spec/glsl-es-1.00/execution/maximums)
$(foreach item,$(maximums_files),$(eval $(call maximums_add_test_data,$(item))))


define variable_index_add_test_data
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $2/$1
$(warning $(LOCAL_SRC_FILES))
LOCAL_MODULE:= $1
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := data
LOCAL_MODULE_PATH:=$(TARGET_OUT_DATA)/shader-data/execution/$2
userdatatarball: $(LOCAL_MODULE)
include $(BUILD_PREBUILT)
endef

variable_index_read_files := $(call all-shader-test-files-under, external/piglit/tests/spec/glsl-es-1.00/execution/variable-index-read)
$(foreach item,$(variable_index_read_files),$(eval $(call variable_index_add_test_data,$(item),variable-index-read)))

variable_index_write_files := $(call all-shader-test-files-under, external/piglit/tests/spec/glsl-es-1.00/execution/variable-index-write)
$(foreach item,$(variable_index_write_files),$(eval $(call variable_index_add_test_data,$(item),variable-index-write)))

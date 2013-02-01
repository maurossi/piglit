LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= sanity.shader_test
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := data
LOCAL_MODULE_PATH:=$(TARGET_OUT_DATA)/shader-data/execution
LOCAL_SRC_FILES := sanity.shader_test
userdatatarball: $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

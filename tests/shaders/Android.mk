include $(call all-subdir-makefiles)

LOCAL_PATH:= $(call my-dir)

piglit_shared_libs := libGLESv2 \
                      libwaffle-1 \
					  libpiglitutil_gles2 \

piglit_c_includes := $(piglit_top)/tests/util \
	bionic \
	$(piglit_top)/src \
	external/waffle/include/waffle \
	external/mesa3d/include \

piglit_c_flags := -DPIGLIT_USE_WAFFLE -DPIGLIT_USE_OPENGL_ES2 -DPIGLIT_HAS_ANDROID

module_name = piglit-shader-test

define $(module_name)_etc_add_executable
    include $(CLEAR_VARS)
    LOCAL_SHARED_LIBRARIES := $(piglit_shared_libs)
    LOCAL_C_INCLUDES := $(piglit_c_includes)
    LOCAL_CFLAGS := $(piglit_c_flags)
    LOCAL_MODULE_TAGS := eng
    LOCAL_MODULE := $1_gles2
    systemtarball: $1_gles2
    LOCAL_SRC_FILES := $1.c
    LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)/piglit/$(module_name)
    include $(BUILD_EXECUTABLE)
endef

test_names := shader_runner
$(foreach item,$(test_names),$(eval $(call $(module_name)_etc_add_executable, $(item))))

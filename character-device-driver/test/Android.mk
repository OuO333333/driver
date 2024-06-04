LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES += \
	timdev.c

LOCAL_CFLAGS += -std=c99
LOCAL_MODULE := timdev
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)

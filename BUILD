load(
    ":link.bzl",
    "shared_library",
)

cc_library(
    name = "funcs",
    srcs = [
        "func.c",
        "other.c",
    ],
    alwayslink = 1,
)

sh_binary(
    name = "keep",
    srcs = ["keep.sh"],
)

exports_files(
    srcs = [
        "version.ld",
    ],
    visibility = ["//visibility:public"],
)

shared_library(
    name = "func.so",
    srcs = [
        ":funcs"
    ],
    version_script = ":version.ld",
)

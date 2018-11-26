def shared_library(
        name,
        srcs,
        deps = [],
        linkopts = [],
        version_script = "",
    ):
    updated_linkopts = list(linkopts)
    updated_deps = list(deps)
    updated_linkopts += [
        "-Wl,--gc-sections",
        "-Wl,--print-gc-sections",
    ]
    if version_script:
        updated_deps += [version_script]
        updated_linkopts += [
            "-Wl,--version-script=$(location " + version_script + ")",
        ]

    linker_script = name + "_linker_script"
    linker_script_ld = linker_script + ".ld"
    native.genrule(
        name = linker_script,
        outs = [linker_script_ld],
        srcs = srcs,
        tools = [":keep"],
        #cmd = ("echo $(location :funcs) > " + name + "-gen.lds"),
        #cmd = ("ar -t $(location :funcs) | tr '\n' ' ' > $@"),
        # cmd = ("$(location :keep) $(location :funcs) > $@"),
        cmd = ("ar -t $(locations :funcs) | tr '\n' ' ' | xargs $(location :keep) > $@"),
    )
    updated_deps += [linker_script_ld]
    updated_linkopts += ["-Wl,--script=$(location " + linker_script_ld + ")"]

    native.cc_binary(
        name = name,
        linkshared = 1,
        srcs = srcs,
        deps = updated_deps,
        linkopts = updated_linkopts,
    )

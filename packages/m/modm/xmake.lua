package("modm")
    set_homepage("https://modm.io")
    set_description("modm: a C++20 library generator for AVR and ARM Cortex-M devices")
    set_license("MPL-2.0")

    add_urls("https://github.com/modm-io/modm/archive/refs/tags/$(version).tar.gz",
             "https://github.com/modm-io/modm.git")
    add_versions("2022q1", "e87d82affdfdd0f953bdaedff5cba60d69f6d93ab22cdf6b4a6208e0ae5e9869")

    add_deps("cmake")
    add_deps("python 3.x", {kind = "binary"})
    
    on_install(function (package)
        os.vrunv("python3", {"-m", "pip", "install", "lbuild"})
        os.exec("git clone git@github.com:modm-io/modm-devices.git")
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("modm")
               set_kind("$(kind)")
               add_files("src/*.c")
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("foo", {includes = "foo.h"}))
    end)

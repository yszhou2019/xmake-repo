package("apr")
    set_homepage("https://github.com/apache/apr")
    set_description("Mirror of Apache Portable Runtime")
    set_license("Apache-2.0")

    add_urls("https://github.com/apache/apr/archive/refs/tags/$(version).tar.gz",
             "https://github.com/apache/apr.git")
    add_versions("1.7.0", "a7e2c5e6d60f6c7b1611b31a2f914a3e58f44eded5b064f0bae43ff30b16a4e6")

    add_deps("cmake")
    
    on_install("linux", "macosx", "windows", function (package)
        import("package.tools.cmake").install(package)
    end)

    on_test(function (package)
        assert(package:has_cincludes("apr.h"))
    end)

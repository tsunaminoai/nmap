const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // dependencies

    // static libraires
    const lib = b.addStaticLibrary(.{
        .name = "nmap",
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.addIncludePath(.{ .path = "." });

    const nsock_cflags: []const []const u8 = &.{};
    const nsock_sources = [_][]const u8{ "nsock/src/error.c", "nsock/src/filespace.c", "nsock/src/gh_heap.c", "nsock/src/nsock_connect.c", "nsock/src/nsock_core.c", "nsock/src/nsock_iod.c", "nsock/src/nsock_read.c", "nsock/src/nsock_timers.c", "nsock/src/nsock_write.c", "nsock/src/nsock_ssl.c", "nsock/src/nsock_event.c", "nsock/src/nsock_pool.c", "nsock/src/netutils.c", "nsock/src/nsock_pcap.c", "nsock/src/nsock_engines.c", "nsock/src/engine_select.c", "nsock/src/engine_epoll.c", "nsock/src/engine_kqueue.c", "nsock/src/engine_poll.c", "nsock/src/nsock_proxy.c", "nsock/src/nsock_log.c", "nsock/src/proxy_http.c", "nsock/src/proxy_socks4.c" };
    const headers = [_][]const u8{ "nsock/src/error.h", "nsock/src/filespace.h", "nsock/src/gh_list.h", "nsock/src/nsock_internal.h", "nsock/src/netutils.h", "nsock/src/nsock_pcap.h", "nsock/src/nsock_log.h", "nsock/src/nsock_proxy.h", "nsock/src/gh_heap.h", "nsock/include/nsock.h" };

    for (headers) |h| lib.installHeader(h, h);
    lib.addCSourceFiles(&nsock_sources, nsock_cflags ++ [_][]const u8{
        "-DBUILDING_nsock",
    });
    // common config

    // build and link

}

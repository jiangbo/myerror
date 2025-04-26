const std = @import("std");

const sk = @import("sokol");

var rand: std.Random = undefined;

export fn init() void {
    var prng = std.Random.DefaultPrng.init(@intCast(std.time.timestamp()));
    rand = prng.random();

    // initRand();
    std.log.info("init rand", .{});
}

export fn event(ev: ?*const sk.app.Event) void {
    if (ev) |e| {
        if (e.type == .KEY_DOWN and e.key_code == .SPACE) {
            const number = rand.intRangeAtMostBiased(u8, 1, 4);
            std.log.info("number: {d}", .{number});
        }
    }
}

export fn frame() void {}

fn initRand() void {
    var prng = std.Random.DefaultPrng.init(@intCast(std.time.timestamp()));
    rand = prng.random();
}

pub fn main() void {
    initRand();

    sk.app.run(.{
        .window_title = "拼好饭传奇",
        .width = 640,
        .height = 480,
        .init_cb = init,
        .event_cb = event,
        .frame_cb = frame,
        .logger = .{ .func = sk.log.func },
    });
}

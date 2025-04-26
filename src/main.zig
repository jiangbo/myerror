const std = @import("std");

const sk = @import("sokol");

var rand: std.Random = undefined;

export fn init() void {
    // method 2
    // initRand();

    // method 3
    var prng = std.Random.DefaultPrng.init(@intCast(std.time.timestamp()));
    rand = prng.random();

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

fn initRand() void {
    var prng = std.Random.DefaultPrng.init(@intCast(std.time.timestamp()));
    rand = prng.random();
}

pub fn main() void {

    // method 1
    // initRand();

    sk.app.run(.{
        .window_title = "sokol",
        .width = 640,
        .height = 480,
        .init_cb = init,
        .event_cb = event,
        .logger = .{ .func = sk.log.func },
    });
}

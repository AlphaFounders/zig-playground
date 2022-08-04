const std = @import("std");

pub fn main() anyerror!void {
    const hello_world_in_c =
        \\#include <stdio.h>
        \\
        \\int main(int argc, char **argv) {
        \\    printf("hello world\n");
        \\    return 0;
        \\}
    ;
    // floating point error
    const floating_point = 0.1 + 0.2; // 0.3
    std.log.info("Hello, World!", .{});
    std.log.info("{s}", .{hello_world_in_c});
    std.log.info("{d}", .{floating_point});

    // check for palindrome

}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}

const expect = @import("std").testing.expect;

test "if statement" {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

test "check for palindrome" {
    var reversed: i32 = 0;
    var remainder: i32 = 0;
    var original: i32 = 123321;

    var num: i32 = original;

    while (num != 0) {
        remainder = @rem(num, 10);
        reversed = reversed * 10 + remainder;
        num = @divTrunc(num, 10);
    }

    // palindrome if orignal and reversed are equal
    try std.testing.expectEqual(original, reversed);
}

test "check for palindrome for strings" {
    // const originalString = [_]u8{ '1', '2' };
    // const originalString = [_]u8{ '2' };
    // const originalString = [_]u8{ '2', '2', '3', '2', '1' };
    // const originalString = [_]u8{ '1', '2', '3', '2', '1' };
    // const originalString = [_]u8{ '1', '2', '3', '3', '2', '1' };
    const originalString = [_]u8{ '1', '2', '3', '3', '2', '1' };
    const length = originalString.len / 2;
    var i: u8 = 0;
    var isPalindrome = true;
    while (i < length) : (i += 1) {
        if (originalString[i] != originalString[originalString.len - i - 1]) {
            isPalindrome = false;
            break;
        }
    }

    try expect(isPalindrome);
}

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "function recursion" {
    const x = fibonacci(10);
    try expect(x == 55);
}

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "unreachable" {
    const x: i32 = 1;
    const y: u32 = if (x == 2) 5 else unreachable;
    _ = y;
}

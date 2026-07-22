/**
 * Tests for index.js
 */

const { add, subtract, main } = require("../src/index");

describe("Math Functions", () => {
  test("add returns sum of two numbers", () => {
    expect(add(2, 3)).toBe(5);
    expect(add(-1, 1)).toBe(0);
    expect(add(0, 0)).toBe(0);
  });

  test("subtract returns difference of two numbers", () => {
    expect(subtract(5, 3)).toBe(2);
    expect(subtract(1, 1)).toBe(0);
    expect(subtract(-1, -1)).toBe(0);
  });
});

describe("main function", () => {
  test("returns greeting string", () => {
    expect(main()).toBe("Hello, Git & GitHub!");
  });
});

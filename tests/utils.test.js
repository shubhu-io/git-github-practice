/**
 * Tests for utils.js
 */

const { capitalize, reverse, isPalindrome, factorial } = require("../src/utils");

describe("capitalize", () => {
  test("capitalizes first letter", () => {
    expect(capitalize("hello")).toBe("Hello");
  });

  test("handles empty string", () => {
    expect(capitalize("")).toBe("");
  });

  test("handles already capitalized", () => {
    expect(capitalize("Hello")).toBe("Hello");
  });
});

describe("reverse", () => {
  test("reverses a string", () => {
    expect(reverse("hello")).toBe("olleh");
  });

  test("handles empty string", () => {
    expect(reverse("")).toBe("");
  });
});

describe("isPalindrome", () => {
  test("identifies palindromes", () => {
    expect(isPalindrome("racecar")).toBe(true);
    expect(isPalindrome("madam")).toBe(true);
  });

  test("identifies non-palindromes", () => {
    expect(isPalindrome("hello")).toBe(false);
  });

  test("ignores case and spaces", () => {
    expect(isPalindrome("A man a plan a canal Panama")).toBe(true);
  });
});

describe("factorial", () => {
  test("calculates factorial", () => {
    expect(factorial(0)).toBe(1);
    expect(factorial(1)).toBe(1);
    expect(factorial(5)).toBe(120);
  });

  test("handles negative numbers", () => {
    expect(factorial(-1)).toBe(-1);
  });
});

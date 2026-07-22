/**
 * Utility functions
 */

function capitalize(str) {
  if (!str) return "";
  return str.charAt(0).toUpperCase() + str.slice(1);
}

function reverse(str) {
  return str.split("").reverse().join("");
}

function isPalindrome(str) {
  const cleaned = str.toLowerCase().replace(/[^a-z0-9]/g, "");
  return cleaned === reverse(cleaned);
}

function factorial(n) {
  if (n < 0) return -1;
  if (n === 0 || n === 1) return 1;
  return n * factorial(n - 1);
}

module.exports = { capitalize, reverse, isPalindrome, factorial };

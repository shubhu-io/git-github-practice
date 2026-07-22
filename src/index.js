/**
 * Main application entry point
 */

const greeting = "Hello, Git & GitHub!";

function main() {
  console.log(greeting);
  return greeting;
}

function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

module.exports = { main, add, subtract };

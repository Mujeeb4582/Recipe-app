/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*",
  ],
  theme: {
    extend: {
      colors: {
        // Configure your color palette here
        backgroundColor: "#f1f5f9",
        textColor: "#1f2937",
        variantColor: "#fdba74",
        mainTheme: 'black'
      },
      boxShadow: {
        "custom": '-1px 1px 20px 7px red'
      }
    },
    fontFamily: {
      important: ["Josefin Sans", "sans-serif"],
      normal: ["Josefin Sans", "sans-serif"],
    },
    fontSize: {
      important: ["1.5rem", "1.25rem"],
    },
  },
  plugins: [],
};

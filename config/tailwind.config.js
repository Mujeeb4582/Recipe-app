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
        backgroundColor: "#fb923c",
        textColor: "#1f2937",
        variantColor: "#fdba74",
      },
    },
    fontFamily: {
      important: ["Inter", "sans-serif"],
      normal: ["Inter", "sans-serif"],
    },
    fontSize: {
      important: ["1.5rem", "1.25rem"],
    },
  },
  plugins: [],
};

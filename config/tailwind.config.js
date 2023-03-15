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
        backgroundColor: "#FB923C",
      },
    },
  },
  plugins: [],
};

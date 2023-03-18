
document.addEventListener('DOMContentLoaded', () => {
    const themeChanger = document.querySelector('.theme-changer');

    const toggleDarkMode = () => {
        document.documentElement.classList.toggle('dark');
        themeChanger.children[0].classList.toggle('hidden');
        themeChanger.children[1].classList.toggle('hidden');
        localStorage.setItem('darkMode', document.documentElement.classList.contains('dark'));
        console.log(localStorage.getItem('darkMode'));
    }

    if (localStorage.getItem('darkMode') === 'true') {
        toggleDarkMode();
    }
    themeChanger.addEventListener('click',toggleDarkMode);

  });

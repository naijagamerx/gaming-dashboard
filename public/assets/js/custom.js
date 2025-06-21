// public/assets/js/custom.js

document.addEventListener("DOMContentLoaded", function() {
    // Sidebar toggle functionality
    const sidebarToggle = document.body.querySelector("#sidebarToggle");
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle state in localStorage
        // if (localStorage.getItem("sb|sidebar-toggle") === "true") {
        //     document.body.classList.toggle("sb-sidenav-toggled"); // Assuming this class controls toggle
        // }
        sidebarToggle.addEventListener("click", function(event) {
            event.preventDefault();
            document.getElementById("wrapper").classList.toggle("toggled");
            // Uncomment Below to persist sidebar toggle state in localStorage
            // localStorage.setItem("sb|sidebar-toggle", document.body.classList.contains("sb-sidenav-toggled"));
        });
    }

    // Theme toggle functionality
    const themeToggleBtn = document.getElementById('themeToggleBtn');
    const currentTheme = localStorage.getItem('theme') ? localStorage.getItem('theme') : 'light';
    const htmlElement = document.documentElement;

    function setTheme(theme) {
        htmlElement.setAttribute('data-bs-theme', theme);
        localStorage.setItem('theme', theme);
        if (themeToggleBtn) {
            const icon = themeToggleBtn.querySelector('i');
            if (theme === 'dark') {
                icon.classList.remove('bi-moon-stars-fill');
                icon.classList.add('bi-sun-fill');
            } else {
                icon.classList.remove('bi-sun-fill');
                icon.classList.add('bi-moon-stars-fill');
            }
        }
    }

    // Set initial theme
    setTheme(currentTheme);

    if (themeToggleBtn) {
        themeToggleBtn.addEventListener('click', function() {
            let newTheme = htmlElement.getAttribute('data-bs-theme') === 'dark' ? 'light' : 'dark';
            setTheme(newTheme);
        });
    }

    // Activate Bootstrap tooltips (if you plan to use them)
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    });

    // Activate Bootstrap popovers (if you plan to use them)
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    });

    // Auto-dismiss alerts after a few seconds (optional)
    const autoDismissAlerts = document.querySelectorAll('.alert-dismissible.fade.show');
    autoDismissAlerts.forEach(function(alert) {
        setTimeout(function() {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000); // Dismiss after 5 seconds
    });

});

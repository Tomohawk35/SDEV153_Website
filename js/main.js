import { codeToHtml } from 'https://esm.sh/shiki@3.0.0';


export async function importAndHighlightShiki(filePath, elementId) {

    try {
        const codeElement = document.getElementById(elementId);
        if (!codeElement) {
            console.error(`Element with id "${elementId}" not found.`);
            return;
        }

        const response = await fetch(filePath);
        if (!response.ok) {
            throw new Error(`HTTP error! Failed to load GDScript file: ${filePath}`);
        }

        const scriptContent = await response.text();
        const html = await codeToHtml(scriptContent, {
            lang: 'gdscript',
            theme: 'plastic'
            // theme: 'aurora-x'
            // theme: 'ayu-dark'
        });

        codeElement.innerHTML = html;

    } catch (error) {
        console.error(error);
        const errorElement = document.getElementById(elementId);
        errorElement.textContent = '# Error loading script';
    }
}

export async function highlightOnlyShiki(elementId) {

    try {
        const codeElement = document.getElementById(elementId);
        if (!codeElement) {
            console.error(`Element with id "${elementId}" not found.`);
            return;
        }

        const html = await codeToHtml(codeElement.innerHTML, {
            lang: 'gdscript',
            theme: 'plastic'
            // theme: 'aurora-x'
            // theme: 'ayu-dark'
        });

        codeElement.innerHTML = html;

    } catch (error) {
        console.error(error);
        const errorElement = document.getElementById(elementId);
        errorElement.textContent = '# Error loading script';
    }
}

export async function loadFragment(elementID, file) {
    try {
        const container = document.getElementById(elementID);
        if (!container) {
            console.error(`Element with id "${elementID}" not found.`);
            return;
        }

        const response = await fetch(file);
        const html = await response.text();
        container.innerHTML = html;

    } catch (error) {
        console.error(error);
        const errorElement = document.getElementById(elementID);
        errorElement.textContent = '# Error loading HTML';
    }
}


export async function loadHeader(elementID, file) {
    try {
        const container = document.getElementById(elementID);
        if (!container) {
            console.error(`Element with id "${elementID}" not found.`);
            return;
        }

        const response = await fetch(file);
        const html = await response.text();
        container.innerHTML = html;

        const toggle = document.querySelector('.menu-toggle');
        const sidebar = document.querySelector('#sidebar');
        
        toggle.addEventListener('click', () => {
          const isOpen = sidebar.classList.toggle('open');
          toggle.setAttribute('aria-expanded', isOpen);
          sidebar.hidden = !isOpen;
        });
    } catch (error) {
        console.error(error);
        const errorElement = document.getElementById(elementID);
        errorElement.textContent = '# Error loading HTML';
    }
}


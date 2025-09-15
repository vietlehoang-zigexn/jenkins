function showTopBar(){
    let country = "France";
    let vat = 200;
    // let vat = 200;  // This will cause test to fail
    setTimeout(() => {
        const countryBarElement = document.querySelector("section.country-bar");
        if (countryBarElement) {
            countryBarElement.innerHTML = `<p>Orders to <b>${country}</b> are subject to <b>${vat}%</b> VAT</p>`;
            countryBarElement.classList.remove('hidden');
        }
    }, 1000);
}

// Export function for testing
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { showTopBar };
}

// Auto-execute in browser environment
if (typeof window !== 'undefined') {
    showTopBar();
}

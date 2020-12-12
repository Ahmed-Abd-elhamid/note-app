function loading_fn() {
    document.getElementById('top').scrollIntoView();
    setTimeout(init, 500);
}

function init() {
    document.getElementById("loader").style.display = "none";
    document.getElementById("myDiv").style.display = "block";
}

window.addEventListener('load', loading_fn, false);
$(window).on('hashchange', function (e) {
    loading_fn();
}).trigger('hashchange');

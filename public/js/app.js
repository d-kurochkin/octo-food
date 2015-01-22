function loadPage(page) {
    $("#articles-content").load('/articles/M.' + page);
}

$(document).ready(function(){
    $("#articles-content").load('/articles/M.0');
});
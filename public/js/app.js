function loadPage(category, page) {
    $("#articles-content").load('/articles/'+category+'.' + page);
}

$(document).ready(function(){
    $("#articles-content").load('/articles/M.0');
});
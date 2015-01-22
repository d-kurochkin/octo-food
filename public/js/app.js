function article(code) {
    return $('#article-' + code);
}

function loadPage(category, page) {
    $("#articles-content").load('/articles/' + category + '.' + page);
}

function addArticle(name, code, price) {
    if (article(code).length == 0) {
        addNewArticle(name, code, price)
    } else {
        updateArticle(name, code, price);
    }

    updateTotalPrice();
}

function addNewArticle(name, code, price) {
    $('#articles-tbody').append('<tr id="article-' + code + '" code="' + code + '" price=' + price + ' quantity=1> </tr>');

    var row = article(code);
    row.append('<td class="col-sm-1">' +
    '<button type="button" class="btn btn-xs btn-danger" onclick="removeItem(\'' + code + '\')">' +
    '<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>' +
    '</button </td>');

    row.append('<td class="col-sm-8">' + name + '</td>');

    row.append('<td class="col-sm-3">1 <b>x</b> ' + price + '</td>');
}

function updateArticle(name, code, price) {
    var row = article(code);

    var quantity = parseInt(row.attr('quantity')) + 1;
    var price = parseInt(row.attr('price'));

    row.attr('quantity', quantity);
    row.find(':nth-child(3)').html(quantity + ' <b>x</b> ' + price);
}

function updateTotalPrice() {
    var total = 0;
    $('#articles-tbody tr').each(function () {
        var quantity = parseInt($(this).attr('quantity'));
        var price = parseInt($(this).attr('price'));

        total += quantity * price;
    });

    $('#total-price').text('Заказ: '+total+' тг.');
}

function removeItem(code) {
    var row = article(code);
    var quantity = parseInt(row.attr('quantity')) - 1;

    if (quantity > 0) {
        var price = parseInt(row.attr('price'));

        row.attr('quantity', quantity);
        row.find(':nth-child(3)').html(quantity + ' <b>x</b> ' + price);
    } else {
        row.remove();
    }

    updateTotalPrice();
}

function sendOrder(){

}

function emptyOrder() {
    $('#articles-tbody').empty();

    updateTotalPrice();
}

$(document).ready(function () {
    $("#articles-content").load('/articles/M.0');
});
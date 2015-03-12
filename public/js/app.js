


function loadPage(category, page) {
    $("#articles-content").load('/articles/' + category + '.' + page);
}

function sendOrder() {
    var order = {};
    order.charge = $('#charge').val();

    $.post('/order', order, function (data) {
        if (data == '0') {
            emptyOrder();
            $('#paymentModal').modal('hide');

            loadPage("M", 0);
        }
    });
}

$(document).ready(function () {
    //$.get('/display/hello');
    $("#articles-content").load('/articles/M.0');
});


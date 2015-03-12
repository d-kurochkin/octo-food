function article(code) {
    return $('#article-' + code);
}

function loadPage(category, page) {
    $("#articles-content").load('/articles/' + category + '.' + page);
}

function addArticle(name, code, price) {
    var order_list = JSON.parse(localStorage.getItem('order_list'));
    var item = {
        name: name,
        code: code,
        price: price
    };

    if (article(code).length == 0) {
        order_list.push(item);

        mountedOrderPanel.setState({order_list: order_list});

        localStorage.setItem('order_list', JSON.stringify(order_list));
    }
}


//function showPaymentInfo() {
//  var order = getOrder();
//
//  $('#total').val(order.total);
//  var charge = parseInt($('#charge').val());
//
//  if (!isNaN(charge) && charge >= order.total) {
//    $('#change').val(charge - order.total);
//  } else {
//    $('#change').val(0);
//  }
//
//  if (charge>0 && charge>=order.total && order.total>0) {
//    $('#payButton').removeClass('disabled');
//  } else {
//    $('#payButton').addClass('disabled');
//  }
//}


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

function emptyOrder() {

    //$.get('/display/hello');
}

function addNumber(n) {
    var charge = $('#charge').val();
    if (charge == '0') charge = '';

    $('#charge').val(charge + n);
}


function addNote(n) {
    var charge = parseInt($('#charge').val());

    if (!isNaN(charge)) {
        $('#charge').val(charge + n);
    } else {
        $('#charge').val(n);
    }
}

function clearNumber() {
    var charge = $('#charge').val();
    charge = charge.substring(0, charge.length - 1);

    $('#charge').val(charge.length ? charge : 0);
}

$(document).ready(function () {
    //$.get('/display/hello');
    $("#articles-content").load('/articles/M.0');

    var order_list = localStorage.getItem('order_list');

    if (_.isNull(order_list)) {
        console.log("Create empty storage");
        localStorage.setItem('order_list', "[]");
    } else {

    }
});


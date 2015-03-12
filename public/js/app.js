function emptyOrderList() {
    localStorage.setItem('order_list', "{}");
    updateOrderListState({});
}

function getOrderList() {
    return JSON.parse(localStorage.getItem('order_list')) || {};
}

function setOrderList(order_list) {
    localStorage.setItem('order_list', JSON.stringify(order_list));
    updateOrderListState(order_list);
}

function updateOrderListState(order_list){
    mountedOrderPanel.setState({order_list: order_list});
}

function addArticle(name, code, price) {
    var order_list = getOrderList();

    if (order_list[code]) {
        order_list[code].count += 1;
    } else {
        order_list[code] = {
            name: name,
            code: code,
            price: price,
            count: 1
        };
    }

    setOrderList(order_list);
}

function removeArticle(code) {
    var order_list = getOrderList();

    if (order_list[code] && order_list[code].count > 1) {
        order_list[code].count -= 1;
    } else {
        order_list = _.omit(order_list, code);
    }

    setOrderList(order_list);
}


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


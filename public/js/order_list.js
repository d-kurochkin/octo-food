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
    mountedPaymentWindow.setState({total: getOrderListTotal()});
}

function getOrderListTotal(order_list) {
    order_list = order_list || getOrderList();

    var sum_items = _.mapValues(order_list, function (item) {
        return item.price * item.count;
    });

    return _.sum(sum_items);
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



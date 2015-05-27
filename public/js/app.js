function loadPage(category, page) {
  $("#articles-content").load('/articles/' + category + '.' + page, function (response, status, xhr) {
    if (status == "error") {
      alert("Товары для данной категории отсутствуют");
    }
  });
}

function sendOrder() {
  var order = {};
  order.timestamp = new Date().getTime();
  order.items = getOrderList();
  order.total = getOrderListTotal();

  $.post('/order', order, function (data) {
    if (data == '0') {
      emptyOrderList();
      $('#paymentModal').modal('hide');

      loadPage("M", 0);
    }
  });
}

$(document).ready(function () {
  //$.get('/display/hello');
  $("#articles-content").load('/articles/M.0');
});


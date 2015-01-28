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
  $('#articles-tbody').find('tr').each(function () {
    var quantity = parseInt($(this).attr('quantity'));
    var price = parseInt($(this).attr('price'));

    total += quantity * price;
  });
  $('#total-price').text('Заказ: ' + total + ' тг.');

  $.get('/display/price/'+total);
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

function getOrder() {
  var total_price = 0;
  var order = {
    timestamp: new Date().getTime(),
    items: {}
  };

  $('#articles-tbody').find('tr').each(function () {
    var item = $(this);

    var code = item.attr('code');
    var quantity = parseInt(item.attr('quantity'));
    var price = parseInt(item.attr('price'));

    total_price += price * quantity;

    order.items[code] = {
      quantity: quantity,
      price: price
    }
  });

  order['total'] = total_price;

  return order;
}

function showPaymentInfo() {
  var order = getOrder();

  $('#total').val(order.total);
  var charge = parseInt($('#charge').val());

  if (!isNaN(charge) && charge >= order.total) {
    $('#change').val(charge - order.total);
  } else {
    $('#change').val(0);
  }

  if (charge>0 && charge>=order.total && order.total>0) {
    $('#payButton').removeClass('disabled');
  } else {
    $('#payButton').addClass('disabled');
  }
}

function payOrder() {
  $('#charge').val(0);
  $('#change').val(0);

  $('#paymentModal').modal('show');

  showPaymentInfo();
}

function sendOrder() {
  var order = getOrder();
  order.charge = $('#charge').val();

  $.post('/order', order, function(data){
      if (data == '0') {
          emptyOrder();
          $('#paymentModal').modal('hide');

        loadPage("M",0);
      }
  });
}

function emptyOrder() {
  $('#articles-tbody').empty();

  $('#total').val(0);
  $('#charge').val(0);
  $('#change').val(0);

  updateTotalPrice();
  $.get('/display/hello');
}

function addNumber(n) {
  var charge = $('#charge').val();
  if (charge == '0') charge = '';

  $('#charge').val(charge + n);
  showPaymentInfo();
}


function addNote(n) {
  var charge = parseInt($('#charge').val());

  if (!isNaN(charge)) {
    $('#charge').val(charge + n);
  } else {
    $('#charge').val(n);
  }
  showPaymentInfo();
}

function clearNumber(){
  var charge = $('#charge').val();
  charge = charge.substring(0, charge.length - 1);

  $('#charge').val(charge.length ? charge : 0);

  showPaymentInfo();
}

function clearCharge(){
  $('#charge').val(0);
  showPaymentInfo();
}

$(document).ready(function () {
  //$('#paymentModal').modal('show');
  $.get('/display/hello');
  $("#articles-content").load('/articles/M.0');
});


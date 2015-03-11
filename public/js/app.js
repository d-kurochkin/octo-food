function article(code) {
  return $('#article-' + code);
}

function loadPage(category, page) {
  $("#articles-content").load('/articles/' + category + '.' + page);
}

function addArticle(name, code, price) {
  if (article(code).length == 0) {
    console.log(name, code, price)
  } else {
    console.log(name, code, price);
  }
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
  //$.get('/display/hello');
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
  //$.get('/display/hello');
  $("#articles-content").load('/articles/M.0');
});


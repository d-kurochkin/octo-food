function emptyCharge() {
  localStorage.setItem('charge', '0');
  updateChargeState('0');
}

function getCharge() {
  return localStorage.getItem('charge') || '0';
}

function setCharge(charge) {
  localStorage.setItem('charge', charge);
  updateChargeState(charge);
}

function updateChargeState(charge) {
  mountedPaymentWindow.setState({charge: parseInt(charge)});
}

function chargeAddNumber(num) {
  var charge = getCharge();
  setCharge(charge + num);
}

function chargeAddNote(num) {
  var charge = parseInt(getCharge());
  setCharge(charge + parseInt(num));
}

function chargeRemoveNumber() {
  var charge = getCharge();
  if (charge.length > 1) {
    charge = charge.substring(0, charge.length - 1);
  } else {
    charge = '0';
  }

  setCharge(charge);
}

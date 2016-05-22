$(document).ready(function () {
  toggleFields();
  $('#social_worker').change(function () {
    toggleFields();
  });
});

function toggleFields() {
  if ($("#social_worker").val() == "false") {
    $('#link_access').hide();
    alert("Thank you again for your feedback! Please return this device to your social worker.");
  } else {
    $('#link_access').show();
  }
}

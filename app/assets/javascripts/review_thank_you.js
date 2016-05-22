$(document).ready(function () {
  $('#link_access').hide();
  $('#social_worker_access').change(function () {
    showFields();
  });
});

function showFields() {
  if ($("#social_worker_access").val() === "true") {
    $('#link_access').show();
  } else {
    $('#link_access').hide();
    alert("Thank you again for your feedback! Please return this device to your social worker.");
  }
}

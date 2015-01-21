$(function() {
  return $("#like_button").on("ajax:success", function(e, data, status, xhr) {
    $("#votes").html(data.count_votes);
  });
});

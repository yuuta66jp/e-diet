document.addEventListener("turbolinks:load", function() {
  $(function() {
    $("#height").change(function() {
      $('.green').remove();
      var height = $("#height").val();
      var result = (height / 100) * (height / 100) * 22;
      var weight = Math.round(result);
      $("#text").after("<p class='green'>あなたの適正体重は" + weight + "kgです！<br>無理の無いダイエットを心がけよう！</p>");
    });
  });
})

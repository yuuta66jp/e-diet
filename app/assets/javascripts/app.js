// 適正体重表示
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

// ソート機能
document.addEventListener("turbolinks:load", function() {
  $(function() {
    $("select[name=sort]").change(function() {

      var value = $(this).val();

      if (value == "new") {
        url = "?utf8=✓&sort=new"
      } else if (value == "point") {
        url = "?utf8=✓&sort=point"
      } else if (value == "diary") {
        url = "?utf8=✓&sort=diary"
      } else if (value == "follower") {
        url = "?utf8=✓&sort=follower"
      } else {
        url = ""
      };

      var current_url = window.location.href;
      // ソート機能の重複禁止
      if (location["href"].match(/\?utf8=*.+/) != null) {
        // ?utf8=以下を取得
        var remove = location["href"].match(/\?utf8=*.+/)
        // ?utf8=以下を削除し重複を防止
        var current_url = current_url.replace(remove, "")
      };
      
      window.location.href = current_url + url
    });
    
    $(function() {
      if (location["href"].match(/\?utf8=*.+/) != null) {
        if ($("select option[selected]")) {
          // propメソッドにてoption[selected]を無効化
          $("select option:first").prop("selected", false);
        }
        // urlの&sort=以下を取得し、replaceメソッドにて&sort=を削除し値を取得
        var selected_option = location["href"].match(/&sort=*.+/)[0].replace("&sort=", "");
  
        if(selected_option == "new") {
          var sort = 1
        } else if (selected_option == "point") {
          var sort = 2
        } else if (selected_option == "diary") {
          var sort = 3
        } else if (selected_option == "follower") {
          var sort = 4
        }
  
        var add_selected = $("select[name=sort]").children()[sort]
        $(add_selected).attr("selected", true)
      }
    });
  });
})

// ハンバーガーメニュー
document.addEventListener("turbolinks:load", function() {
  $(function() {

    var show = document.getElementById('show');
    var hide = document.getElementById('hide');
    var menu = document.getElementById('menu');
    var element = document.getElementById('target');
    var html = document.documentElement;

  
    show.addEventListener('click', function() {
      document.body.className = 'menu-open';
      element.style.overflow = 'visible';
      html.style.position = 'fixed';
    });
  
    hide.addEventListener('click', function() {
      document.body.className = '';
      element.style.overflow = '';
      html.style.position = '';
    });

    menu.addEventListener('click', function() {
      html.style.position = '';
    });
  });  
})

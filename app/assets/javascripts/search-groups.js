var timer;
  function showSearch()
  {
    $('#buscarGrupo').stop();
    $('#buscarGrupo').css("border-width","1px");
    $('#buscarGrupo').css("padding-left","10px");
    $('#buscarGrupo').css("padding-right","10px");
    $('#buscarGrupo').css("padding-top","5px");
    $('#buscarGrupo').css("padding-bottom","5px");
    $('#buscarGrupo').animate( { width: "150px" }, 400 );
  }
  function hideSearch()
  {
      $('#buscarGrupo').stop();
      $('#buscarGrupo').animate( { width: "0px",padding: "0",borderWidth: "0px"}, 400 );
      setTimeout(function(){if($("#btnSearch").is(":focus")){$("#btnSearch").click();}},50);
  }
  function filtreElements()
  {
    var url=AddUrlParameter(window.location.href,"search",document.getElementById('buscarGrupo').value,true)
    window.location=url;
  }
  function AddUrlParameter(sourceUrl, parameterName, parameterValue, replaceDuplicates)
{
    if ((sourceUrl == null) || (sourceUrl.length == 0)) sourceUrl = document.location.href;
    var urlParts = sourceUrl.split("?");
    var newQueryString = "";
    if (urlParts.length > 1)
    {
      var parameters = urlParts[1].split("&");
      for (var i=0; (i < parameters.length); i++)
      {
        var parameterParts = parameters[i].split("=");
        if (!(replaceDuplicates && parameterParts[0] == parameterName))
        {
          if (newQueryString == "")
            newQueryString = "?";
          else
            newQueryString += "&";
          newQueryString += parameterParts[0] + "=" + parameterParts[1];
        }
      }
    }
    if (newQueryString == "")
      newQueryString = "?";
    else
      newQueryString += "&";
    newQueryString += parameterName + "=" + parameterValue;

    return urlParts[0] + newQueryString;
}
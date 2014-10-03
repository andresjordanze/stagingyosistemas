function getImagesForAttachedFiles()
{
	var img_types = ["avi","css","doc","docx","gif","html","htm","jpg","js","mp3","mp4","mpg","pdf","php","png","ppt","pptx","rar",
	"rb","txt","wav","wmv","xls","xlsx","zip"];
	var images = document.getElementsByClassName("attachment-img");
	for (var i = 0; i < images.length; ++i) {
		var item = images[i];  
		if($.inArray(item.getAttribute("file-type"), img_types) > -1)
		{
			item.src = '/assets/filetypes/'+item.getAttribute("file-type")+".png";
		}
	}
}
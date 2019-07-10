$('#micropost_picture').bind('change', function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > Settings.max_img_size) {
    alert(I18n.t('alert.max_img_size2'));
  }
});

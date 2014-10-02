$(document).ready( function(){
  $('input[name="approved_status"]').on('click', function(){
    var id = this.getAttribute('data-id')
    var value = this.value
    $.ajax({
      url: "/admin/testimonial/"+id,
      type: "PUT",
      data: { value: value }
    });
  });
});

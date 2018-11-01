function dropdown(){
var dropdown = document.querySelector('.dropdown');
dropdown.addEventListener('click', function(event) {
  event.stopPropagation();
  dropdown.classList.toggle('is-active');
});
}
$(document).ready(function(){
		$('.text_container').addClass("hidden");

		$('.text_container').click(function() {
			var $this = $(this);

			if ($this.hasClass("hidden")) {
				$(this).removeClass("hidden").addClass("visible");

			} else {
				$(this).removeClass("visible").addClass("hidden");
			}
		});
	});
$(document).ready(function() {
	$(".text_container").hover(
    function() {
       $(this).children('.blurb').slideDown(); //you also can use .show();
    },
    function(){
       $(this).children('.blurb').slideUp(); //you also can use .hide();
    });
});    

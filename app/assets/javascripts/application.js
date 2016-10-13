// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require moment.min
//= require bootstrap-sprockets
//= require pagedown_bootstrap
//= require pagedown_init
//= require bootstrap-tagsinput
//= require typeahead.bundle
//= require bootstrap-datetimepicker.min
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {

	$('#agree-checkbox').change(function() {
		if($(this).is(':checked')) {
			$("#btn-create-paper").removeClass('disabled');
		} else {
			$("#btn-create-paper").addClass('disabled');
		}
	});
});

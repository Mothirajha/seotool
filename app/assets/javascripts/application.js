// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.dataTables.min.js
//= require_tree .

$(function(){
  $('#queries').dataTable({"columnDefs": [ { "targets": 3, "orderable": false } ]});
});

$(function(){
  $('#position').dataTable();
});
function prepSelect(sourObj,destSel,hit,query)
{ 
  var itemId = sourObj.options[sourObj.selectedIndex].value;
  var urlTo = hit + itemId;
  selectUpdate(itemId,urlTo,destSel,query);
}

function selectUpdate(itemId,urlTo,destSel,query){
  if (itemId.length != 0){

    $(destSel).fadeOut(1000);
    $.ajax({
      url: urlTo,
      type: 'GET',
      dataType: "JSON",
      success: function( json ) {
        if (json == "") {  alert("No Data is configured"); }
        $(destSel).empty();
        $(destSel).append('<option value= selected="selected">-choose-</option>');
        $.each(json, function(i,value) {
          $(destSel).append($('<option>').text(eval("value." + query)).attr('value', value.id));
        });
      }
    });
    $(destSel).fadeIn(500);
  }
}

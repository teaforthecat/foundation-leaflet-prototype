//= require jquery
//= require jquery_ujs
// require turbolinks // having some trouble with foundation
//= require foundation
//= require ckeditor-jquery
//= require eventsource
//= require notification


// NOTE: other init strategies break foundation/turbolinks integration
// $(document).on('ready',
//                function(){
//                    $(document).foundation();
//                }
// );

$(function(){
        $(document).foundation();
});

$('.ckeditor').ckeditor({
  // optional config
  toolbarGroups: [
        { name: 'links' },
        { name: 'basicstyles' },
        { name: 'colors' }
    ]
});

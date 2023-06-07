$(function() {
        $.ajax({
            url: '/getWish',
            type: 'GET',
            success: function(res) {
                var div = $('<div>')
                    .attr('class', 'list-group')
                    .append($('<a>')
                        .attr('class', 'list-group-item active')
                        .append($('<h4>')
                            .attr('class', 'list-group-item-heading'),
                            $('<p>')
                            .attr('class', 'list-group-item-text')));
                var wishObj = JSON.parse(res);

                var wish = '';
 
                $.each(wishObj, function(index, value) {
                    wish = $(div).clone();
                    $(wish).find('h4').text(value.Title);
                    $(wish).find('p').text(value.Description);
                    $('.jumbotron').append(wish);
                });
            },
            error: function(error) {
                console.log(error);
            }
        });
});

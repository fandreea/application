$(document).ready(function () {
    $('.busy, .personal').tooltip({html: true});

    $('.selectpicker').selectpicker({
        size: 12
    });

    $('.datepicker').datepicker({
        dateFormat: 'dd-mm-yy'
    }).change(function () {
        window.location.assign('/reservation/show/' + $(this).val());
    });

    $('.submit-button').click(function (e) {
        var err = '';

        if (parseInt($('#end_time').val()) <= parseInt($('#start_time').val())) {
            err += 'The end time must be higher than the start time<br />'
        }

        if ($('#comment').val().length == 0) {
            err += 'Please enter a comment<br />';
        }

        if (err.length > 0) {
            e.preventDefault();
            e.stopPropagation();
            $('.invalid-time').html(err).removeClass('hidden');
        }
    });

    $('.personal').click(function () {
        if ($(this).hasClass('marked')) {
            $(this).removeClass('marked');
            $('.delete-button').addClass('disabled');
        } else {
            $('.marked').removeClass('marked');
            $('.delete-button').removeClass('disabled');
            $(this).addClass('marked');
        }
    });

    $('.delete-button').click(function () {
        if (!$(this).hasClass('disabled')) {
            window.location.assign('/reservation/delete/' + $('.marked').data('id') + '/' + $('#date').val());
        }
    });

    $('.delete-room-button').click(function () {
            window.location.assign('/reservation/deleteroom/' + $('#room_name').val());
    });

     $('.add-room-button').click(function () {
        if ($('#room_name_add').val().length == 0) {
            $('.invalid-name').removeClass('hidden');
        } else {
            window.location.assign('/reservation/addroom/' + $('#room_name_add').val());
        }
    });


});

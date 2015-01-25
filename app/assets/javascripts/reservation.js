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
        if (parseInt($('#end_time').val()) <= parseInt($('#start_time').val())) {
            e.preventDefault();
            e.stopPropagation();
            $('.invalid-time').removeClass('hidden');
        }
    });

    $('.personal').click(function () {
        if ($(this).hasClass('marked')) {
            $(this).removeClass('marked');
            $('.delete-button').addClass('disabled');
            console.log('nobody to delete');
        } else {
            $('.marked').removeClass('marked');
            $('.delete-button').removeClass('disabled');
            $(this).addClass('marked');
            console.log('we got one sir');
        }
    });

    $('.delete-button').click(function () {
        if (!$(this).hasClass('disabled')) {
            window.location.assign('/reservation/delete/' + $('.marked').data('id') + '/' + $('#date').val());
        }
    });
});

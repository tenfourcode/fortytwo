var FortyTwo = function() {
    
}

var ft = {
    interval: null,
    task: null,
    start: null,
    end: null,
    
    startTimer: function(task) {
        ft.task = task;
        ft.start = Math.round(new Date().getTime() / 1000);
        ft.updateTimer();
        ft.interval = setInterval('ft.updateTimer()', 1000 )
    },
    updateTimer: function() {
        var time = Math.round(new Date().getTime() / 1000);
        diff = time - ft.start;
        ft.task['value'] = diff;
        ft.task.innerHTML = diff;
    },
    stopTimer: function() {
        window.clearInterval(ft.interval);
    }
    
}

$(document).ready(function(){

    $('.btn_l,.save').live('click', function(e){
        /* New Form for Object */
        var data = $("#insert_form :input").serialize();
        $.post( '/elements/save', data,
            function(data) {
                console.info(data);
            });
    });
    
    $('li span.btn_add').live('click', function(e){
        count = $(this).parent().parent().children().length;
        $(this).parent().after('<li><input name="keyvalue['+count+'][key]" class="small" /><input name="keyvalue['+count+'][value]" class="large" /><span class="btn_add">+</span></li>');
    });
    
    $('#searchfield').keyup(function(){
        $.post( '/search', {
            search: $(this).attr('value'), 
            time: "2pm"
        },
        function(data) {
            ul = document.createElement('ul');
            
            for (var i in data) {
                result = data[i];
                li = document.createElement('li');
                str = ''
                /* for (field in result.fields) {
                    str += '<span>' + field + '</span> '+result.fields[field];
                } */
                str += '<span>title</span> '+result['title'];
                li.innerHTML = str;
                ul.appendChild(li);   
            }
            
            $('.search_result').html(ul);
        });
    });
    
    /*
    $('.navigation li').live('click', function(e) {
        path = $(this).attr('id');
        $.get( path, {}, function(data) {
            $('.middle').html(data);
        });
    });
    */
});
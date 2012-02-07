var FortyTwo = function() {
    
}

var ft = {
    interval: null,
    task: null,
    start: null,
    start_time: null,
    end: null,
    
    startTimer: function(task) {
        ft.task = task;
        ft.start = Math.round(new Date().getTime() / 1000);
        ft.start_time = new Date().getTime();
        ft.updateTimer();
        ft.interval = setInterval('ft.updateTimer()', 1000 )
    },
    updateTimer: function() {
        var time = Math.round(new Date().getTime() / 1000);
        diff = time - ft.start;
        ft.task['value'] = diff;
        ft.task.innerHTML = ft.prettifyTime(diff);
    },
    stopTimer: function() {
        var data = $("#task_auto :input").serialize();
        data += '&task[start_time]='+ft.start_time;
        data += '&task[end_time]='+new Date().getTime();
        
        $.post( $("#task_auto").attr('action'), data,
            function(data) {
                window.clearInterval(ft.interval);
                $('.results').append(data.title);
            });
    },
    prettifyTime: function(time) {
        if (time > 60) {
            mod = time%60;
            min = (time-mod)/60;
            return min+':'+mod;
        } else {
            return '0:'+diff;
        }
    }
    
}

$(document).ready(function(){

    $('#worklet').submit(function(e){
        e.preventDefault();
        
        $.each($('input[name$="key"]'), function(index,key) {
            $(key).parent().children('input[name$="value"]').attr('name', 'worklet['+$(key).attr('value')+']');   
        });
        
        var data = $("#worklet :input").serialize();
        $.post( '/elements/save', data,
            function(data) {
                console.info(data);
            });
    });
    
    $('li span.btn_add').live('click', function(e){
        count = $(this).parent().parent().children().length;
        $(this).parent().after('<li><input name="key" class="small" /><input name="value" class="large" /><span class="btn_add">+</span></li>');
    });
    
    $('#task_auto').submit(function(e) {
        e.preventDefault();
        
        
        return false;
    });
    
    $('#task_manual').submit(function(e) {
        e.preventDefault();
        var data = $("#task_manual :input").serialize();
        
        $.post( $(this).attr('action'), data,
            function(data) {
                $('.results').append(data.title);
            });
        
        return false;
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
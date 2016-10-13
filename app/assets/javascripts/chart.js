(function() {
    $(document).ready(function() {
        var $el, labels, series, options, type;
        var createChart = function(index, el) {
            $el = $(el);
            type = $el.data('type');
            labels = $el.data('labels');
            series = $el.data('series');
            options = $el.data('options');

            switch(type) {
                case 'pie':
                    new Chartist.Pie(el, {labels: labels, series: series}, options);
                    break;
            }
        }
        $(".ct-chart").each(createChart);
    });
}());


//New User Count
var randomScalingFactor = function() {
    return Math.round(Math.random() * 100);
};

const label = ['AM 00','AM 01','AM 02','AM 03','AM 04','AM 05','AM 06','AM 07','AM 08','AM 08','AM 10','AM 11','AM 12','PM 13','PM 14','PM 15', 'PM 16', 'PM 17', 'PM 18', 'PM 19', 'PM 20', 'PM 21', 'PM 22', 'PM 23'];
const data = [
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor(),
    randomScalingFactor()
];
const nu_label = ['Existing User', 'Today',];
const pm_label = ['PC', 'Mobile',];
const hq_label = ['Homepage', 'QR', 'KakaoTalk'];
const li_label = [''];

function draw_charts(date_label, tm_data, au_data, nu_data, pm_data, hq_data, li_data) {
    remove_canvas();
    make_canvas();
    draw_chart("totalMessagesPerHour", get_line_chart_data(date_label, tm_data));
    draw_chart("activeUsersPerHour", get_line_chart_data(date_label, au_data));
    draw_chart("newUserCount", get_doughnut_chart_data(nu_label, nu_data));
    draw_chart("pcMobileCount", get_doughnut_chart_data(pm_label, pm_data));
    draw_chart("hpQrCount", get_doughnut_chart_data(hq_label, hq_data));
    draw_chart("linkCount", get_doughnut_chart_data(li_label, li_data));
    draw_char_sum_num(nu_data, pm_data, hq_data);
}

function remove_canvas() {
    $("canvas").remove();
}

function make_canvas() {
    $("#dir_totalMessagesPerHour").append('<canvas id="totalMessagesPerHour"></canvas>')
    $("#dir_activeUsersPerHour").append('<canvas id="activeUsersPerHour"></canvas>')
    $("#dir_categoryCount").append('<canvas id="categoryCount"></canvas>')
    $("#dir_channelCount").append('<canvas id="channelCount"></canvas>')
}
function make_map(country_data){
//	$('#map1').vectorMap({
//        map: 'world_mill_ko',
//        // panOnDrag: true,
//        zoomOnScroll: false,
//        regionStyle: {
//            initial: {
//                fill: '#f4f3ff'
//            },
//        },
//        focusOn: {
//            x: 0.5,
//            y: 0.5,
//            scale: 0,
//            animate: true
//        },
//        series: {
//            regions: [{
//                // [D] scale이 아닌 접속자 수에 따른 색상 변화가 필요합니다.
//                values: country_data,
//                scale: ['#FFE2E2', '#710000'],
//                normalizeFunction: 'polynomial'
//            }]
//        },
//        onRegionTipShow: function(e, el, code){
//            if (country_data[code] === undefined) {
//                country_data[code] = 0;
//            }
//            el.html(el.html()+' (Count : '+country_data[code]+')');
//        }});
//    $('.jvectormap-container').css({'background-color' : 'rgb(255,255,255)'});
}


function draw_char_sum_num(nu_data, pm_data, hq_data, li_data) {
    let nu_sum = nu_data.reduce((a, b) => a + b);
    let pm_sum = pm_data.reduce((a, b) => a + b);
    let hq_sum = hq_data.reduce((a, b) => a + b);
    let li_sum = li_data.reduce((a, b) => a + b);
    $("#nu_sum").text(nu_sum);
    $("#pm_sum").text(pm_sum);
    $("#hq_sum").text(hq_sum);
    $("#li_sum").text(li_sum);
}

function draw_chart(eleId, chart_data) {
     let ctx = document.getElementById(eleId).getContext('2d');
    window.myLine = new Chart(ctx, chart_data);
}


function get_line_chart_data(labels, data) {
    return {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Total',
                backgroundColor: 'rgba(215,46,46,1.0)',
                borderColor: 'rgba(215,46,46,1.0)',
                data: data,
                fill: false
            }]
        },
        options: {
            maintainAspectRatio: false,
            responsive: true,
            title: {
                display: false,
            },
            tooltips: {
                mode: 'index',
                intersect: false,
            },
            hover: {
                mode: 'nearest',
                intersect: true
            },
            scales: {
                xAxes: [{
                    display: true,
                    scaleLabel: {
                        display: false,
                        labelString: 'Time'
                    },
                    ticks: {
                        autoSkip: true,
                        maxRotation: 0,
                        minRotation: 0
                    }
                }],
                yAxes: [{
                    display: true,
                    scaleLabel: {
                        display: false,
                        labelString: 'Value'
                    },
                    ticks: {
                    	beginAtZero:true,
                    }
                }]
            }
        }
    };
}

function get_doughnut_chart_data(labels, data) {
	var splitLabel = [];
	for (var i = 0; i < labels.length; i++) {
		if(labels[i].split("/").reverse()[0] != ""){
			splitLabel.push(labels[i].split("/").reverse()[0]);
		}else{
			splitLabel.push(labels[i].split("/").reverse()[1]);
		}
	}
	
	
    return {
        type: 'doughnut',
        data: {
            labels: splitLabel,
            datasets: [{
                data: data,
                backgroundColor: [
                    'rgba(215,46,46,1.0)',
                    'rgba(239,132,46,1.0)',
                    'rgba(102,204,102,1.0)',
                    'rgba(153,051,153,1.0)',
                    'rgba(204,153,000,1.0)',
                    'rgba(102,051,255,1.0)',
                    'rgba(000,102,102,1.0)',
                ]
            }]
        },
        options: {
            maintainAspectRatio: false,
            responsive: true,
            legend: {
                position: 'right',
                align: 'middle'
            },
            tooltips: {
            	mode: 'label',
                callbacks: {
                	label: function(tooltipItem, data) {
                		var indice = tooltipItem.index;
                		return  labels[indice] +': '+data.datasets[0].data[indice] + '';
                  }
                }
            }
        }
    };
}
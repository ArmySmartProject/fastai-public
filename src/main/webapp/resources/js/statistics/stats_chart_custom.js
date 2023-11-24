function canvas_refresh(){
    $("canvas").remove();
    $("#sendChartDiv").append('<canvas id="sendResultChart" width="360" height="60"></canvas>');
    $("#dialChartDiv").append('<canvas id="dialResultChart" width="360" height="60"></canvas>');
    $("#campChartDiv").append('<canvas id="campResultChart" width="360" height="60"></canvas>');

    $("#sendResultDiv").append('<canvas id="sendResultCountChart" width="360" height="60"></canvas>');
    $("#dialResultDiv").append('<canvas id="dialResultCountChart" width="360" height="60"></canvas>');
    $("#campResultDiv").append('<canvas id="campResultCountChart" width="360" height="60"></canvas>');
    $("#sendResultLineDiv").append('<canvas id="sendResultLineChart"></canvas>');
    $("#callResultLineDiv").append('<canvas id="callResultLineChart"></canvas>');
    $("#campResultLineDiv").append('<canvas id="campResultLineChart"></canvas>');
}
function draw_chart(eleId, chart_data) {
    let ctx = document.getElementById(eleId).getContext('2d');
    window.myLine = new Chart(ctx, chart_data);
}

function get_horizontal_chart_data(data) {
    data[0].backgroundColor = '#3498DB';
    data[1].backgroundColor = '#4FBFFF';
    data[0].borderColor = '#3498DB';
    data[1].borderColor = '#4FBFFF';
    data[0].borderWidth = 3;
    data[1].borderWidth = 3;
    data[0].barThickness = 34;
    data[1].barThickness = 34;

    var sumData = parseInt(data[0].data) + parseInt(data[1].data);
    return{
        type: 'horizontalBar',
        data: {
            labels: [],
            datasets: data,
        },
        options: {
            tooltips: {
                enabled: false
            },
            hover: {
                animationDuration: 0
            },
            responsive: false,
            maintainAspectRatio: false,
            scales: {
                xAxes: [{
                    display: false,
                    ticks: {
                        beginAtZero: true,
                        fontFamily: "'Open Sans Bold', sans-serif",
                        fontSize: 10,
                        max: sumData
                    },
                    scaleLabel: {
                        display: false
                    },
                    gridLines: {
                        display: false,
                    },
                    stacked: true
                }],
                yAxes: [{
                    display: false,
                    gridLines: {
                        display: false,
                        color: "#fff",
                        zeroLineColor: "#fff",
                        zeroLineWidth: 0
                    },
                    ticks: {
                        fontFamily: "'Open Sans Bold', sans-serif",
                        fontSize: 10
                    },
                    stacked: true
                }]
            },
            legend: {
                position: 'top',
                align: 'center',
                display: true,
                labels: {
                    fontSize: 11,
                    boxWidth: 10
                },
                onClick: (e) => e.stopPropagation()
            },
            animation: {
                onComplete: function () {
                    var chartInstance = this.chart;
                    var ctx = chartInstance.ctx;
                    ctx.textAlign = "center";
                    ctx.font = "14px Open Sans";
                    ctx.fillStyle = "#fff";   // 텍스트 폰트 칼라
                    var xAxis = this.chart.scales['x-axis-0'];
                    Chart.helpers.each(this.data.datasets.forEach(function (dataset, i) {
                        var meta = chartInstance.controller.getDatasetMeta(i);
                        Chart.helpers.each(meta.data.forEach(function (bar, index) {
                            data = dataset.data;
                            if (data != 0) {
                                if (i == 0) {
                                    ctx.fillText(data, 40, bar._model.y - 6);
                                    ctx.fillText(Math.round(data / sumData * 100, 1) + '%', 40, bar._model.y + 7);
                                } else {
                                    ctx.fillText(data, bar._model.x - 20, bar._model.y - 6);
                                    ctx.fillText(Math.round(data / sumData * 100, 1) + '%', bar._model.x - 20, bar._model.y + 7);
                                }
                            }
                        }), this)
                    }), this);
                }
            },
            pointLabelFontFamily: "Quadon Extra Bold",
            scaleFontFamily: "Quadon Extra Bold",
        }/* option */
    };
}

function get_line_chart_data(data, type) {
    var yAxesPercentDisplayYn = false;
    $.each(data.datasets, function(i, v){
        if(i == 0){
            v.yAxisID = 'A';
            // v.backgroundColor = '#4fbfff';
            v.order = 3;
        }else if(i == 1){
            v.yAxisID = 'A';
            // v.backgroundColor = '#8497b0';
            v.order = 2;
        }else if(i == 2){
            yAxesPercentDisplayYn = true;
            v.type = 'line';
            v.yAxisID = 'C';
            v.borderColor = 'rgb(255, 99, 132)';
            // v.backgroundColor = '#ff0000';
            v.lineTension = 0.1;
            v.fill = false;
            v.order = 1;
        }
    });
    return {
        type: 'bar',
        data: {
            labels: data.labels,
            datasets: data.datasets.reverse(),
        },
        options: {
            animation: {
                duration: 500,
                onComplete: function () {
                    // render the value of the chart above the bar
                    let arrModelY = []
                    var yAxis = this.chart.scales['A'];
                    this.data.datasets.forEach(function (dataset) {
                        for (let i = 0; i < dataset.data.length; i++) {
                            arrModelY[i] = Math.round(yAxis.bottom);
                        }
                    })

                    var ctx = this.chart.ctx;
                    // console.log('ctx_height', this.chart.height)
                    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
                    ctx.fillStyle = this.chart.config.options.defaultFontColor;
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'bottom';
                    this.data.datasets.forEach(function (dataset, n) {
                        //label 클릭시 데이터text hide show 체크
                        if(dataset._meta[Object.keys(dataset._meta)[0]].hidden != true) {
                            for (let i = 0; i < dataset.data.length; i++) {  //xAxis items
                                let model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
                                if (dataset.yAxisID == "A") {
                                    if (dataset.data[i] != 0) {
                                        let diff = Math.abs(arrModelY[i] - model.y)
                                        arrModelY[i] = model.y
                                        let gap = diff / 2
                                        let model_y = model.y + gap
                                        ctx.save();
                                        if(type == 'sub'){
                                            ctx.translate(model.x + 0, model_y);
                                            ctx.rotate(0 * Math.PI);
                                        }else {
                                            ctx.translate(model.x + 7, model_y);
                                            ctx.rotate(-0.5 * Math.PI);
                                        }
                                        ctx.fillStyle = "black";
                                        ctx.fillText(dataset.data[i], 0, 0);
                                        ctx.restore();
                                    }
                                } else {
                                    let data = dataset.data[i] + "%";
                                    ctx.fillStyle = "red";
                                    if (dataset.data[i] == 0) {
                                        label_gap = -5
                                    } else {
                                        label_gap = 16
                                    }
                                    ctx.fillText(data, model.x, model.y + label_gap);
                                }
                            }
                        }
                    });
                }
            },
            tooltips: {
                displayColors: true,
                callbacks: {
                    mode: 'x',
                    label: function (tooltipItems, data) {
                        var unit = "";
                        if (tooltipItems.datasetIndex == 0) {
                            unit = " %";
                        } else {
                            unit = " 건";
                        }
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + tooltipItems.yLabel + unit;
                    }
                },
            },
            scales: {
                xAxes: [{
                    stacked: true,
                    gridLines: {
                        display: false,
                    }
                }],
                yAxes: [{
                    id: 'A',
                    position: 'left',
                    stacked: true,
                    ticks: {
                        beginAtZero: true,
                        min: 0,
                        precision : 0,
                        callback: function (value, index, values) {
                            if (values[0] > 0) {
                                return value + ' 건';
                            }
                        }
                    },
                    type: 'linear',
                },
                    {
                        id: 'B',
                        position: 'left',
                        display: false,
                        stacked: true,
                        ticks: {
                            beginAtZero: true,
                            min: 0,
                            callback: function (value, index, values) {
                                return value + ' 건';
                            }
                        },
                        type: 'linear',
                    },
                    {
                        id: 'C',
                        position: 'right',
                        stacked: true,
                        display : yAxesPercentDisplayYn,
                        gridLines: {
                            display: false,
                        },
                        ticks: {
                            beginAtZero: true,
                            min: 0,
                            stepSize: 10,
                            max:100,
                            callback: function (value, index, values) {
                                return value + ' %';
                            }
                        },
                        type: 'linear',
                    },
                ]
            },
            responsive: true,
            maintainAspectRatio: false,
            legend: {reverse: true, position: type == 'sub' ? 'right':'top', align: type == 'sub' ? 'start':'center', labels: {fontSize: 11, boxWidth: 10},
            },
        }
    };
}


function get_line_chart_dialFail(data) {
    $.each(data.datasets, function(i, v){
        if(i == 0){
            v.yAxisID = 'A';
            v.backgroundColor = '#4FBFFF';
            v.borderColor = '#4FBFFF';
            v.borderWidth = 3;
        }else if(i == 1){
            v.yAxisID = 'A';
            v.backgroundColor = '#8497B0';
            v.borderColor = '#8497B0';
            v.borderWidth = 3;
        }else if(i == 2){
            v.yAxisID = 'A';
            v.backgroundColor = '#A9A9A9';
            v.borderColor = '#A9A9A9';
            v.borderWidth = 3;
        }else if(i == 3){
            v.yAxisID = 'A';
            v.backgroundColor = '#8FBC8F';
            v.borderColor = '#8FBC8F';
            v.borderWidth = 3;
        }
    });

    return {
        type: 'bar',
        data: {
            labels: data.labels,
            datasets: data.datasets,
        },
        options: {
            animation: {
                duration: 500,
                onComplete: function () {
                    // render the value of the chart above the bar
                    let arrModelY = []
                    var yAxis = this.chart.scales['A'];
                    this.data.datasets.forEach(function (dataset) {
                        for (let i = 0; i < dataset.data.length; i++) {
                            arrModelY[i] = Math.round(yAxis.bottom);
                        }
                    })

                    var ctx = this.chart.ctx;
                    // console.log('ctx_height', this.chart.height)
                    ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
                    ctx.fillStyle = this.chart.config.options.defaultFontColor;
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'bottom';
                    this.data.datasets.forEach(function (dataset, n) {
                        //label 클릭시 데이터text hide show 체크
                        if (dataset._meta[Object.keys(dataset._meta)[0]].hidden != true) {
                            for (let i = 0; i < dataset.data.length; i++) {  //xAxis items
                                let model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
                                if (dataset.yAxisID == "A") {
                                    if (dataset.data[i] != 0) {
                                        let diff = Math.abs(arrModelY[i] - model.y)
                                        arrModelY[i] = model.y
                                        let gap = diff / 2
                                        let model_y = model.y + gap
                                        ctx.save();
                                        ctx.translate(model.x + 0, model_y);
                                        ctx.rotate(0 * Math.PI);
                                        ctx.fillStyle = "black";
                                        ctx.fillText(dataset.data[i], 0, 0);
                                        ctx.restore();
                                    }
                                }
                            }
                        }
                    });
                }
            },
            tooltips: {
                displayColors: true,
                callbacks: {
                    mode: 'x',
                    label: function (tooltipItems, data) {
                        var unit = "";
                        unit = " 건";
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + tooltipItems.yLabel + unit;
                    }
                },
            },
            scales: {
                xAxes: [{
                    stacked: true,
                    gridLines: {
                        display: false,
                    }
                }],
                yAxes: [{
                    id: 'A',
                    position: 'left',
                    stacked: true,
                    ticks: {
                        beginAtZero: true,
                        precision : 0,
                        min: 0,
                        callback: function (value, index, values) {
                            if (values[0] > 0) {
                                return value + ' 건';
                            }
                        }
                    },
                    type: 'linear',
                }
                ]
            },
            responsive: true,
            maintainAspectRatio: false,
            legend: {reverse: false, position: 'right', align: 'start', labels: {fontSize: 11, boxWidth: 10},
            },
        }
    };
}
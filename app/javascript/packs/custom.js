//d3 chart

let regex = /\/users\/\d+\/exercises$|\/friendships\/d+$/i;

if($(location).attr("pathname").match(regex)) {
    document.addEventListener('turbolinks:load', () => {
        let ctx = document.getElementById('myChart').getContext('2d');
        let myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: JSON.parse(ctx.canvas.dataset.labels),
                datasets: [{
                    label: 'Exercises',
                    data: JSON.parse(ctx.canvas.dataset.data),
                }]
            },
        });
    })
}
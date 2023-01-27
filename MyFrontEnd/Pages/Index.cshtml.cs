using Dapr.Client;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace MyFrontEnd.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private readonly DaprClient _daprClient;

        public IList<WeatherForecast> Forecasts { get; set; } = default!;
        public IList<Product> Products { get; set; } = default!;

        public IndexModel(ILogger<IndexModel> logger,  DaprClient daprClient)
        {
            _logger = logger;
            _daprClient = daprClient;
        }

        public async Task OnGetAsync()
        {
            var forecasts = await _daprClient.InvokeMethodAsync<IEnumerable<WeatherForecast>>(
                HttpMethod.Get,
                "backend1",
                "weatherforecast"
            );

            Forecasts = forecasts.ToList();

            var products = await _daprClient.InvokeMethodAsync<IEnumerable<Product>>(
                HttpMethod.Get,
                "backend2",
                "product"
            );

            Products = products.ToList();
        }
    }
}
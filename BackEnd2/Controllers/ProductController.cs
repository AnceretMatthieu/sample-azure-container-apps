using Bogus;
using Microsoft.AspNetCore.Mvc;

namespace BackEnd2.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductController : ControllerBase
    {        
        private readonly ILogger<ProductController> _logger;

        public ProductController(ILogger<ProductController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetProduct")]
        public IEnumerable<Product> Get()
        {
            var fakeProduct = new Faker<Product>()
                .RuleFor(m => m.Id, f => Guid.NewGuid())
                .RuleFor(m => m.Reference, f => f.Commerce.Ean13())
                .RuleFor(m => m.Name, f => f.Commerce.ProductName())
                .RuleFor(m => m.Color, f => f.Commerce.Color())
                .RuleFor(m => m.Categories, f => f.Commerce.Categories(f.Random.Int(0, 8)).ToList())
                .RuleFor(m => m.Price, f => f.Commerce.Price());
            var products = fakeProduct.Generate(10);
            return products;
        }
    }
}
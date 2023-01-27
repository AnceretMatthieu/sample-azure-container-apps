namespace BackEnd2
{
    public class Product
    {
        public Guid Id { get; set; } 

        public string Reference { get; set; }

        public string Name { get; set; }

        public string Color { get; set; } 

        public string Price { get; set; }
        
        public List<string> Categories { get; set; }
    }
}
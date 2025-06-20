namespace EcommerceApp.Models
{
    public class Favorite
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string UserId { get; set; }
        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public double Price { get; set; }
        public string ImageUrl { get; set; }
    }
} 
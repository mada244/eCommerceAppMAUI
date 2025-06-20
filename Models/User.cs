namespace EcommerceApp.Models
{
    public class User
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string Email { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public List<string> FavoriteProductIds { get; set; } = new();
        public List<string> OrderIds { get; set; } = new();
    }
} 
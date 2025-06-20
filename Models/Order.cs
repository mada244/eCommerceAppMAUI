using System;
using System.Collections.Generic;

namespace EcommerceApp.Models
{
    public class Order
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string UserId { get; set; }
        public List<CartItem> Items { get; set; } = new();
        public double TotalAmount { get; set; }
        public string Status { get; set; } = "Pending";
        public DateTime OrderDate { get; set; } = DateTime.UtcNow;
        public string ShippingAddress { get; set; }
        public string PhoneNumber { get; set; }
    }
} 
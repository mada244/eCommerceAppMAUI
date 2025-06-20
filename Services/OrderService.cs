using EcommerceApp.Models;
using System.Text.Json;
using System.IO;
using Microsoft.Maui.Storage;

namespace EcommerceApp.Services
{
    public class OrderService
    {
        private string GetFileName(string userId) => Path.Combine(FileSystem.AppDataDirectory, $"orders_{userId}.json");
        private List<Order> _orders = new();
        private string _userId = string.Empty;

        public void LoadOrders(string userId)
        {
            _userId = userId;
            var file = GetFileName(userId);
            if (File.Exists(file))
            {
                var json = File.ReadAllText(file);
                List<Order>? list = JsonSerializer.Deserialize<List<Order>>(json);
                if (list != null)
                    _orders = list;
            }
            else
            {
                _orders = new();
            }
        }

        public List<Order> GetOrders() => _orders;

        public void AddOrder(Order order)
        {
            _orders.Add(order);
            SaveOrders();
        }

        private void SaveOrders()
        {
            if (!string.IsNullOrEmpty(_userId))
            {
                var file = GetFileName(_userId);
                var json = JsonSerializer.Serialize(_orders);
                File.WriteAllText(file, json);
            }
        }
    }
} 
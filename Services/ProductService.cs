using EcommerceApp.Models;
using System.Text.Json;
using System.IO;
using Microsoft.Maui.Storage;

namespace EcommerceApp.Services
{
    public class ProductService
    {
        private static string FileName => Path.Combine(FileSystem.AppDataDirectory, "products.json");
        private List<Product> _products = new();

        public ProductService()
        {
            LoadProducts();
        }

        public List<Product> GetAllProducts() => _products;

        public Product? GetProductById(string id) => _products.FirstOrDefault(p => p.Id == id);

        public void AddProduct(Product product)
        {
            _products.Add(product);
            SaveProducts();
        }

        public void RemoveProduct(string id)
        {
            var product = GetProductById(id);
            if (product != null)
            {
                _products.Remove(product);
                SaveProducts();
            }
        }

        private void LoadProducts()
        {
            if (File.Exists(FileName))
            {
                var json = File.ReadAllText(FileName);
                List<Product>? list = JsonSerializer.Deserialize<List<Product>>(json);
                if (list != null)
                    _products = list;
            }
            else
            {
                _products = new();
            }
        }

        private void SaveProducts()
        {
            var json = JsonSerializer.Serialize(_products);
            File.WriteAllText(FileName, json);
        }
    }
} 
using EcommerceApp.Models;
using Google.Cloud.Firestore;
using System.Collections.ObjectModel;

namespace EcommerceApp.Services
{
    public class FirebaseProductService
    {
        private readonly FirestoreDb _firestoreDb;
        private readonly CollectionReference _productsCollection;

        public FirebaseProductService()
        {
            try
            {
                _firestoreDb = FirebaseConfig.GetFirestoreDb();
                _productsCollection = _firestoreDb.Collection("Products");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"FirebaseProductService initialization error: {ex.Message}");
                throw;
            }
        }

        public async Task<List<Product>> GetAllProductsAsync()
        {
            try
            {
                var snapshot = await _productsCollection.GetSnapshotAsync();
                var products = new List<Product>();

                foreach (var document in snapshot.Documents)
                {
                    var product = document.ConvertTo<Product>();
                    product.Id = document.Id;
                    products.Add(product);
                }

                if (!products.Any())
                {
                    await AddSampleProductsAsync();
                    return await GetAllProductsAsync(); 
                }

                return products;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting products: {ex.Message}");
                return new List<Product>();
            }
        }

        private async Task AddSampleProductsAsync()
        {
            var sampleProducts = new List<Product>
            {
                new Product
                {
                    Name = "Nike Air Max 270",
                    Description = "Ultra-comfortable running shoes with Air Max technology",
                    Price = 129.99,
                    ImageUrl = "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400",
                    Brand = "Nike",
                    Category = "Shoes",
                    Colors = new List<string> { "Black", "White", "Red" },
                    Sizes = new List<string> { "7", "8", "9", "10", "11" }
                },
                new Product
                {
                    Name = "Adidas Ultraboost 21",
                    Description = "Premium running shoes with Boost midsole technology",
                    Price = 179.99,
                    ImageUrl = "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400",
                    Brand = "Adidas",
                    Category = "Shoes",
                    Colors = new List<string> { "Blue", "Grey", "Black" },
                    Sizes = new List<string> { "7", "8", "9", "10", "11" }
                },
                new Product
                {
                    Name = "Levi's 501 Original Jeans",
                    Description = "Classic straight-leg jeans with authentic fit",
                    Price = 89.99,
                    ImageUrl = "https://images.unsplash.com/photo-1542272604-787c3835535d?w=400",
                    Brand = "Levi's",
                    Category = "Clothing",
                    Colors = new List<string> { "Blue", "Black", "Grey" },
                    Sizes = new List<string> { "30x32", "32x32", "34x32", "36x32" }
                },
                new Product
                {
                    Name = "Apple iPhone 15 Pro",
                    Description = "Latest iPhone with A17 Pro chip and titanium design",
                    Price = 999.99,
                    ImageUrl = "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400",
                    Brand = "Apple",
                    Category = "Electronics",
                    Colors = new List<string> { "Natural Titanium", "Blue Titanium", "White Titanium" },
                    Sizes = new List<string> { "128GB", "256GB", "512GB" }
                },
                new Product
                {
                    Name = "Samsung Galaxy S24",
                    Description = "Premium Android smartphone with AI features",
                    Price = 899.99,
                    ImageUrl = "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400",
                    Brand = "Samsung",
                    Category = "Electronics",
                    Colors = new List<string> { "Onyx Black", "Marble Grey", "Cobalt Violet" },
                    Sizes = new List<string> { "128GB", "256GB", "512GB" }
                },
                new Product
                {
                    Name = "MacBook Air M2",
                    Description = "Ultra-thin laptop with Apple M2 chip",
                    Price = 1199.99,
                    ImageUrl = "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400",
                    Brand = "Apple",
                    Category = "Electronics",
                    Colors = new List<string> { "Space Grey", "Silver", "Starlight" },
                    Sizes = new List<string> { "8GB RAM", "16GB RAM" }
                }
            };

            foreach (var product in sampleProducts)
            {
                await AddProductAsync(product);
            }
        }

        public async Task<Product?> GetProductByIdAsync(string id)
        {
            try
            {
                var document = await _productsCollection.Document(id).GetSnapshotAsync();
                if (document.Exists)
                {
                    var product = document.ConvertTo<Product>();
                    product.Id = document.Id;
                    return product;
                }
                return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting product by id: {ex.Message}");
                return null;
            }
        }

        public async Task<bool> AddProductAsync(Product product)
        {
            try
            {
                await _productsCollection.AddAsync(product);
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error adding product: {ex.Message}");
                return false;
            }
        }

        public async Task<bool> UpdateProductAsync(Product product)
        {
            try
            {
                await _productsCollection.Document(product.Id).SetAsync(product);
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error updating product: {ex.Message}");
                return false;
            }
        }

        public async Task<bool> RemoveProductAsync(string id)
        {
            try
            {
                await _productsCollection.Document(id).DeleteAsync();
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error removing product: {ex.Message}");
                return false;
            }
        }

        public async Task<List<Product>> GetProductsByCategoryAsync(string category)
        {
            try
            {
                var snapshot = await _productsCollection
                    .WhereEqualTo("Category", category)
                    .GetSnapshotAsync();
                
                var products = new List<Product>();
                foreach (var document in snapshot.Documents)
                {
                    var product = document.ConvertTo<Product>();
                    product.Id = document.Id;
                    products.Add(product);
                }

                return products;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting products by category: {ex.Message}");
                return new List<Product>();
            }
        }

        public async Task<List<Product>> SearchProductsAsync(string searchTerm)
        {
            try
            {
                var allProducts = await GetAllProductsAsync();
                return allProducts.Where(p => 
                    p.Name.ToLower().Contains(searchTerm.ToLower()) ||
                    p.Description.ToLower().Contains(searchTerm.ToLower()) ||
                    p.Brand.ToLower().Contains(searchTerm.ToLower())
                ).ToList();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error searching products: {ex.Message}");
                return new List<Product>();
            }
        }
    }
} 
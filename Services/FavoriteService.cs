using EcommerceApp.Models;
using System.Text.Json;
using System.IO;
using Microsoft.Maui.Storage;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EcommerceApp.Services
{
    public class FavoriteService
    {
        private string GetFileName(string userId) => Path.Combine(FileSystem.AppDataDirectory, $"favorites_{userId}.json");
        private List<Favorite> _favorites = new();
        private string _userId = string.Empty;
        private FirebaseAuthService _authService = new FirebaseAuthService();

        public FavoriteService() {}

        public async Task LoadFavoritesAsync(string userId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot load favorites: UserId is null or empty");
                return;
            }

            _userId = userId;
            try
            {
                // Pentru moment, folosim doar local storage
                // TODO: Implement Firebase integration when needed

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading favorites: {ex.Message}");
                
            }
        }

        public async Task LoadFavoritesForCurrentUserAsync()
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot load favorites: User is not authenticated");
                return;
            }

            await LoadFavoritesAsync(_authService.UserId);
        }

        
        public List<Favorite> GetFavorites() => _favorites;

        public async Task AddToFavoritesAsync(string userId, string productId, string productName, double price, string imageUrl)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot add to favorites: UserId is null or empty");
                return;
            }

            await LoadFavoritesAsync(userId);
            var existingFavorite = _favorites.FirstOrDefault(fav => fav.ProductId == productId);
            if (existingFavorite == null)
            {
                var newFavorite = new Favorite
                {
                    ProductId = productId,
                    ProductName = productName,
                    Price = price,
                    ImageUrl = imageUrl
                };
                _favorites.Add(newFavorite);
                await SaveFavoritesAsync();
            }
        }

        public async Task AddToFavoritesForCurrentUserAsync(string productId, string productName, double price, string imageUrl)
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot add to favorites: User is not authenticated");
                return;
            }

            await AddToFavoritesAsync(_authService.UserId, productId, productName, price, imageUrl);
        }

        public async Task RemoveFromFavoritesAsync(string userId, string productId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot remove from favorites: UserId is null or empty");
                return;
            }

            await LoadFavoritesAsync(userId);
            var favorite = _favorites.FirstOrDefault(fav => fav.ProductId == productId);
            if (favorite != null)
            {
                _favorites.Remove(favorite);
                await SaveFavoritesAsync();
            }
        }

        public async Task RemoveFromFavoritesForCurrentUserAsync(string productId)
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot remove from favorites: User is not authenticated");
                return;
            }

            await RemoveFromFavoritesAsync(_authService.UserId, productId);
        }

        public bool IsFavorite(string productId)
        {
            return _favorites.Any(fav => fav.ProductId == productId);
        }

        public bool IsUserAuthenticated()
        {
            return _authService.IsAuthenticated;
        }

        public string GetCurrentUserId()
        {
            return _authService.UserId;
        }

        private async Task SaveFavoritesAsync()
        {
            if (!string.IsNullOrEmpty(_userId))
            {
                try
                {
                    // Pentru moment, salvează doar local
                    // TODO: Implement Firebase integration when needed

                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error saving favorites: {ex.Message}");
                }
            }
        }

       
        // Metode pentru compatibilitate cu codul existent

        public void AddToFavorites(string productId, string productName, double price, string imageUrl) => 
            Task.Run(() => AddToFavoritesForCurrentUserAsync(productId, productName, price, imageUrl));
        public void RemoveFromFavorites(string productId) => 
            Task.Run(() => RemoveFromFavoritesForCurrentUserAsync(productId));
    }
} 